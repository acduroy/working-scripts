#!/bin/bash

clear
echo "Script Description:"
echo "This script will create a bridge to the VM(s)"
echo "Bridge will be created for the internal network of VM(s)"
echo "While macvtap will be used for the external network of VMs"
echo "In addition, a promiscus mode will apply on the bridge network interface" 
read -p "Press [Enter] key to continue..."

#install the software #
aptitude install bridge-utils

# show network interfaces #
clear
ifconfig |grep -i Link
echo "Remember the IP address as shown above to create bridge network !!!"
echo "Use the DNS NAME Server = "   
str="yahoo.com"
nslookup $str

# Network info from User input here: #
#echo -n "Enter External network interface to bridge [ex. eno1]: "; read EXT
echo -n "Enter External network interface [ex. eno1]: "; read INT
echo -n "Enter Internal network interface to bridge [ex. eno2]: "; read INT
echo -n "Enter bridge name [ex. br0]: "; read BNAME
echo -n "Enter IP address of the bridge network: "; read IPADDR
echo -n "Enter broadcast IP address [ex. xx.xx.xx.255]: "; read BADDR

# temporary name
# create a bridge name
sudo brctl addbr $BNAME

# Add the interfaces to be bridged #
brctl addif $BNAME $INT 

# Setup network config file #
sudo cp /etc/network/interfaces /etc/network/interfaces.bak
cat << BRIDGE | sudo tee /etc/network/interfaces

source /etc/network/interfaces.d/*
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto $EXT
iface $EXT inet manual

# The secondary network interface
auto $INT
iface $INT inet manual
   up ifconfig $INT promisc
   down ifconfig $INT -promisc

#The bride network interface
auto $BNAME
iface $BNAME inet static 
   address $IPADDR
   netmask 255.255.255.0
   broadcast $BADDR
   bridge_ports $INT
   bridge_stp off
   bridge_fd 0
   bridge_maxwait 0
   
BRIDGE

# Reset network interface #
sudo ip addr flush $INT
sudo ifup $BNAME

#sudo ip addr flush $SEC_INT
sudo services networking restart

# to verify bride is working !!! #
brctl show
ifconfig
