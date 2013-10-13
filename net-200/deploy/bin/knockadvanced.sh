#!/bin/sh

echo "[Advanced]"
echo "        sequence    = 234,781,983,2411,9781,14954,23112,63991"
echo "        seq_timeout = 15"
echo "        command     = /sbin/iptables -A INPUT -s %IP% -p tcp --dport 32154 -j ACCEPT"
echo "        tcpflags    = fin,urg,!ack"
echo "        cmd_timeout = 30"
echo "        stop_command = /sbin/iptables -D INPUT -s %IP% -p tcp --dport 32154 -j ACCEPT"
echo ""
exit 0
