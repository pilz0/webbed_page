---
layout: post
title:  "Bericht NixOS"
date:   2024-07-02 10:18:00 -0100
categories: Work Technik
---
Disclaimer: I worte this for a Project at work, so its written pretty simple and basic.

## Einleitung
NixOS ist ein Betriebssystem für Desktop-Computer und Server auf der Basis des Paketmanagers Nix
und Linux. Es zeichnet sich durch seine deklarative Konfiguration aus, die es ermöglicht, das gesamte
System konsistent und reproduzierbar zu verwalten. In diesem Bericht werde ich darauf eingehen was
NixOS so besonders macht und ob wir es in Zukunft auch an der Universität einsetzten sollten.

### Reproduzierbar
Konfigurationseinstellungen in NixOS und Pakete in dem Nix-Packetmanager sind alle Reproduzierbar,
das heißt wenn sie auf einem System funktionieren, werden sie auch auf einem anderen System ohne
Einschränkungen funktionieren. Das ist dadurch möglich, da die Pakete isoliert voneinander
gespeichert werden, nicht wie bei einem normalen Linux in /bin und immer alle dependencies[1]
angegeben sein müssen.

### Deklarativ
Statt wie bei einem normalen Linux-System (beispiel: Arch/Debian) werden System- und
Benutzereinstellungen nicht über Commands festgelegt (Beispiel: ufw allow 80/tcp) sondern über
die Datei Configuration.nix (networking.firewall.allowedTCPPorts = [ 80 ];)

### Wie sieht so eine NixOS Konfiguration aus?
In einer NixOS-Konfiguration können services (z.b. cloudflared), packages (z.b. Microsoft Edge),
options (z.b. ssh mit Passwort) und vieles mehr definiert werden, das alles wird in der
Programmiersprache Nix geschrieben. Beispiel für Tor-Relay [2]:
```
services.tor = { ## Hier wird das Modul ausgewählt.
enable = true; ## Hier wird das Modul aktiviert.
openFirewall = true; ## Die Firewall für die Ports 9001 und 9051 geöffnet
relay = {
enable = true;
role = "relay";
};
settings = {
ContactInfo = "toradmin@example.org";
Nickname = "toradmin";
ORPort = 9001;
ControlPort = 9051;
BandWidthRate = "10 MBytes";
};
};
```
Mit diesem Code würde ziemlich leicht ein Tor-Relay aufgespannt werden, wenn sonst alles richtig
konfiguriert ist.

[1]: Externe Ressourcen und Bibliotheken die ein Programm zum Funktionieren benötigt.
[2]: Ein Router in dem Onion-Netzwerk. Oft “Darknet“ genannt.

## Wie sieht sowas in der Praxis aus?
### Best Practices
Durch die Verwendung von Git [3] ist es möglich, Änderungen an Dateien zu verfolgen und den
Verlauf der Dateiänderungen nachzuvollziehen. Flakes [4] bringen Vorteile beim Versionsmanagement
mit sich oder es können mit ihnen eigene Projekte von Benutzer*innen leicht geteilt werden, ein
Beispiel für eine Flake ist hier zu finden:
https://github.com/zebreus/besserestrichliste/blob/main/flake.nix. CI/CD-Pipelines können prüfen,
ob die NixOS funktionsfähig ist und sie auch direkt auf den Servern ausrollen, hier ist ein Beispiel für
einen CI/CD-Pipeline für NixOS: https://git.darmstadt.ccc.de/noc/builders-nix/-/blob/main/.gitlab-
ci.yml?ref_type=heads.

### Rollbacks
Angenommen, nach einem Systemupdate treten unerwartete Probleme auf. Mit NixOS können
Benutzer einfach zu einer früheren Systemkonfiguration zurückkehren, indem sie den Befehl 'nixos-
rebuild --rollback switch' verwenden oder beim Starten des Systems eine andere Version
auswählen.

### Sicherheit
Da NixOS anderes als ein Standard-Linux aufgebaut ist, wird viel Malware für Linux nicht
funktionieren. Da in der NixOS-Konfiguration das System definiert können leicht potentielle
Sicherheitslücken gefunden werden. Auch unterstützt NixOS verschiedene Sandboxing-Technologien.

### Migration
Um von einem anderen System auf NixOS zu migrieren, sollen man zuerst alle benötigten Pakete,
Einstellungen, Services, Cronjobs usw... auf dem alten System ausfindig machen und in eine NixOS-
Konfiguration übertragen. Danach kann man diese Konfiguration auf einem Parallelsystem ausrollen
und wenn alles funktioniert das alte System abschalten.

### Automatische Updates
Automatische Updates sind in NixOS sehr einfach. Im folgenden Beispiel wird ein automatisches
Update einmal pro Stunde durchgeführt. Die Flake, in der die Versionen des Systems und zusätzliche
Paketquellen angegeben sind wird auch spezifiziert.
```
system.autoUpgrade = {
enable = true;
dates = "hourly";
flake = "git+https://github.com/pilz0/vps.git";
allowReboot = true;
};
```
[3]: Software welche oft als Source-Code-Management benutzt wird.
[4]: NixOS Flakes sind eine deklarative und reproduzierbare Methode zur Definition von Paketen,
Konfigurationen und Umgebungen in NixOS.

## Fazit
Insgesamt bin ich mit NixOS als System sehr zufrieden, da es mit seinen vielen Paketen, seiner
deklarativen Konfiguration und seiner Reproduzierbarkeit einfach angenehm zu benutzen ist.
Die Implementierung von NixOS könnte viele Vorteile mit sich bringen, darunter
eine verbesserte Systemverwaltung, erhöhte Sicherheit und die Möglichkeit, Systemkonfigurationen
effizient zu teilen und zu skalieren. Es ist zu erwarten, dass NixOS in Zukunft eine wichtige Rolle in
der IT-Infrastruktur von Bildungseinrichtungen spielen wird. Ein Nachteil wäre, dass die Konfiguration
von NixOS sehr speziell ist, Daher können Personen, die noch nicht mit NixOS gearbeitet haben,
zunächst Schwierigkeiten haben, sich damit zurechtzufinden.
