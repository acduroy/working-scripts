#!/bin/bash
#Prerequisite: 
# 1) Ubuntu Server OS installed on MAAS server in this case 16.04 LTS release
# 2) MAAS server should be NAT enabled before MAAS installation
# Below steps will install maas from packages
# Ref: https://docs.maas.io/2.3/en/installconfig-package-install

clear
echo -n "This script will build a maas server for OS deployment"
printf "The server should have NAT enabled to continue the installation\n"

#check if server is NAT enabled
echo "Check if ip tables rule.v4 exist"
sudo updatedb
IPT=$(locate -c -n 10 -i "rules.v4" /etc/iptables)
if [[ IPT -eq 0 ]]
then 
   /bin/bash nat-script-nocheck.sh
else
   echo "iptable rules.v4 exist, no need to download !!!"
   printf "This server was check to have a NAT service enabled !!!\n" 
fi

echo "Now setting up MAAS  to deploy OS base installation ..."
printf "Need your username, email address account and kvm ip address to proceed, pls provide. Thanks !!!\n "
echo -n "Do you have these informations with you? [Y/n]: "; read ANS1
ANS1=$(echo $ANS1 | awk '{print toupper($0)}')

if [[ ANS1 == "n" ]]; then
   exit 1
fi
read -p "Press any key to proceed the installation ..."
echo -n "Enter your username here: "; read PROFILE
echo -n "Enter your email address here: "; read EMAIL_ADDRESS
echo -n "Enter your kvm host ip address: "; read KVM_HOST
echo -n "Enter your kvm host username: "; read KVM_USER
echo -n "Are all these informations correct? [Y/n]: "; read ANS2
ANS2=$(echo $ANS2 | awk '{print toupper($0)}')

if [[ ANS2 == "N" ]]; then
   exit
fi
clear 

# At MAAS server do:
# show full list of maas packages 
apt-cache search maas

# Add a stable package repositories
sudo apt-add-repository -yu ppa:maas/stable

# Initial setup of MAAS environment 
sudo apt update 
sudo apt install maas -y

# Create admin user
# sudo maas createadmin  
# Alternative way to create MAAS user with script
printf "*** Creating an ADMIN user ... ***\n"
sudo maas createadmin --username=$PROFILE --emaail=$EMAIL_ADDRESS
#ex. username = "vmaas201", password = "Super123"

echo -n "Now SSH keys need to be imported - this can be done at web ui"
echo -n "Now login to MAAS web UI to complete the user configuration"
echo -n "At any web browser do:"
printf "http://<your_maas_ip>:5240/MAAS\n"

echo -n "At MAAS web UI to do:"
echo -n "Fill in the details for the initial MAAS configuration"  
printf "For DNS forwarder value, use nslookup command to get the DNS ip\n" 

echo -n "Region name = <MAAS name>"   
echo -n "DNS forwarder = <Upstream DNS ip address from nslookup yahoo.com>"   
echo -n "Choosing source = mass.io and Ubuntu images = 16.04 LTS release"
echo -n "SSH keys for admin = <add multiple keys from launchpad and Github or enter manually>"

echo -n "Make sure the aboev steps above were done at webUI !!!"
read -p "Press any key to continue if above steps have been done, thanks ..."
clear

echo -n "To setup public key authentication for SSH manually:"
# ref: https://www.ssh.com/ssh/keygen/
echo -n "At MAAS server do the ff:"
# execute the command at home directory
cd
ssh-keygen

echo -n "copying the public key authentication"  
cat ~/.ssh/id_rsa.pub

# At MAAS web ui do: 
echo -n "At the MAAS webUI, paste the public key generated from MAAS server to the SSH keys for admin entry" 
echo -n "Go to the "Subnets" tab" 
echo -n "Add Fabric to the MAAS in networks"
echo -n "Add subnet to the Fabric"  

echo -n "At 'Add subnet' sub-page do:" 
# Fill in the details for the dynamic range \n
echo -n "Name = <name-of-subnet>"
echo -n "CIDR = <ex. 192.168.101.0/24>"
echo -n "Fabric & VLAN = <choose the fabric to be linked with the subnet>"
echo -n "Reserve range = <enter the start IP address and the end IP address>"

# Turn on DHCP \n
echo -n "Select default VLAN assigned to the Fabric under column VLAN"
echo -n "Set the Rack controller that will manage DHCP (in this case the 'MAAS'"
printf "From the 'Take action' button, select 'Provide DHCP' \n"

# Enlist and commission servers \n
# At target node BIOS: \n
echo -n "Set all servers to PXE boot (make sure the right NIC interface as the boot device)"
echo -n "Set IPMI to DHCP mode"
echo -n "Boot each machine. Machines will be automatically enlisted in the Nodes tab"
echo -n "Select all machines and "Commission" them using the "Take action" button"
printf "Once machines are in "Ready" status, you can start deploying\n"

# To add virtual node to these steps below: \n
# MAAS with KVM  \n
# ref: https://docs.maas.io/2.3/en/nodes-add \n
# The procedure below is to add nodes via a Pod \n " 

echo -n "At MAAS node do:"
sudo apt install libvirt-bin -y

echo -n "Generating SSH private/pub key 'maas' user.. (in case no private/pub key generated)"
echo -n "Remember this is key pair for 'maas' user!!!!"
sudo chsh -s /bin/bash maas
sudo su - maas
ssh-keygen -f ~/.ssh/id_rsa -N ''

echo -n "Copy public key to the target node (from MAAS to KVM host in this case) \n
# Remember this is still under 'mass' user shell/console!!! \n
# Where $KVM_HOST represents the IP address of the KVM host \n
# $USER represents a user on the KVM host with the permission to communicate with the libvirt daemon \n

# NOTE: user_name = User Name of KVM Host (ex. 'acd')\n
# NOTE: ip_address = IP address of the host bridge (ex. br201 - 10.100.201.2)\n"

echo -n "Example ssh-copy-id -i ~/.ssh/id_rsa acd@10.100.201.2"

echo -n "Enter your kvm host user name: "; read KVM_USER
echo -n "Enter your kvm ip address: "; read KVM_HOST
ssh-copy-id -i ~/.ssh/id_rsa $KVM_USER@$KVM_HOST

echo -n "Testing connection between MAAS and KVM-Host:"
virsh -c qemu+ssh://$KVM_USER@$KVM_HOST/system list --all

# Exit from 'maas' user shell
exit

echo "# Go and read - Add nodes via a Pod section (adding KVM VMs)...
# https://docs.maas.io/2.3/en/nodes-comp-hw
# NOTE: user_name = User Name of KVM Host (ex. 'acd')
# NOTE: ip_address = IP address of the host bridge (ex. br201 - 10.100.201.2) " 

echo -n "At MAAS web UI do:"
echo -n "Go to Pods menu and add pod"
echo -n "Select Pod type to Virsh virtual system" 
echo -n "Enter the Virsh address = 'qemu+ssh://<user_name>@<ip_address>/system' " 
echo -n "Save pod"

echo -n "MAAS Deployer installation is done .... THANKS !!!"
