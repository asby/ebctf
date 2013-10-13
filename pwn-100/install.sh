#!/bin/bash

# check if we are root? - and run via bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Adjusting some hardening rules"
echo "Allowing level2b crontab usage"
echo level2b >> /etc/cron.allow
echo "Changing /var/log to 770 and adding user puppet to group root"
chmod 770 /var/log
sed -i.bak -e 's/root:x:0:$/&puppet/' /etc/group
echo "Also allow users level1,2,3 to ssh into box"
sed -i.bak -e 's/AllowUsers ubuntu root$/& level1 level2 level3/' /etc/ssh/sshd_config
service ssh restart


echo "Installing pwn100"
hostname pwn100
echo pwn100 > /etc/hostname
echo "$(ip a | egrep -o '10(\.[0-9]*){3}' | head -1)    pwn100" >> /etc/hosts
useradd -s /bin/bash level1
useradd -s /bin/bash level2
useradd -s /bin/bash -G level2 level2b
useradd -s /bin/bash level3
useradd -s /bin/bash -G level3 level4

apt-get -y install puppetmaster puppet ntp
cd /home/
tar zxvf /home/ubuntu/install.tgz

# Set up crontab user level2b
echo '* * * * * /home/level2/clean/home_cleaner.sh' | crontab -u level2b -

# Set rights level1
chown -R root:level1 /home/level1
chmod -R 750 /home/level1
chown level2:level1 /home/level1/level2.ssh.key
chmod 440 /home/level1/level2.ssh.key

# Set rights level2
chown -R root:level2 /home/level2
chmod -R 750 /home/level2
chown level2b:level2 /home/level2/clean
chmod 1770 /home/level2/clean
chown root:level2b /home/level2/clean/*
chmod 664 /home/level2/clean/clean.log
chmod 770 /home/level2/clean/home_cleaner.sh
chmod 440 /home/level2/clean/level3.ssh.key

# Set rights level3
chown -R root:level3 /home/level3
chmod -R 750 /home/level3
chown root:level4 /home/level3/fancy.pl
chown root:level4 /home/level3/flag
chown root:level3 /home/level3/README
chmod 440 /home/level3/flag
chmod 754 /home/level3/fancy.pl
chmod 440 /home/level3/README

# Setup sudo rights for level4
echo 'level3   ALL=(level4) NOPASSWD: /home/level3/fancy.pl' > /etc/sudoers.d/30-level4
chmod 440 /etc/sudoers.d/30-level4

# Setup puppet
echo '*' > /etc/puppet/autosign.conf
mv /home/site.pp /etc/puppet/manifests
chown root:root /etc/puppet/manifests/site.pp
chmod 644 /etc/puppet/manifests/site.pp
mkdir -p /etc/puppet/files
mv /home/level1.ssh.key /etc/puppet/files/
chown root:root /etc/puppet/files/level1.ssh.key
chmod 644 /etc/puppet/files/level1.ssh.key
mv /home/fileserver.conf /etc/puppet/
chown root:root /etc/puppet/fileserver.conf
chmod 644 /etc/puppet/fileserver.conf
sed -i.bak -e 's/START=no/START=yes/g' /etc/default/puppetmaster
service puppetmaster restart
