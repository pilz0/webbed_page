---
layout: post
title:  "Bericht Network Adress Translation"
date:   2024-10-31 10:18:00 -0100
categories: Work Technik
---
Disclaimer: I worte this for a Project at work, so its written pretty simple and basic.
###	Einleitung

Ohne NAT (Network Address translation) würde das heutige Internet nicht funktionieren, da wir einfach zu viele Geräte haben, welche ans Internet angeschlossen sind. Auch wäre es gefährlich, wenn zum Beispiel kostengünstige smarte Glühbirnen öffentlich erreichbar wären. In diesem Bericht wird es darum gehen, warum wir NAT brauchen, was NAT ist und wo wir NAT im Alltag benutzen. Auch werde ich auf die Vergangenheit und Zukunft von NAT eingehen. Zum Schluss werde ich noch auf IPv6(Internet Protocol Version 6), CGNAT (Carrier-Grade NAT) und DS-Lite (Dual Stack Lite) eingehen.

### Was ist NAT?

#### Warum brauchen wir NAT?
Leider haben wir nur 4 Milliarden IPv4 {1} Adressen (1), aber deutlich mehr Geräte, die ans Internet angebunden sind, deshalb benutzen wir NAT, um private IP-Adressen in öffentliche IP-Adressen zu übersetzen.

#### Was sind private und öffentliche IP-Adressen?
Der Unterschied zwischen öffentlichen und privaten IP-Adressen ist, das private IP-Adressen nicht über das Internet geleitet werden können (nur über das Heimnetzwerk/interne Netz) und unendlich oft in andren Heimnetzen wiederverwendet werden. Öffentliche IP-Adressen können über das Internet geleitet werden, aber nur auf einem Gerät auf der ganzen Welt gleichzeitig benutzt werden. 

#### Wie funktioniert NAT
Wenn NAT verwendet wird, werden die privaten IP-Adressen in eine oder mehrere öffentliche IP-Adressen übersetzt, aber nur wenn eine Verbindung zum Internet {2} hergestellt wird. Wenn ein Gerät aus dem internen Netz auf das Internet zugreifen will, sendet es die Daten an das NAT/den Router {2}, welcher dann die IP-Adresse und eventuell den Port ändert., sich die Interne Adresse und die externe Adresse (jeweils mit Port) in der NAT-Tabelle merkt und dann die Daten an das Internet rausschickt. Die Grafik unten zeigt, wie NAT funktioniert, auf der linken Seite ist ein Computernetzwerk mit zwei Computern, die hinter einem NAT sind. Auf der linken Seite in der Mitte ist ein Router, welcher NAT verwendet, die gestrichelte Linie zeigt ab welchem Punkt das private und öffentliche Netzwerk beginnt. Auf der rechen Seite ist ein Router mit einem Server, welcher nicht hinter NAT ist. Unten links ist noch eine NAT-Tabelle zu sehen.

#### Arten von NAT

##### PAT (Port Address Translation)
Bei PAT sendet das Gerät die Daten an den Router/das NAT, welches dann Port und IP-Adresse austauscht. Diese Art von NAT wird häufig bei DSL-Anschlüssen im Heimnetzwerk verwendet.

##### SNAT (Static Network Address Translation)
Bei SNAT werden private Adressen manuell an öffentliche Adressen gekoppelt, hier hat jedes Gerät eine eigene öffentliche IP-Adresse. Ports werden hier nicht ausgetauscht.

##### DNAT (Dynamic Network Address Translation)
Bei DNAT werden, ähnlich wie bei SNAT, IP-Adressen eins zu eins zugewiesen; der Unterschied besteht darin, dass dies hier automatisch erfolgt.

#### CGNAT und DS-Lite (Carrier Grade Network Address Translation und Dual Stack Lite)
CGNAT und DS-Lite werden benutzt, um die IPv4 Adressknappheit zu reduzieren, indem sich mehrere Haushalte eine IPv4-Adresse teilen. Die Nachteile von beiden sind das sie es erschweren auf Server zuhause aus dem Internet zuzugreifen.

#### CGNAT
Bei CGNAT wird hinter dem Heimnetzwerk auf ISP-Seite nochmal NAT betrieben, dafür ist der IP-Adressbereich 100.64.0.0/10 reserviert. Dann bekommen mehrere Kunden nur eine öffentliche IP-Adresse. Auch ist CGNAT nicht für IPv6 ausgelegt.

##### DS-Lite
Wenn der ISP (Internet Service Provider) DS-Lite verwendet, wird der IPv6 Traffic ganz normal rausgeleitet, aber IPv4 Traffic geht über einen IPv6-Tunnel zu einem CGNAT. Auf Server im Heimnetz kann extern über IPv6 zugegriffen werden.

### Die Vergangenheit und Zukunft von NAT

#### IPv6 und NAT 
Bei IPv6 wird NAT nicht benötigt, da es 340 Sextillionen (4) IPv6 Adressen gibt.
