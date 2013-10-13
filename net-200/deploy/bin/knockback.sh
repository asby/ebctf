#!/bin/sh

# Script run after first succesfull sequence and knock backs to players

IP=$1

# Open firewall, so people can see the repeat after me message
/sbin/iptables -A INPUT -s $IP -p tcp --dport 51037 -j ACCEPT

# Knock back
sleep 5
/home/knock/bin/knockback.py $IP

exit 0
