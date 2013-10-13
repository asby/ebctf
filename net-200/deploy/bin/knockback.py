#!/usr/bin/python

import sys,time
from scapy.all import *
conf.verb = 0

ip = IP(dst=sys.argv[1])
sport = 1337
ports = []

ports.append(ip/TCP(sport=sport, dport=8112, flags="S", seq=0))
ports.append(ip/TCP(sport=sport, dport=33386, flags="S", seq=0))
ports.append(ip/TCP(sport=sport, dport=14712, flags="S", seq=0))
ports.append(ip/TCP(sport=sport, dport=4398, flags="S", seq=0))
ports.append(ip/TCP(sport=sport, dport=1771, flags="S", seq=0))
ports.append(ip/TCP(sport=sport, dport=52313, flags="S", seq=0))
ports.append(ip/TCP(sport=sport, dport=25697, flags="S", seq=0))
ports.append(ip/TCP(sport=sport, dport=932, flags="S", seq=0))
ports.append(ip/TCP(sport=sport, dport=22222, flags="S", seq=0))

for i in range(0,len(ports)):
    send(ports[i])
    time.sleep(1)
