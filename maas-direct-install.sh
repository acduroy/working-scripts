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
printf "This may take some time, dont interrupt. Thanks !!!\n"
printf $PROFILE 
printf $EMAIL_ADDRESS
printf "\n"  
sudo maas createadmin --username=$PROFILE --emaail=$EMAIL_ADDRESS
#ex. username = "vmaas201", password = "Super123"

printf "Now SSH keys need to be imported - this can be done at web ui\n"
printf "Now login to MAAS web UI to complete the user configuration\n"
printf "At any web browser do:\n"
printf "http://<your_maas_ip>:5240/MAAS\n"
echo
printf "At MAAS web UI to do:\n"
printf "Fill in the details for the initial MAAS configuration\n"  
printf "For DNS forwarder value, use nslookup command to get the DNS ip\n" 
echo
printf "Region name = <MAAS name>\n"   
printf "DNS forwarder = <Upstream DNS ip address from nslookup yahoo.com>\n"   
printf "Choosing source = mass.io and Ubuntu images = 16.04 LTS release\n"
printf "SSH keys for admin = <add multiple keys from launchpad and Github or enter manually>\n"
echo
printf "Make sure the aboev steps above were done at webUI !!!\n"
read -p "Press any key to continue if above steps have been done, thanks ..."
clear
echo
printf "Setting up public key authentication for SSH ...\n"
# ref: https://www.ssh.com/ssh/keygen/
# At MAAS server do the ff:
# execute the command at home directory
cd
ssh-keygen
printf "Now copying the public key authentication ..."  
cat ~/.ssh/id_rsa.pub

# At MAAS web ui do: 
printf "At the MAAS webUI, paste the public key generated from MAAS server to the SSH keys for admin entry\n" 
printf "Then go to the 'Subnets' tab, add Fabric to the MAAS in networks, and add subnet to the Fabric\n"  
printf "At 'Add subnet' sub-page do:\n" 
printf "Fill in the details for the dynamic range \n"
printf "Name = <name-of-subnet>\n"
printf "CIDR = <ex. 192.168.101.0/24>\n"
printf "Fabric & VLAN = <choose the fabric to be linked with the subnet>\n"
printf "Reserve range = <enter the start IP address and the end IP address>\n"

# Turn on DHCP
printf "Select default VLAN assigned to the Fabric under column VLAN\n"
printf "Set the Rack controller that will manage DHCP (in this case the 'MAAS'\n"
printf "From the 'Take action' button, select 'Provide DHCP' \n"

# Enlisting and commissioning server
printf "Now perform the ff to enlist and commission the server. Do these at the target node BIOS\n:
printf "1. Set all servers to PXE boot (make sure the right NIC interface as the boot device)\n"
printf "2. Set IPMI to DHCP mode\n"
printf "3. Boot each machine. Machines will be automatically enlisted in the Nodes tab\n"
printf "4. Select all machines and "Commission" them using the "Take action" button\n"
printf "5. Once machines are at 'Ready' status, you can start deploying\n"
read -p "Press any key once enlisting and commissioning of server is completed, thanks ..."

# Adding virtual node to the MAAS network with KVM
# ref: https://docs.maas.io/2.3/en/nodes-add \n
# The procedure below is to add nodes via a Pod \n " 
printf "Use the ff steps below to add virtual node via Pod. Do the ff at the command line.\n"
echo -n "Press 'Y' to continue, 'n' to exit the program:"; read ADD_VM
ADD_VM=$(echo $ADD_VM | awk '{print toupper($0)}')
if [[ ADD_VM == "N" ]]; then
   printf "To add VM node later on, run 'maas-add-vm.sh' script\n" 
   exit 1
fi
sudo apt install libvirt-bin -y
printf "Generating SSH private/pub key 'maas' user.. (in case no private/pub key generated)\n"
echo -n "Remember this is key pair for 'maas' user!!!!"
sudo chsh -s /bin/bash maas
sudo su - maas
ssh-keygen -f ~/.ssh/id_rsa -N ''

printf "Now copying the public key to the target node (from MAAS to KVM host in this case)\n"
printf "Remember this is still under 'mass' user shell/console!!! \n"
printf "Where $KVM_HOST represents the IP address of the KVM host \n"
printf "$USER represents a user on the KVM host with the permission to communicate with the libvirt daemon \n"
printf "Use the IP address of the KVM Host bridge (ex. br201 - 10.100.201.2)\n" 

# For this example, user_name = User Name of KVM Host (ex. 'acd')
# and IP address of the kvm host bridge (ex. br201 - 10.100.201.2)
# Example ssh-copy-id -i ~/..sh/id_rsa acd@10.100.201.2

printf "Example ssh-copy-id -i ~/.ssh/id_rsa acd@10.100.201.2\n"
read -p "Press any key, once ready to enter data ..."

echo -n "Enter your kvm host user name: "; read KVM_USER
echo -n "Enter your kvm ip address: "; read KVM_HOST
ssh-copy-id -i ~/.ssh/id_rsa $KVM_USER@$KVM_HOST

printf "Testing the connection between MAAS and KVM-Host ...\n"
virsh -c qemu+ssh://$KVM_USER@$KVM_HOST/system list --all
printf "Once connection has been checked, you can now exit MAAS shell\n"
echo -n "Press 'Y' to exit or 'n' to stay in MAAS shell"; read EXIT_SHELL
EXIT_SHELL=$(echo $EXIT_SHELL | awk '{print toupper($0)}')
if [[ EXIT_SHELL == "N" ]]; then
   printf "Exiting the program to check the communication problem between kvm and maas server\n"
   printf "If needed to go back to maas shell, use the ff commands:\n"
   printf "1.)sudo chsh -s /bin/bash maas and 2.)sudo su - maas \n"
   exit 1
fi
# Exit from 'maas' user shell
exit  

# Read - Add nodes via a Pod section (adding KVM VMs)...\n
# https://docs.maas.io/2.3/en/nodes-comp-hw
# NOTE: user_name = User Name of KVM Host (ex. 'acd')
# NOTE: ip_address = IP address of the host bridge (ex. br201 - 10.100.201.2) " 
printf "Now to complete adding VM node to the maas network, perform the ff at MAAS webUI:\n"
printf "1. Go to Pods menu and add pod\n"
printf "2. Select Pod type to Virsh virtual system\n" 
printf "3. Enter the Virsh address = 'qemu+ssh://<user_name>@<ip_address>/system'\n" 
printf "4. Save pod'\n"
read -p "Once all steps above have completed, press any key ..."
echo
echo " **** MAAS Deployer installation is done .... THANKS !!! ****"
