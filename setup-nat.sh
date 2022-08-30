#!/bin/bash
#Description: Configuration of NAT with iptables
#Author: acd

display_usage() { 
	echo "This script must be run with super-user privileges." 
        echo "Both external and internal network interfaces are the arguments to supply"
	echo "Example: ./setup-nat.sh <ext_dev> <int_dev>"
	echo -e "\nUsage: $0 [arguments] \n" 
} 

# if less than two arguments supplied, display usage 
if [  $# -le 1 ]; then 
   display_usage
   exit 1
fi 
 
# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $@ == "--help") ||  $@ == "-h" ]]; then 
   display_usage
   exit 0
fi 
 
# display usage if the script is not run as root user 
if [[ "$EUID" -ne 0 ]]; then 
   echo "This script must be run as root!" 
   exit 1
fi 
 
echo "All good !!!"

if [[ $EUID -ne 0 ]]; then
   echo "ERROR: This script must be run as root"
   exit 1
fi

route -n
nslookup yahoo.com
ping yahoo.com
cd

First, make sure iptable service is installed.
# Download iptables-services-1.8.4-22.el8.x86_64.rpm
yum install iptables-services  

# Enable iptables.service permanently
systemctl enable iptables
systemctl start iptables

# Check iptables.service is running
systemctl status iptables

Delete all the iptables rules present, specially NAT
iptables --flush
iptables --table nat --flush
iptables --delete-chain
iptables --table nat --delete-chain

ip a show
route -n

Set up IP FORWARDing and Masquerading.
IP_EXT=$1
IP_INT=$2

iptables --table nat -A POSTROUTING -o $IP_EXT -j MASQUERADE
iptables -A FORWARD -i $IP_EXT -o $IP_INT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $IP_INT -o $IP_EXT  -j ACCEPT

#Save iptables and restart service.
service iptables save 

#To persist these firewall changes after reboot:
iptables-save | sudo tee /etc/sysconfig/iptables
systemctl enable --now iptables

# restart the service
service iptables restart

# Overwrite the current rules
iptables-restore < /etc/sysconfig/iptables

# Add the new rules keeping the current ones
iptables-restore -n < /etc/sysconfig/iptables

#Enable packet forwarding by kernel.
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward

#To enable the changes made in sysctl.conf, run the command:
sysctl -p /etc/sysctl.conf

#Restart the network service.
service network restart

#You will also need to turn off firewalld with systemctl disable and mask firewalld.service
systemctl disable firewalld
systemctl mask --now firewalld
systemctl mask firewalld

if [ $? -eq 0 ]; then
    print "\n"
    echo "Update done and now exiting, thanks bye !!!"
else
    print "\n"
    echo "An error has encountered, sorry exiting now !!!"
fi
