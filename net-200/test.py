#!/usr/bin/python

import sys,time,socket,os
from scapy.all import *
conf.verb = 0

try:
	host = sys.argv[1]
except:
	print "Usage: ./test.py <host>"
	sys.exit(2)

if (os.geteuid() != 0):
	print "Run test script as root"
	sys.exit(2)

ip = IP(dst=host)
sport = 1337
error=0

# Teststrings
WEBSITE="""112 + 386 + 712 + 1398 + 8771 + 11982 + 15397 + 23984 = 51037"""
KNOCKBASIC="""So you are knocking me, how about I return the favor?\r\nRepeat after me and I will open the last port...\r\n"""
KNOCKBACK="""[Advanced]\r\n        sequence    = 234,781,983,2411,9781,14954,23112,63991\r\n        seq_timeout = 15\r\n        command     = /sbin/iptables -A INPUT -s %IP% -p tcp --dport 32154 -j ACCEPT\r\n        tcpflags    = fin,urg,!ack\r\n        cmd_timeout = 30\r\n        stop_command = /sbin/iptables -D INPUT -s %IP% -p tcp --dport 32154 -j ACCEPT\r\n\r\n"""
KNOCKADVANCED="""ebCTF{32c64f2542ba4566acff750196ca2e13}\r\n"""

# Test webpage
try:
	s = socket.create_connection((host,80),2)
	time.sleep(1)
	s.send("GET / HTTP/1.0\r\n\r\n")
	data = s.recv(1024)
	s.close()
	if (data.find(WEBSITE) != -1):
		print "OK: Website working"
	else:
		print "ERROR: Website reply doesn't match"
		error += 1
except:
	print "ERROR: Website port closed"
	error += 1

# Test Basic Knock
ports = [112,386,712,1398,8771,11982,15397,23984]

for dport in range(0, len(ports)):
    SYN = ip/TCP(sport=sport, dport=ports[dport], flags="S", seq=0)
    send(SYN)
    time.sleep(0.2)

try:
	s = socket.create_connection((host,51037),2)
	time.sleep(1)
	data = s.recv(1024)
	s.close()
	if (data == KNOCKBASIC):
		print "OK: Knockbasic working"
	else:
		print "ERROR: Knockbasic reply doesn't match"
		error += 1
except:
	print "ERROR: Knockbasic port closed"
	error += 1


# Test Knockback Knock
ports = [8112,33386,14712,4398,1771,52313,25697,932]

for dport in range(0, len(ports)):
    SYN = ip/TCP(sport=sport, dport=ports[dport], flags="S", seq=0)
    send(SYN)
    time.sleep(0.2)

try:
	s = socket.create_connection((host,22222),2)
	time.sleep(1)
	data = s.recv(1024)
	s.close()
	if (data == KNOCKBACK):
		print "OK: Knockback working"
	else:
		print "ERROR: Knockback reply doesn't match"
		error += 1
except:
	print "ERROR: Knockback port closed"
	error += 1


# Test Advanced Knock
ports = [234, 781, 983, 2411, 9781, 14954, 23112, 63991]

for dport in range(0, len(ports)):
    SYN = ip/TCP(sport=sport, dport=ports[dport], flags="FU", seq=0)
    send(SYN)
    time.sleep(0.2)

try:
	s = socket.create_connection((host,32154),2)
	time.sleep(1)
	data = s.recv(1024)
	s.close()
	if (data == KNOCKADVANCED):
		print "OK: Knockadvanced working"
	else:
		print "ERROR: Knockadvanced reply doesn't match"
		error += 1
except:
	print "ERROR: Knockadvanced port closed, make sure it is not a client side problem"
	error += 1

if error != 0:
	print "ERROR: Challenge not working properly"
	sys.exit(2)
else:
	print "OK: Challenge works properly"
	sys.exit(0)
