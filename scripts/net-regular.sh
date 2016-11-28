#!/bin/bash

service tor stop

iptables -F
iptables -t nat -F

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

iptables-save > /etc/iptables.ipv4.nat
