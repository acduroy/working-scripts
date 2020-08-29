#!/bin/bash
#Ref: https://devops.ionos.com/tutorials/deploy-outbound-nat-gateway-on-centos-7/

echo "Must run this script as root"

echo -n "Enter the External/Public Network Interface [ex. eth0]: "; read EXT
echo -n "Enter the Internal or LAN's CIDR [ex. 10.0.0.1/24]: "; read CIDR

#Enable IP Forwarding
sysctl -w net.ipv4.ip_forward=1

#Configure IP forwarding Permanently
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.d/ip_forward.conf

#Enable NAT
firewall-cmd --permanent --direct --passthrough ipv4 -t nat -I POSTROUTING -o $EXT -j MASQUERADE -s $CIDR
firewall-cmd --reload

echo "NAT installation is complete, thanks !!!"
