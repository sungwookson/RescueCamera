#!/bin/bash

#Creating Wireless AP
sudo systemctl stop dnsmasq
sudo systemctl stop hostapd

sudo cp config/AP/dhcpcd.conf.og /etc/dhcpcd.conf

sudo service dhcpcd restart

sudo cp config/AP/dnsmasq.conf.og /etc/dnsmasq.conf

sudo systemctl reload dnsmasq

sudo cp config/AP/hostapd.conf.og /etc/hostapd/hostapd.conf

sudo cp config/AP/hostapd.og /etc/default/hostapd

#sudo systemctl unmask hostapd
#sudo systemctl enable hostapd
#sudo systemctl start hostapd

sudo cp config/AP/sysctl.conf.og /etc/sysctl.conf

