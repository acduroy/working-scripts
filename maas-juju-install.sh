
#!/bin/bash
# The script will install MAAS and JUJU on this server
# Program Name: maas-juju-install.sh
# Usgae: ./maas-juju-install.sh
# Author: acd
# Build Rev: 1
# Build Date:2-24-2019


function_to_test() {
exit
}


# use this query to check if function is working  !!!"
if [[ "$#" -eq 1 ]]
then
        #call the function to test here
        function_to_test
fi

read -p "Press [enter] key to continue ..."

# step 1:
# check what variants of Ubuntu is installed
echo "Checking Ubuntu version ..."
OS=$(lsb_release -rs)
if [[ $OS == "18.04" ]]
then
        echo "18.04 LTS"
        wget https://raw.githubusercontent.com/acduroy/working-scripts/master/bridge-net-1804.sh
        chmod 755 bridge-net-1804.sh
        mv bridge-net-1804.sh bridge-net.sh
else
	echo "16.04 LTS"
        wget https://raw.githubusercontent.com/acduroy/working-scripts/master/bridge-net-1604.sh
        chmod 755 bridge-net-1604.sh
        mv bridge-net-1604.sh bridge-net.sh
fi

# step 2:
# Install package to Create a bridge network interface
bash bridge-net.sh

# Step 3:
# install_nat
wget https://raw.githubusercontent.com/acduroy/working-scripts/master/nat-install.sh
chmod 755 nat-install.sh
bash nat-install.sh

# verification:
echo "checking domain name servers (DNS)..."
nslookup yahoo.com
echo "Compare sample output below:"
echo "--------------------------"
echo "Server:         127.0.0.53"
echo "Address:        127.0.0.53#53"
echo "Non-authoritative answer:"
echo "Name:   yahoo.com"
echo "Address: 98.138.219.232"
echo "Name:   yahoo.com"
echo "Address: 98.137.246.8"
echo "Name:   yahoo.com"
echo "Address: 98.138.219.231"
echo "Name:   yahoo.com"
echo "Address: 72.30.35.10"
echo "Name:   yahoo.com"
echo "Address: 98.137.246.7"
echo "Name:   yahoo.com"
echo "Address: 72.30.35.9"
echo "Name:   yahoo.com"
echo "Address: 2001:4998:58:1836::10"
echo "Name:   yahoo.com"
echo "Address: 2001:4998:44:41d::4"
echo "Name:   yahoo.com"
echo "Address: 2001:4998:58:1836::11"
echo "Name:   yahoo.com"
echo "Address: 2001:4998:c:1023::4"
echo "Name:   yahoo.com"
echo "Address: 2001:4998:c:1023::5"
echo "Name:   yahoo.com"
echo "Address: 2001:4998:44:41d::3"
echo "--------------------------"
read -p "Press [enter] to continue ..."
printf "\n"

echo "checking if there's network connectivity ..."
ping 8.8.8.8 -c 5
echo "Compare sample output below:"
echo "--------------------------"
echo "PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data."
echo "64 bytes from 8.8.8.8: icmp_seq=1 ttl=115 time=4.86 ms"
echo "64 bytes from 8.8.8.8: icmp_seq=2 ttl=115 time=4.88 ms"
echo "64 bytes from 8.8.8.8: icmp_seq=3 ttl=115 time=4.83 ms"
echo "64 bytes from 8.8.8.8: icmp_seq=4 ttl=115 time=5.24 ms"
echo "64 bytes from 8.8.8.8: icmp_seq=5 ttl=115 time=5.28 ms"

echo "--- 8.8.8.8 ping statistics ---"
echo "5 packets transmitted, 5 received, 0% packet loss, time 4007ms"
echo "rtt min/avg/max/mdev = 4.830/5.020/5.285/0.199 ms"
echo "--------------------------"
echo "--------------------------"
read -p "Press [enter] key to continue ..."
printf "\n"

ifconfig
echo "Compare sample output below:"
echo "-----------------------------------------------"
echo "br0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500"
echo "       inet 10.100.214.1  netmask 255.255.255.0  broadcast 10.100.214.255"
echo "        inet6 fe80::1881:5eff:febf:d545  prefixlen 64  scopeid 0x20<link>"
echo "        ether 1a:81:5e:bf:d5:45  txqueuelen 1000  (Ethernet)"
echo "        RX packets 107  bytes 21371 (21.3 KB)"
echo "        RX errors 0  dropped 1  overruns 0  frame 0"
echo "        TX packets 11  bytes 866 (866.0 B)"
echo "        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0"

echo "enp24s0f0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500"
echo "        inet 172.30.116.45  netmask 255.255.0.0  broadcast 172.30.255.255"
echo "        inet6 fe80::ae1f:6bff:fe59:a192  prefixlen 64  scopeid 0x20<link>"
echo "        ether ac:1f:6b:59:a1:92  txqueuelen 1000  (Ethernet)"
echo "        RX packets 5394  bytes 495605 (495.6 KB)"
echo "        RX errors 0  dropped 81  overruns 0  frame 0"
echo "        TX packets 155  bytes 21924 (21.9 KB)"
echo "        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0"

echo "enp24s0f1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500"
echo "        ether ac:1f:6b:59:a1:93  txqueuelen 1000  (Ethernet)"
echo "        RX packets 107  bytes 22869 (22.8 KB)"
echo "        RX errors 0  dropped 0  overruns 0  frame 0"
echo "        TX packets 11  bytes 866 (866.0 B)"
echo "        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0"

echo "lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536"
echo "        inet 127.0.0.1  netmask 255.0.0.0"
echo "        inet6 ::1  prefixlen 128  scopeid 0x10<host>"
echo "        loop  txqueuelen 1000  (Local Loopback)"
echo "        RX packets 110  bytes 8548 (8.5 KB)"
echo "        RX errors 0  dropped 0  overruns 0  frame 0"
echo "        TX packets 110  bytes 8548 (8.5 KB)"
echo "        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0"
echo "-------------------------------------------------"
read -p "Press [enter] to continue ..."
exit
}

echo "# step 4:"
echo "MAAS installation ..."
apt-cache search maas
sudo apt-add-repository -yu ppa:maas/stable
sudo apt update && sudo apt upgrade -y
sudo apt install maas -y
echo "creating MAAS admin user ..."
read -p "Press [enter] key to continue ..."
clear
printf "\n"
printf "\n"
echo "# Use the following credentials below as example to create a maas admin user:"
echo "--------------------------"
echo "Username: supermicro"
echo "Password:"
echo "Again:"
echo "Email: acduroy@yahoo.com"
echo "Import SSH keys [] (lp:user-id or gh:user-id):"
echo "--------------------------"
printf "\n"
sudo maas createadmin

echo "generating public/private rsa key pair at maas server..."
echo "the ssh-key pair will be generated at ~/.ssh directory "
echo -e "\n"|ssh-keygen -t rsa -N ""
clear
echo "Copy the public ssh-key below and paste it to the MAAS webUI"
printf "\n"
printf "\n"
cat ~/.ssh/id_rsa.pub
printf "\n"
echo "To access the MAAS webUI, open a firefox and enter https://<maas-server-internal-ip-address>:5240/MAAS/"
read -p "Press [enter] key to continue ..."

# step 5:
clear
echo "Installing virt-install packages ..."
read -p "Press [enter] to continue, [ctrl+c] to exit"
echo "now upgrading...."
sudo apt update && sudo apt upgrade -y
clear
echo "check if system's CPU is capable for virtulaization..."
read -p "Press [enter] to continue, [ctrl+c] to quit ..."
sudo apt install cpu-checker -y
kvm-ok
sudo apt-get install qemu-kvm libvirt-bin ubuntu-vm-builder -y
groups
printf "\n"
echo "-------------------------------------------"
echo  "System will now reboot, then perform the ff:"
echo "1. run 'virsh list --all' ; to check if ready for VM creation"
echo "2. run 'ls -la /var/run/libvirt/libvirt-sock'"
echo "3. run 'ls -l /dev/kvm'"
echo "4. run 'sudo apt-get install virt-manager -y'"
echo "--------------------------------------------"
printf "\n"
read -p "press [enter] to continue, [ctrl+c] to quit ..."
sudo reboot
sudo virsh list --all
ls -la /var/run/libvirt/libvirt-sock
ls -l /dev/kvm
sudo apt-get install virt-manager -y

# step 6:
clear
echo "Will create virtual disk and virtual machine ..."
read -p "Press [enter] to continue, [ctrl+c] to exit ..."
sudo qemu-img create -f raw -o size=50G /media/ubuntu1604.img
sudo virt-install --name=juju-controller --disk size=50,sparse=no,path=/media/ubuntu1604.img --virt-type kvm --graphics spice --vcpus=2 --ram=4096 --pxe --network bridge=br0 --os-type=linux --os-variant=ubuntu16.04

# step 7:
# Installing Juju
echo "will install juju ..."
read -p "Press [enter] to continue, [ctrl+c] to exit"
sudo snap install juju --classic
clear
read -p "Adding cloud: press [enter] to continue, [ctrl+c] to exit ..."
