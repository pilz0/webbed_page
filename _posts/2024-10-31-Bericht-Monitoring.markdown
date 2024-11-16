---
layout: post
title:  "Basic Monitoring mit Grafana, Prometheus und Unpoller"
date:   2024-10-31 10:18:00 -0100
categories: Work Technik
---
Disclaimer: I worte this for a Project at work, so its written pretty simple and basic.

# Basic Monitoring mit Grafana, Prometheus und Unpoller

### Einleitung

#### Warum brauchen wir überhaupt Monitoring?
In einer Welt voller komplizierter Informationstechnologie-Systeme, Clustern mit hunderten
Microservices und riesigen Rechenzentren geht schnell mal etwas schief. Deshalb ist es gängige Praxis
alle IT-Systeme und Services konstant zu überwachen, dadurch kann man im Notfall sofort eingreifen
und schnell Probleme lösen. In diesem Quartalsbericht werde ich allgemein auf das Thema
„Monitoring“ eingehen, verschiedene Softwarekomponenten eines Monitoring-Stacks erwähnen und
wie man die Sicherheit beim Monitoring erhöhen kann.
#### Was ist Monitoring?

Monitoring umfasst die laufende Überwachung von Vorgängen und Prozessen, wie zum Beispiel die
Temperatur einer Festplatte, in der entsprechenden Systemumgebung auf ihre Funktionalität. Das
übergeordnete Ziel ist, den reibungslosen Betrieb der IT-Infrastruktur sicherzustellen. Dafür muss
Problemen und deren Ursachen vorgebeugt werden. In dem Fall, dass ein Problem auftritt, muss es
frühzeitig erkannt und schnellstmöglich beseitigt werden.

### Verschiedene Softwarekomponenten eines Monitoring-Stacks.
#### Unpoller
Unpoller ist eine Software, welche dafür genutzt wird, Daten aus dem UniFi-Mangement-System zu
exportieren. Dafür wird ein Admin-Account mit Lesezugriffsrechten erstellt. Unpoller ruft die Daten
über die Application Programming Interface (API) des Unifi-Controllers alle 30 Sekunden ab und stellt
diese auf einem Webserver für Prometheus bereit. Ähnliche Exporter1 gibt es auch für alle andere
großen Netzwerkequipmenthersteller.

#### Prometheus
Prometheus ist eine Opensource-Zeitreihendatenbank, die regelmäßig Metriken2 von Unpoller und
anderen Exportern über Hypertext Protocoll (Secure) (HTTP(S)) abruft und speichert. Diese Metriken
werden in Form von Prometheus query language (PromQL3) für Grafana und andere Monitoring-Tools
zur Verfügung gestellt. Darüber hinaus kann Prometheus Alarme an den Alertmanager 4senden, um bei
Fehlfunktionen oder Anomalien rechtzeitig benachrichtigt zu werden.

#### Grafana
Grafana ist eine Opensource-Virtualisierungssoftware, welche Metriken aus (Zeitreihen)-Datenbanken
virtualisieren und aufbereiten kann. Zusätzlich sind viele Plugins verfügbar, um zum Beispiel Metriken
direkt aus Google Analytics zu bekommen. Auch können über Grafana Dashboards mit verschiedenen
Metriken erstellt werden, um alle Daten auf einen Blick zu sehen.

#### Grafana OnCall
Mit Grafana OnCall können, ähnlich wie mit dem Alertmanager, Benachrichtigungen aufgrund
ungewöhnlicher Werte über verschiedene Kanäle (Electronic Mail (E-Mail), Short Messaging Service
(SMS), Slack usw.) versendet werden. Solche Tools benachrichtigen Techniker:innen, wenn
beispielsweise nachts ein System oder Service ausfällt. Zudem können Alarme eskaliert werden, falls
eine Techniker:in nicht reagiert.

#### Best Practices
• Alarme auf kritische Werte setzen
• Bei neuen Services schauen ob schon ein Prometheus-Exporter existiert
• Nach fertigen Grafana-Dashboards für den jeweiligen Service suchen
• Digital Signage Displays mit Grafana-Playlists aufhängen
• Dokumentation der einzelnen Grafana-Dashboards
• Bei großen Installationen über mehrere Prometheus-Instanzen nachdenken.

#### Alternativen zu diesem Monitoring-Stack
Zu Unpoller gibt es Zabbix als Alternative, Zabbix ist eine Opensource-Monitoring-Lösung, die in
diesem Fall Grafana, Prometheus und Unpoller ersetzen würde. Eine Alternative zu Prometheus ist
InfluxDB, ebenfalls eine Open-Source-Zeitreihendatenbank. Der wesentliche Unterschied besteht darin,
dass Prometheus die Daten selbstständig abruft, während bei InfluxDB die Daten aktiv in die
Datenbank eingespielt werden müssen. Zu Grafana gäbe es Datadog als Alternative, Datadog ist eine
Cloud-Monitoring-Lösung, mit dieser können Applikationen, Cloudservices oder auch Server
überwacht werden. Statt Grafana OnCall könnte man (wie oben geschrieben) Prometheus
Alertmanager verwenden.
1 Ein Computerprogramm, welches Metriken aus einem anderen Programm für Prometheus oder ähnliches bereitstellt.
2 Maß, um Leistung von Computersystemen zu messen.
3 Datenformat, in dem Grafana Daten von Prometheus anfragt.
4 Tool, um Alarme von Prometheus oder ähnlichem zu verarbeiten und weiter an Benachrichtigungstools zu senden.

### Hardening und Sicherheit
Da mit den Standarteinstellungen von Prometheus und Unpoller die Metriken ohne Authentifizierung
abrufbar sind, sollten bei Produktivsystemen Sicherheitsmaßnahmen getroffen werden, dies können
zum Beispiel strenge Firewall-Regeln oder Netzwerkisolierung sein. Es sollte auch, wenn
möglich, HTTPS benutzt werden, da sonst alle Metriken unverschlüsselt übertragen werden. Falls bei
Applikationen API-Keys 5erstellt werden sollten bei diesen nur die minimal nötigen Berechtigungen
vergeben werden.

### Fazit
Zusammenfassend lässt sich sagen, dass ein effektives Monitoring in der heutigen komplexen IT-
Landschaft unerlässlich ist, um die Verfügbarkeit und Leistungsfähigkeit von Systemen und Services
sicherzustellen. Die vorgestellten Komponenten eines Monitoring-Stacks – Unpoller, Prometheus,
Grafana und Grafana OnCall – bieten eine robuste Grundlage für die Überwachung und Analyse von
IT-Infrastrukturen. Durch die Implementierung von Best Practices und die Berücksichtigung von
Alternativen können Organisationen ihre Monitoring-Strategien weiter optimieren und anpassen. Ich
persönlich verwende das Monitoring-Stack bestehend aus Unpoller, Prometheus und Grafana selbst in
meiner Freizeit und bin damit ziemlich zufrieden.