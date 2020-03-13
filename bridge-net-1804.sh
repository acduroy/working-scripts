#!/bin/bash
# step 1:
# check what variants of Ubuntu is installed
echo "Checking Ubuntu version ..."
OS=$(lsb_release -rs)
if [[ $OS == "18.04" ]]
then
        echo "18.04 LTS"
        wget https://raw.githubusercontent.com/acduroy/working-scripts/master/bridge-net-1804.sh
else
        echo "16.04 LTS"
        wget https://raw.githubusercontent.com/acduroy/working-scripts/master/bridge-net-1604.sh
fi

# step 2:
# Install package to Create a bridge network interface
sudo apt-get install bridge-utils

# show network interfaces #
clear
ip a s|grep -i broadcast
echo "Remember the IP address as shown above to create bridge network !!!"

# Network info from User input here: #
#echo -n "Enter External network interface to bridge [ex. eno1]: "; read EXT
echo -n "Enter External network interface [ex. eno1]: "; read EXT
echo -n "Enter Internal network interface to bridge [ex. eno2]: "; read INT
echo -n "Enter bridge name [ex. br0]: "; read BNAME
echo -n "Enter IP address of the bridge network: "; read IPADDR
echo -n "Enter Network Prefix [ex. 24]: "; read NP

#assign default network prefix if no input from user
if [[ -z $NP ]]; then
  #use default value
  $NP = 24
fi

# temporary name
# create a bridge name
sudo brctl addbr $BNAME

# Add the interfaces to be bridged #
sudo brctl addif $BNAME $INT

# Setup network config file #
sudo cp /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml.bak

brctl show
#sample output:
#------------------------------------------------------------------
#
#bridge name     bridge id               STP enabled     interfaces
#br0             8000.ac1f6b59a193       no              enp24s0f1
#
#------------------------------------------------------------------

# Edit the file /etc/netplan/50-cloud-init.yaml to look like below:

cat << BRIDGE | sudo tee /etc/netplan/50-cloud-init.yaml
#--------------------------------------------------------------------------

# This file is generated from information provided by
# the datasource.  Changes to it will not persist across an instance.
# To disable cloud-init's network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        $EXT:
            addresses: []
            dhcp4: true
            optional: true
        $INT:
            addresses: []
            dhcp4: false
            optional: true
    bridges:
        $BNAME:
            dhcp4: false
            addresses: [$IPADDR/$NP]
            interfaces:
                - $INT
    version: 2
BRIDGE

#--------------------------------------------------------------------------

# Reset network interface #
sudo ip addr flush $INT
sudo ifup $BNAME
sudo ip link set $BNAME up
sudo ip link set $INT up

# Update netplan
sudo netplan try
sudo netplay apply

# to verify bride is working !!! #
brctl show
ifconfig
