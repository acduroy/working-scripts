#!/bin/bash
printf "This script will add VM node(s) to the MAAS network\n"
read -p "Presss any key to continue ..."
#sudo apt install libvirt-bin -y
#printf "Generating SSH private/pub key 'maas' user.. (in case no private/pub key generated)\n"
#echo -n "Remember this is key pair for 'maas' user!!!!"
#sudo chsh -s /bin/bash maas
#sudo su - maas
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
echo -n "Press 'Y' to exit, 'n' to stay at MAAS shell"; read EXIT_SHELL
EXIT_SHELL=$(echo $EXIT_SHELL | awk '{print toupper($0)}')
if [[ EXIT_SHELL == 'Y' ]]; then
   exit 
fi
