#!/bin/bash

# criado em 07/10/18


# checar root

cd


# desabilitar ipv6

echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6

sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local


# update repo

apt-get update;


# install wget and curl

apt-get update;apt-get -y install wget nano curl;
# install essential package

apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs openvpn vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip unrar rsyslog debsums rkhunter

apt-get -y install build-essential


sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

service ssh restart
# disable exim

service exim4 stop

sysv-rc-conf exim4 off
# setting port ssh

sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config

sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config

service ssh restart

# install dropbear and config

apt-get -y install dropbear

sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear

sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=20820/g' /etc/default/dropbear

sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109 -p 110"/g' /etc/default/dropbear

echo "/bin/false" >> /etc/shells

service ssh restart

service dropbear restart


# install stunnel 

apt-get install stunnel4 -y

wget -O /etc/stunnel/stunnel.conf "https://github.com/elisilva2017/tunneldrop/blob/master/stunnel.conf"

openssl genrsa -out key.pem 2048

openssl req -new -x509 -key key.pem -out cert.pem -days 1095

cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4

service stunnel4 restart