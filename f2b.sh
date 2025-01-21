#!/bin/bash
apt install fail2ban make golang rsyslog -y

git clone https://gitlab.com/hctrdev/fail2ban-prometheus-exporter

cd fail2ban-prometheus-exporter

make build

mv fail2ban_exporter /usr/sbin/fail2ban_exporter

mv _examples/systemd/fail2ban_exporter.service /lib/systemd/system/fail2ban_exporter.service

systemctl restart fail2ban

systemctl enable /lib/systemd/system/fail2ban_exporter.service && systemctl start fail2ban_exporter.service

cd .. && rm -irf fail2ban-prometheus-exporter

systemctl status fail2ban
systemctl status fail2ban_exporter
