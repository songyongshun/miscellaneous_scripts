#!/usr/bin/env bash
# iptables -L -nv |grep 443

# clear all
iptables -F

# no http
iptables -A INPUT -p tcp --dport 80 -j DROP
iptables -A INPUT -p tcp --dport 3128 -j DROP

# add ip address in ip.txt
nip=`wc -l ip.txt|awk '{print $1}'`
for((i=1;i<=$nip;i++))
do
ip_n=`awk -v i=$i '{if(NR==i)print $1}' ip.txt`
iptables -A INPUT -p tcp --dport 443 -s $ip_n -j ACCEPT
done

# drop all others
iptables -A INPUT -p tcp --dport 443 -j DROP

# show all
iptables -L INPUT -n --line-number
