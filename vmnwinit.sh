#!/bin/sh

echo "こばやし用VMネットワーク設定用シェルスクリプト"


echo "現在の設定："

ip a

echo -n "設定したいipを入力："
read ipaddr

echo -n "MACアドレスを入力："
read macaddr

sed -i -e "s/^IPADDR=192.168.11.255$/IPADDR=$ipaddr/" /etc/sysconfig/network-scripts/ifcfg-eth0 
sed -i -e "s/^HWADDR=00:00:00:00:00:00$/HWADDR=$macaddr/" /etc/sysconfig/network-scripts/ifcfg-eth0 

perl -pe "s/# net device ()\nSUBSYSTEM==\"net\", ACTION==\"add\", DRIVERS==\"?*\", ATTR{address}==\"00:15:5d:0b:c8:04\", ATTR{type}==\"1\", KERNEL==\"eth*\", NAME=\"eth0\"//g" /etc/udev/rules.d/70-persistent-net.rules
perl -pe "s/eth1/eth0/g" /etc/udev/rules.d/70-persistent-net.rules

service network restart