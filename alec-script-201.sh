# This (201-deply-xCAT-on-cn2) script is to run the followings:
#
##! Goal: Deploy xCAT on cn2 (control node) under /install directory
#
##! Assumption_1: the OS is already installed with license activated
##! Assumption_2: xCAT downloads are available from internet (Web) or
#								 under /opt_shared/<cn_name>/downloads
# 
# The work flows are listed below:
#
# 1. The target must perform following tasks:
#		- 1. generate /etc/hosts based on config files for the cluster
#		- 2. generate .ssh public/private key
#		- 3. storage (LVM) 
#		- 4. install xCAT
#		- 5. install required servers (i.e. DNS, HTTP, NFS, PXE, etc)
#				 -- make sure /opt_shared/<cn_name> is NFS exported
#		- 6. check the network and install xCAT 
#		- 7. validate the xCAT installation
# 
#!/bin/bash
#Description: xCAT installation on cn2 control node

set -e
clear

#Global Default Values
CLUSTER_DN=polab				
working_dir=/home/kapl/

display_usage() { 
	echo "This script must be run with super-user privileges." 
	echo -e "\nUsage: $0 [arguments] \n" 
} 
 
# display usage if the script is not run as root user 
#if [[ "$EUID" -ne 0 ]]; then 
#    echo "This script must be run as root!" 
#	exit 1
#fi 
 
function exit_handler(){
	SUCCESS=1
	if [ $? -eq 0 ]; then	
		print "\n"
		SUCCESS=1
		echo "step complete with no error"
	else
		print "\n"
		SUCCESS=0
		echo "An error has encountered, exiting !!!"
		exit 1
    fi
}

function check_preinstall (){
	echo "*************************"
	echo "Step 1. Check Pre-install"
	echo "*************************"

    # locate cluster-node-info.txt at current working directory
    cn_info=$(find $working_dir -name cluster-node-info.txt)
    		
	# extract short hostname	
	HN=$(hostname -s)
	echo "Hostname = $HN"
	printf "\n"

	# extract ip addresses of control node via ../config/cluster-node-info
	IP_ADDR1=$(cat $cn_info | grep -i "${HN}" | awk '{print $5}' | awk '{print $1}' FS=";" | awk '{print $2}' FS="/")
	IP_ADDR2=$(cat $cn_info | grep -i "${HN}" | awk '{print $5}' | awk '{print $2}' FS=";" | awk '{print $2}' FS="/")
	echo "ip address #1 = $IP_ADDR1"
	echo "ip address #2 = $IP_ADDR2"
	printf "\n"
	
	# extract network interfaces 
	NETDEV1=$(ip a s | grep -i "${IP_ADDR1}" | awk '{print $(NF)}')
	NETDEV2=$(ip a s | grep -i "${IP_ADDR2}" | awk '{print $(NF)}')
	echo "network device #1 = $NETDEV1"
	echo "network device #2 = $NETDEV2"
	printf "\n"

	# get external net device via route command
	EXT_DEV=$(route -n | awk '{print $8}' | head -n 3 | tail -n 1)	
	echo "external network device = $EXT_DEV"
	
    # identify which network devices are internal and external respectively
	if [[ $NETDEV1 == $EXT_DEV ]]; then
		XCAT_EXT_DEV=$NETDEV1		
		XCAT_INT_DEV=$NETDEV2
		XCAT_INT_IP=$IP_ADDR2
        # save function flag
        f1=$?
	else
		XCAT_EXT_DEV=$NETDEV2
		XCAT_INT_DEV=$NETDEV1
		XCAT_INT_IP=$IP_ADDR1
        # save function flag
        f1=$?
	fi							

    # display network informations      
	printf "\n"	
	echo "External network interface of headnode = ${XCAT_EXT_DEV}"
	echo "Inetrnal network interface of headnode = ${XCAT_INT_DEV}"
	echo "Internal IP address of headnode = ${XCAT_INT_IP}"
	echo "Cluster domain = ${CLUSTER_DN}"				
				
    # remove below  lines once final program is complete
	printf "\n"
	read -p "Enter to continue or Ctrl+c to exit "
    # save function flag
    f1=$(($f1 + $?))
}

function config_hostname(){
	echo 
	echo "*************************"
	echo "Step 2. Configure hostname"
	echo "*************************"
	# Configure	hostname to be FQDN
	if [[ -z $(hostname -d) ]]; then
		HN=$(hostnamectl set-hostname $HN.$CLUSTER_DN)
	fi
	HN=$(hostname)
	FQDN=$(hostname -f)
	DN=$(hostname -d)
	echo "Hostname = $HN"
	echo "Fqdn = $FQDN"
	echo "Domain = $DN"
	f2=$?
}

function add_hostname_sysconf(){
	echo
	echo "*************************************"
	echo "Step 3. Add hostname to system config"
	echo "*************************************"
	# Add the hostname to the /etc/sysconfig/network
	sudo cp /etc/sysconfig/network /etc/sysconfig/network.bak
	cat <<- CFG | sudo tee /etc/sysconfig/network
	NETWORKING=yes
	NETWORKING_IPV6=no
	HOSTNAME=$(hostname -f)
	GATEWAY=$XCAT_INT_IP

CFG

	printf "\n"
	echo "********************"
	echo "New system config:"
	echo "********************"
	cat /etc/sysconfig/network
	f3=$?
}

function config_network(){
	echo
	echo "*************************"
	echo "Step 4. Configure Network"
	echo "*************************"
	# Configure the Ehternet interfaces
	sudo cp /etc/sysconfig/network-scripts/ifcfg-$XCAT_EXT_DEV /etc/sysconfig/network-scripts/ifcfg-$XCAT_EXT_DEV.bak
	sudo cp /etc/sysconfig/network-scripts/ifcfg-$XCAT_INT_DEV /etc/sysconfig/network-scripts/ifcfg-$XCAT_INT_DEV.bak

	# External Network Device
	cat <<- EXTCONF | sudo tee /etc/sysconfig/network-scripts/ifcfg-$XCAT_EXT_DEV 
	TYPE=Ethernet
	PROXY_METHOD=none
	BROWSER_ONLY=no
	BOOTPROTO=dhcp
	DEFROUTE=yes
	IPV4_FAILURE_FATAL=no
	IPV6INIT=no
	IPV6_AUTOCONF=no
	IPV6_DEFROUTE=no
	IPV6_FAILURE_FATAL=no
	PEERDNS=no
	NAME=$XCAT_EXT_DEV
	HWADDR=$(ifconfig $XCAT_EXT_DEV |grep -i "ether" |awk '{print $2}')
	DEVICE=$XCAT_EXT_DEV
	ONBOOT=yes

EXTCONF
    
    # Save function 4 status
	f4=$?

	# Internal Network Device
	cat <<- INTCONF | sudo tee /etc/sysconfig/network-scripts/ifcfg-$XCAT_INT_DEV
	DEVICE=$XCAT_INT_DEV
	BOOTPROTO=none
	DEFROUTE=no
	IPV6INIT=no
	IPV6_AUTOCONF=no
	NAME=$XCAT_INT_DEV
	HWADDR=$(ifconfig $XCAT_INT_DEV |grep -i "ether" |awk '{print $2}')
	IPADDR=$XCAT_INT_IP
	ONBOOT=yes
	PREFIX=24
	GATEWAY=$XCAT_INT_IP
	DNS1=$XCAT_INT_IP
	DOMAIN=$CLUSTER_DN

INTCONF

	#restart internal network device
	sudo ifdown $XCAT_INT_DEV && sudo ifup $XCAT_INT_DEV

    # Save function 4 status
	f4=$?
}

function generate_sshkeys(){
    echo
    echo "****************************************"
    echo "Step 5. Generate private/public ssh-keys"
    echo "****************************************"
    
    #check if ssh-key already generated
    if [[ -z "$HOME/.ssh/id_rsa" ]]; then
        # generate private and public ssh-keys
        echo -e "\n"|ssh-keygen -t rsa -N ""
        # save function 5 status
        f5=$?
        printf "\n"
        echo "new sshkeys were generated ..."
    else
        # backup sshkeys
        sudo cp $HOME/.ssh/id_rsa $HOME/.ssh/id_rsa.bak
        sudo cp $HOME/.ssh/id_rsa.pub $HOME/.ssh/id_rsa.pub.bak
        # saave function 5 status
        f5=$?
        printf "\n"
        echo "old sshkeys remain ..."
    fi
}

function setup_chronyd(){
	echo
	echo "***************************"
	echo "Step 6. Setup time and date"
	echo "***************************"
	# Setup the correct time and timezone by enabling the	chronyd.service
	sudo systemctl start chronyd.service
	sudo systemctl enable chronyd.service
    # save function 6 status
    f6=$?
}

function config_dns(){
	echo 
	echo "*************************"
	echo "Step 7. Configure DNS		"
	echo "*************************"
	# Configure DNS resolution for the management node itself in /etc/resolv.conf
	sudo cp /etc/resolv.conf /etc/resolv.conf.bak
	cat <<- DNSCONF | sudo tee /etc/resolv.conf
	search $(hostname -d)
	nameserver 8.8.8.8

DNSCONF
    # save function 7 status
    f7=$?
}

function setup_etc_hosts(){
	echo
	echo "*************************"
	echo "Step 8. Setup hosts file "
	echo "*************************"
	# Setup basic /etc/hosts file
	sudo cp /etc/hosts /etc/hosts.bak
	cat <<- HOSTCONF | sudo tee -a /etc/hosts
	$XCAT_INT_IP      $(hostname -f)              $(hostname -f | awk '{print $1}' FS=".")

HOSTCONF
    # saave function 8 status
    f8=$?
}

function disable_selinux(){
    # Disble system error checking for this function
    set +e
	echo
	echo "*************************"
	echo "Step 9. Disable SELinux"
	echo "*************************"
	# Disable SELinux at boot
	setenforce 0
    # save function 9 status
    f9=$?

    # Disable SELinux permanently 
	sudo sed -i 's/^SELINUX=.*$/SELINUX=disabled/' /etc/selinux/config
    
    # iterate function 9 status
    f9=$(($? + $f9))
    # enable back system error checking
    set -e
}

function disable_firewall(){
	echo
	echo "*************************"
	echo "Step 10. Disable Firewall"
	echo "*************************"
	# Disable firewall
	sudo systemctl stop firewalld
    # Save function flag status
    f10=$?

	sudo systemctl disable firewalld
    # save function flag status
    f10=$(($f10 + $?))
}

function install_xcat(){
	echo
	echo "*************************"
	echo "Step 11. Install xCAT		"
	echo "*************************"
	# Install xCAT:
	wget https://raw.githubusercontent.com/xcat2/xcat-core/master/xCAT-server/share/xcat/tools/go-xcat 
    # save function flag 
    f11=$?
    
    sudo mv go-xcat /tmp/go-xcat
    # save function flag 
    f11=$(($f11 + $?))

	sudo chmod +x /tmp/go-xcat
    # save function flag 
    f11=$(($f11 + $?))
	
    sudo /tmp/go-xcat --yes install
    # save function flag
    f11=$(($f11 + $?))
}

function check_xcat(){
	echo
	echo
	echo "***************************"
	echo "Step 12. Check xCAT install"
	echo "***************************"

	# Source xCAT command to your profile
	source /etc/profile.d/xcat.sh
    f12=$?

	# Check xCAT version
	lsxcatd -a
    f12=$(($f12 + $?))

	# Check xCAT service is running
    sudo service xcatd start
	sudo service xcatd enable
	sudo service xcatd status
    f12=$(($f12 + $?))


	# Verify xCAT database
	sudo -i tabdump site
    f12=$(($f12 + $?))
	
}

#***********************
# main() program
#**********************
check_preinstall
config_hostname
add_hostname_sysconf
config_network
generate_sshkeys
setup_chronyd
config_dns
setup_etc_hosts
disable_selinux
disable_firewall
install_xcat
#check_xcat

# Display status of each functions
if [[ $f1 == "0" ]]; then 
    status="passed"
else
    status="failed"
fi

printf "\n"
echo "*****************************************************"
echo "Step 1.  Check Pre-Install          --> ${status}"
echo "Step 2.  Config the Hostname        --> ${status}"
echo "Step 3.  Add Hostname to Sysconfig  --> ${status}"
echo "Step 4.  Config the network         --> ${status}"
echo "Step 5.  Generate sshkeys           --> ${status}"
echo "Step 6.  Enable Chronyd Service     --> ${status}"
echo "Step 7.  Setup /etc/resolv.conf     --> ${status}"
echo "Step 8.  Setup /etc/hosts           --> ${status}"
echo "Step 9.  Disable SELinux Service    --> ${status}"
echo "Step 10. Disable Firewall Service   --> ${status}"
echo "Step 11. Install xCAT               --> ${status}"
echo "Step 12. Check xCAT installation    --> ${status}"
echo "*****************************************************"

# Exit script and display message
printf "\n"
if [ $? -eq 0 ]; then
    printf "\n"
    echo "xcat installation done and now exiting"
else
 	printf "\n"
 	echo "An error has encountered, installation fails"
fi
