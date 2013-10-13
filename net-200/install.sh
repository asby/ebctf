#!/bin/bash

# check if we are root? - and run via bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Installing net200 - Knock Knock"
hostname net200
echo net200 > /etc/hostname
echo "$(ip a | egrep -o '10(\.[0-9]*){3}' | head -1)    net200" >> /etc/hosts
useradd -s /bin/bash -m knock
echo "iptables-persistent	iptables-persistent/autosave_v4	boolean	true" | debconf-set-selections
echo "iptables-persistent	iptables-persistent/autosave_v6	boolean	true" | debconf-set-selections
apt-get -y install apache2 libapache2-mod-php5 knockd iptables-persistent socat scapy
cd /home/knock
tar zxvf /home/ubuntu/install.tgz

# Setup webpage
rm /var/www/index.html
mv /home/knock/index.php /var/www
chmod 644 /var/www/index.php
chown root:root /var/www/index.php

# Setup knock config
echo "START_KNOCKD=1" > /etc/default/knockd
mv /home/knock/knockd.conf /etc/
chmod 640 /etc/knockd.conf
chown root:root /etc/knockd.conf
/etc/init.d/knockd restart

# Setup iptables
mv /home/knock/rules.v4 /etc/iptables/
chmod 640 /etc/iptables/rules.v4
chown root:root /etc/iptables/rules.v4
/etc/init.d/iptables-persistent restart

# Start Socat
chown -R knock:knock /home/knock
chmod +x /home/knock/bin/*
/home/knock/bin/start_socat.sh
