#!/bin/bash

# check if we are root? - and run via bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Installing web100 - Tulip Shop"
hostname web100
echo web100 > /etc/hostname
echo "$(ip a | egrep -o '10(\.[0-9]*){3}' | head -1)    web100" >> /etc/hosts
apt-get update
apt-get -y install apache2 libapache2-mod-php5 php5-sqlite
rm -rf /var/www/*
cd /var/www && tar zxvf /home/ubuntu/install.tgz
chown -R www-data:www-data /var/www

# Somehow need a reboot to enable PDO sqlite driver
shutdown -r now
