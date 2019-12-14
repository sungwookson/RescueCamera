#!/bin/bash

if [ `id -u` != "0" ]; then
    echo "Run it again with root"
    echo "sudo ./install.sh"
    exit 1
fi

#Enable SSH
sudo systemctl enable ssh
sudo systemctl start ssh

#Updating apt-get to the latest
sudo apt-get update
sudo apt-get upgrade

#Install necessary components
sudo apt-get install -y fswebcam motion rpi.gpio
sudo apt-get install -y dnsmasq hostapd
sudo pip install flask

#Check if properly installed
function check_installed() {
  if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -eq 0 ];
  then
  	echo "Package $1 has not been installed please re-run the script";
  	exit 1
  fi
}
check_installed fswebcam
check_installed motion
check_installed dnsmasq
check_installed hostapd

#Get Motion working
sudo mv config/motion.conf /etc/motion/motion.conf
sudo mv config/motion /etc/default/motion
sudo service motion restart

sudo ./startAP.sh