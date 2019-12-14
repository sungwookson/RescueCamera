#!/bin/bash

#Creating Wireless AP
sudo apt install dnsmasq hostapd
sudo systemctl stop dnsmasq
sudo systemctl stop hostapd

sudo cp ./config/AP/dhcpcd.conf.ap /etc/dhcpcd.conf

sudo service dhcpcd restart

sudo cp ./config/AP/dnsmasq.conf.ap /etc/dnsmasq.conf

sudo systemctl reload dnsmasq

sudo cp ./config/AP/hostapd.conf.ap /etc/hostapd/hostapd.conf

sudo cp ./config/AP/hostapd.ap /etc/default/hostapd

sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl start hostapd

sudo cp ./config/AP/sysctl.conf.ap /etc/sysctl.conf

sudo iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
