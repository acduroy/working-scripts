#!/bin/bash
#Description: 203-deploy-cn1-by-cn2-via-xCAT
# # The (203-deploy-cn1-by-cn2-via-xCAT) script
#
##! Goal: Deploy another control node by xCAT
#
##! Assumption_1: the target node have network capability
#
# The work flows are listed below:
#
# 1. xCAT server prepare/set-up DB for the target node including
#    - disk configuration (LVM)
#    - /etc/hosts
#    - network set-up (static naming)
#    - post install script preparation (for after reboot)
#      * if target node is control node type, install xCAT
#      * if target node is control node type, export NFS /opt_shared/
#      * ssh set-up
#
# 2. xCAT server start to deploy the target node (in sequence)
#      * check/set the target node boot mode and 1st boot option (PXE boot)
#      * deploy the target node
#      * post installation/setup after the target node is rebooted
#      * validate followings:
#        -- record kernel/node info
#        -- check hostname, networking, disk configuration
#        -- ssh set-up
#      * check the target node 1st boot option
#      * update the BOM if needed
#      * update the summary results under /opt_shared (in the xCAT server)

# Script will exit once error encountered
set -e

#***************************
#Global variables definition
#***************************
HN=$(hostname -s)
DN=$(hostname -d)
WD="/home/kapl/dryrun-alec"

# get the file config/cluster-node-info 
cn_info=$(find $WD -name cluster-node-info.txt)
f1=$?

# extract ip addresses of control node via config/cluster-node-info
IP_ADDR1=$(cat $cn_info | grep -i "${HN}" | awk '{print $5}' | awk '{print $1}' FS=";" | awk '{print $2}' FS="/")
IP_ADDR2=$(cat $cn_info | grep -i "${HN}" | awk '{print $5}' | awk '{print $2}' FS=";" | awk '{print $2}' FS="/")
f1=$(($? + $f1))
   
# get external net device via route command
NETDEV1=$(ip a s | grep -i "${IP_ADDR1}" | awk '{print $(NF)}')
NETDEV2=$(ip a s | grep -i "${IP_ADDR2}" | awk '{print $(NF)}')
f1=$(($? + $f1))

# get external net device via route command
EXT_DEV=$(route -n | awk '{print $8}' | head -n 3 | tail -n 1)
printf "external network device = %s \n" "$EXT_DEV"

#  check to identify which is internal and external network devices
if [[ $NETDEV1 == $EXT_DEV ]]; then
    XCAT_EXT_DEV=$NETDEV1
    XCAT_INT_DEV=$NETDEV2
    XCAT_INT_IP=$IP_ADDR2
    # save function flag
    f1=$(($? + $f1))
else
    XCAT_EXT_DEV=$NETDEV2
    XCAT_INT_DEV=$NETDEV1
    XCAT_INT_IP=$IP_ADDR1
    # save function flag
    f1=$(($? + $f1))
fi

printf "\n"
echo "**************************"
echo "1. Configure site table."
echo "**************************"
printf "\n"

#*************************************************************
#Set the dns to forward requests for the (dns_ext_ip) network"
#Set the domain to (cluster_dom),
#Set the master and nameserver to (dns_ext_ip),
#Set eth1 to be the dhcp server interface
#*************************************************************
echo "Display current site table ..."
tabdump site

echo "Saved current site table at /tmp folder"
tabdump -f /tmp/site.cssv site

# Modify some attributes' value of the site table
# 1. dhcpinterfaces = <internal_ifname>
# 2. dnsinterfaces = <internal_ip>
# 3. master = <internal_ip>
# 4. nameservers = <internal_ip>
# 5. domain = "polab"

# Modify forwarders attribute value
cmd=$(cat /tmp/site.csv | grep -i "forwarders")
# set status flag
s1=$?

if [[ $(echo $cmd) ]]; then
    # Get current
    f=$(echo $cmd | awk -F "," '{print $2}')
    # assign a value
    echo $cmd | sudo sed -i "s|$f|"\"$XCAT_INT_IP\""|" /tmp/site.csv
    s1=$(($s1 + $?))
else
    # assign a value via chdef
    sudo -i chdef -t site forwarders="$XCAT_INT_IP"
    s1=$(($s1 + $?))
fi

# Modify master attribute value
cmd=$(cat /tmp/site.csv | grep -i "master")
if [[ $(echo $cmd) ]]; then
    # Get current
    f=$(echo $cmd | awk -F "," '{print $2}')
    # assign a value
    echo $cmd | sudo sed -i "s|$f|"\"$XCAT_INT_IP\""|" /tmp/site.csv
    s1=$(($s1 + $?))
else
    # assign a value via chdef
    sudo -i chdef -t site master="$XCAT_INT_IP"
    s1=$(($s1 + $?))
fi

# Modify domain attribute value
cmd=$(cat /tmp/site.csv | grep -i "domain")
if [[ $(echo $cmd) ]]; then
    # Get current
    f=$(echo $cmd | awk -F "," '{print $2}')
    # assign a value
    echo $cmd | sudo sed -i "s|$f|"\"$DN\""|" /tmp/site.csv
    s1=$(($s1 + $?))
else
    # assign a value via chdef
    sudo -i chdef -t site domain="$DN"
    s1=$(($s1 + $?))
fi

# Modify nameserver attribute
cmd=$(cat /tmp/site.csv | grep -i "nameservers")
s1=$(($s1 + $?))
if [[ $(echo $cmd) ]]; then
    # Get current
    f=$(echo $cmd | awk -F "," '{print $2}')
    # assign a value
    echo $cmd | sudo sed -i "s|$f|"\"$XCAT_INT_IP\""|" /tmp/site.csv
    s1=$(($s1 + $?))
else
    # assign a value via chdef
    sudo -i chdef -t site master="$XCAT_INT_IP"
    s1=$(($s1 + $?))
fi

# Modify dhcpinterfaces attribute
cmd=$(cat /tmp/site.csv | grep -i "dhcpinterfaces")
s1=$(($s1 + $?))
if [[ $(echo $cmd) ]]; then
    # Get current
    f=$(echo $cmd | awk -F "," '{print $2}')
    # assign a value
    echo $cmd | sudo sed -i "s|$f|"\"$XCAT_INT_DEV\""|" /tmp/site.csv
    s1=$(($s1 + $?))
else
    # assign a value via chdef
    sudo -i chdef -t site dhcpinterfaces="$XCAT_INT_DEV"
    s1=$(($s1 + $?))
fi

# Modify dnsinterfaces
#cmd=$(cat /tmp/site.csv | grep -i "dhcpinterfaces")
#s1=$(($s1 + $?))
#if [[ $(echo $cmd) ]]; then
#    # Get current
#    f=$(echo $cmd | awk -F "," '{print $2}')
#    # assign a value
#    echo $cmd | sudo sed -i "s|$f|"\"$XCAT_INT_IP\""|" /tmp/site.csv
#    s1=$(($s1 + $?))
#else
#    # assign a value via chdef
#    read -p "Im  in ...,  press CTRL+C to exit"
#    sudo -i chdef -t site master="$XCAT_INT_IP"
#    s1=$(($s1 + $?))
#fi

# save all new values 
echo "Saving all changes to the site table"
read -p "Press [enter] to continue, CTRL+C to quit"
sudo -i tablerestore site.csv
s1=$(($s1 + $?))
echo "Site table setup done ..."

printf "\n"
echo "**************************************"
echo " Step 2. Setup the xCAT networks table"
echo "**************************************"
printf "\n"

# Get Internal and External Networks 
_xcat_int_net=$(ipcalc -n $XCAT_INT_IP/24 | sed 's/NETWORK=//' | tr '.' '_')
_xcat_ext_net=$(ipcalc -n $XCAT_EXT_IP/24 | sed 's/NETWORK=//' | tr '.' '_')
xcat_int_net=$(ipcalc -n $XCAT_INT_IP/24 | sed 's/NETWORK=//')
xcat_ext_net=$(ipcalc -n $XCAT_EXT_IP/24 | sed 's/NETWORK=//')
# save status flag
s2=$?

# Display extracted network infos
echo "internal MGT IF Name  = ${XCAT_INT_DEV}"
echo "internal IP           = ${XCAT_INT_IP}"
echo "external MGT IF Name  = ${XCAT_EXT_DEV}"
echo "external IP           = ${XCAT_EXT_IP}"
echo "internal network      = ${xcat_int_net}"
echo "external network      = ${xcat_int_net}"
echo "xcat internal network = ${_xcat_int_net}"
echo "xcat external network = ${_xcat_ext_net}"
# save status flag
s2=$(($s2 + $?))
printf "\n"
read -p "Press {enter] to continue; Ctrl+C to quit"

#tabedit networks
#netname,net,mask,mgtifname,gateway,dhcpserver,tftpserver,nameservers,dynamicrange,nodehostname,comments,disable
#"10_100_218_0-255_255_255_0","10.100.218.0","255.255.255.0","br0","10.100.218.1",,"<xcatmaster>",,,,"10.100.218.100-10.100.218.200",,,,,,,"1500",,
#"172_17_30_0-255_255_255_0","172.17.30.0","255.255.255.0","ens6f1","<xcatmaster>",,"<xcatmaster>",,,,,,,,,,,"1500",,

# Retrieve current network table
printf "\n"
echo "Retrieving current networks table ..."
sudo -i tabdump -f /tmp/networks.csv networks
# save status flag
s2=$(($s2 + $?))
cat /tmp/networks.csv
printf "\n"
read -p "Press [Enter] to continue, Ctrl+C to quit: "

# Modify the file accordingly
printf "\n"
# Column Description: netname(c1),net(c2),mask(c3),mgtifname(c4),gateway(c5),dhcpserver(c6),nsmeserver(c7),dynamicrange(c11)
# Verify correct gateway. Get the column, row, and the current gw ip value 
col_num=$(head -1 /tmp/networks.csv | tr ',' '\n' | grep -nw "gateway" | cut -d':' -f1)
row_cnt=$(cat /tmp/networks.csv | awk -F"," '{print $col_num}' | wc -l)
row_cnt=$(($row_cnt -1))
row_index=2

# Get all ifname 
ifnames=($(tail -n $row_cnt /tmp/networks.csv | awk -F"," '{print $4}'))

# Get current gateway IP of internal device
gw_ip=$(cat /tmp/networks.csv | grep -i $XCAT_INT_DEV| awk -F"," '{print $col}' col="${col_num}") 

# Check all ifname gateway IPs settings
for i in "${ifnames[@]}"
do
    ifname=$(echo $i)
    cat /tmp/networks.csv | awk -v name="$ifname" ' $0 ~ name {print $0}'
    if [[ $fname == $XCAT_INT_DEV ]]; then 
        
        # set current gateway  
        replace=$(echo "\"$XCAT_INT_IP\"")
        awk 'BEGIN{FS=OFS=","}NR==n{$5=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile
        
        # set netname (format: "xx_xx_xx_0-255_255_255_0")
        replace=$(echo "\"${_xcat_int_net}"'-255_255_255_0"')
        awk 'BEGIN{FS=OFS=","}NR==n{$1=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # set net (format: "xx.xx.xx.0")
        replace=$(echo "\"$xcat_int_net\"")
        awk 'BEGIN{FS=OFS=","}NR==n{$2=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # set mask (format: "255.255.255.0")
        replace=$(echo "\"255.255.255.0\"")
        awk 'BEGIN{FS=OFS=","}NR==n{$3=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # set mgtifname (format: ex. "eno2")
        replace=$(echo "\"$XCAT_INT_DEV\"")
        awk 'BEGIN{FS=OFS=","}NR==n{$4=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # set dhcpserver (format: ex. xx.xx.xx.1)
        replace=$(echo "\"$XCAT_INT_IP\"")
        awk 'BEGIN{FS=OFS=","}NR==n{$6=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # set tftpserver
        replace=$(echo "\"$XCAT_INT_IP\"")
        awk 'BEGIN{FS=OFS=","}NR==n{$1=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # set nameservers
        replace=$(echo "\"$XCAT_INT_IP\"")
        awk 'BEGIN{FS=OFS=","}NR==n{$1=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # Once all are set, restore networks tab
        cat nfile
        printf "\n"
        echo "Settings above is the proposed new networks table:"
        read -p "Press [enter] to continue, ctrl+c to quit: "
        cat nfile 2>&1 | sudo tee /tmp/networks.csv
    else
        # if network device is NOT the provisioning interface, set gateway value to xcatmaster
        replace=$(echo "\"<xcatmaster\"")
        awk 'BEGIN{FS=OFS=","}NR==n{$5=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile
        cat nfile | sudo tee /tmp/networks.csv
        
        # set netname (format: "xx_xx_xx_0-255_255_255_0")
        replace=$(echo "\"${_xcat_ext_net}"'-255_255_255_0"')
        awk 'BEGIN{FS=OFS=","}NR==n{$1=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # set net (format: "xx.xx.xx.0")
        replace=$(echo "\"$xcat_ext_net\"")
        awk 'BEGIN{FS=OFS=","}NR==n{$2=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # set mask (format: "255.255.255.0")
        replace=$(echo "\"255.255.255.0\"")
        awk 'BEGIN{FS=OFS=","}NR==n{$3=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # set mgtifname (format: ex. "eno2")
        replace=$(echo "\"$XCAT_EXT_DEV\"")
        awk 'BEGIN{FS=OFS=","}NR==n{$4=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # set dhcpserver (format: ex. xx.xx.xx.1)
        replace=""
        awk 'BEGIN{FS=OFS=","}NR==n{$6=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # set tftpserver
        replace=""
        awk 'BEGIN{FS=OFS=","}NR==n{$1=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # set nameservers
        replace=""
        awk 'BEGIN{FS=OFS=","}NR==n{$1=a}1' n=$row_index a=$replace /tmp/networks.csv > nfile

        # Once all are set, restore networks tab
        cat nfile
        printf "\n"
        echo "Settings above is the proposed new networks table:"
        read -p "Press [enter] to continue, ctrl+c to quit: "
        cat nfile 2>&1 | sudo tee /tmp/networks.csv
    fi
    row_index=$(($row_index + 1))
done 

# save status flag
s2=$(($s2 + $?))

# Save new network settings
printf "\n"
echo "New settings are ready to be saved into the networks table ..."
read -p "Press {enter] to continue, ctrl+c to quit: "
sudo -i tabrestore /tmp/networks.csv
# save status flag
s2=$(($s2 + $?))
echo "Network table setup done ..."

printf "\n"
echo "**************************************"
echo " Step 3. Setup the xCAT noderes table "
echo "**************************************"
printf "\n"

# Display current noderes table
echo "Display current node resources ... "
sudo -i tabdump noderes
s3=$?
printf "\n"
read -p "Press [Enter] to continue, Ctrl+C to quit: " 

# Retrieve current noderes table
printf "\n"
echo "Retrieve and dump current noderes info at tmp directory ..."
sudo -i tabdump -f /tmp/noderes.csv noderes
s3=$(($s3 + $?))

# Modify and display current noderes table
printf "\n"
echo "Making changes to the current noderes table ... "

# check hostname -s
hn=$(hostname -s)
if [[ $hn == "cn1" ]]; then
    xcat_hn="cn2"
else
    xcat_hn="cn1"
fi

# format hostname before entering to the table
tab_hn="\"${xcat_hn}\""

# clear the contents of nfile file
head -1 nfile | tee nfile

# input the new data to the table
printf "\n"
echo "$tab_hn,,"xnba",,,,,,,,,,,,,,,,,,," >> nfile
cat nfile

# status flag 
s3=$(($s3 + $?))

# Prompt user to save or skip new settings
printf "\n"
echo "New table as shown above:"
read -p "Press [Enter] to save new settings, Ctrl+C to quit without saving: "
sudo  cat nfile | sudo tee  /tmp/noderes.csv
sudo -i tabrestore /tmp/noderes.csv

# check status flg
s3=$(($s3 + $?))
echo "Noderes table setup done ..."

printf "\n"
echo "************************************"
echo " Step 4. Setup the xCAT passwd table"
echo "************************************"
printf "\n"

#tabedit passwd
#key,username,password,comments,disable
#"omapi","xcat_key","xxxxxxxxxx=",,
#"system","root","passw0rd",,

# Display passwd table
printf "\n"
echo "Display current passwd table ..."
sudo -i tabdump passwd

# Retrieve current passwd settings
printf "\n"
echo "Retrieve and dump current passwd table to tmp directory ..."
sudo -i tabdump -f /tmp/passwd.csv passwd

# Make changes to passwd table settings
printf "\n"
echo "New passwd table settings below ..."
sudo -i chtab key=system passwd.username=root passwd.password=Kapl@2022

# Update status flag
s4=$?

# Save changes to passwd table
printf "\n"
echo "Save new passwd table settings ..."
while true; do
    read -p "Press [s]-save, [e]-edit, [q]-quit: " ans
    case $ans in
        [Ss]* ) sudo -i tabrestore /tmp/passwd.csv; (($s4 + $?)); break;;
        [Ee]* ) sudo -i tabedit passwd; (($s4 + $?)); break;;
        [Qq]* ) (($s4 + $?)); break;;
        * ) echo "Please answer '"enter"', '"edit"','"quit"'"; $?;;
    esac
done
echo "Passwd setup is done ..."
s4=$(($s4 + $?))
printf "%s" "$s4"

printf "\n"
echo "***********************************"
echo " Step 5. Setup the xCAT chain table"
echo "***********************************"

#tabedit chain
#node,currstate,currchain,chain,ondiscover,comments,disable
#"n00",,,,,,
#"n01",,,,,,
#"n02",,,,,,

# Display chain table
printf "\n"
echo "Display current chain table settings :"
sudo -i tabdump chain
s5=$?

# Retrieve current chain table 
printf "\n"
echo "Retrieve current chain table and dump it to /tmp directory ..."
sudo -i tabdump -f /tmp/chain.csv chain
s5=$(($s5 + $?))


# Make changes in the chain table
printf "\n"
echo "Make modifications in the chain table ..."
s5=$(($s5 + $?))

# Save new chain table settings
printf "\n"
read -p "

echo "Restore changes to chain table ..."
tabrestore /tmp/chain.csv 
s5=$(($s5 + $?))
echo "Done ..."
echo "Display new settings of chain table ..."
tabdump chain

printf "\n"
echo "**************************************"
echo " Step 6. Setup the xCAT nodetype table"
echo "**************************************"
printf "\n"

tabedit nodetype
#node,os,arch,profile,provmethod,supportedarchs,nodetype,comments,disable
#"n00","centos5.4","x86_64","compute",,,,,
#"n01","centos5.4","x86_64","compute",,,,,
#"n02","centos5.4","x86_64","compute",,,,,

# check hostname
hn=$(hostname -s)
if [[ $hn == "s8cn001"

printf "\n"
echo "**************************************"
echo " Step 7. Setup the xCAT hosts table   "
echo "**************************************"
printf "\n"

tabedit hosts
xcat,(xcat_int_ip)
"n00",(n00_ip)
"n01",(n01_ip)
"n02",(n02_ip)

printf "\n"
echo "**************************************"
echo " Step 8. Setup the xCAT mac table     "
echo "**************************************"
printf "\n"

tabedit mac
"n00","eth0",(mac)
"n01","eth0",(mac)
"n02","eth0",(mac)

printf "\n"
echo "**************************************"
echo " Step 9. Setup the xCAT nodelist table"
echo "**************************************"
printf "\n"

tabedit nodelist
"n00","compute,all",,,
"n01","compute,all",,,
"n02","compute,all",,,

printf "\n"
echo "**************************************"
echo "10. Setup the xCAT nodehm table       "
echo "**************************************"
printf "\n"

tabedit nodehm
"n00","ipmi","ipmi",,,,,,,,,,
"n01","ipmi","ipmi",,,,,,,,,,
"n02","ipmi","ipmi",,,,,,,,,,

printf "\n"
echo "**************************************"
11. Create the hosts file                   "
echo "**************************************"
printf "\n"

# create an entry to the /et/hosts
makehosts all


printf "\n"
echo "**************************************"
12. Create the DHCP files                   "
echo "**************************************"
printf "\n"

# Create dns server via xCAT
makedhcp -n
makedhcp all
service dhcpd restart
chkconfig --level 345 dhcpd on

printf "\n"
echo "**************************************"
echo " Step 13. Edit /etc/resolv.conf       "
echo "**************************************"
printf "\n"

# Add the dns server to the /etc/resolf.conf file
cat <<- RESCFG | tee /etc/resolv.conf
search $XCAT_DOMAIN_NAME
nameserver $XCAT.INT.IP

RESCFG

printf "\n"
echo "**************************************"
echo " Step 14. Build the DNS server        "
echo "**************************************"
printf "\n"

# Setup DNS server via xCAT
makedns
makedns all
service named restart
chkconfig --level 345 named on

printf "\n"
echo "*******************************************************"
echo " Step 15. Routing to the Internet through the Head Node"
echo "*******************************************************"
printf "\n"

echo "iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE" >> /etc/rc.local
echo "echo 1 > /proc/sys/net/ipv4/ip_forward" >> /etc/rc.local

# * Do remember to configure the gateway for each of the compute node to eth1 (private nic) of the Head Node. Go to client private 
# nic /etc/sysconfig/network-scripts/ifcfg-eth0 and add “GATEWAY=(int_ip_address)”

echo "The xCAT server should now be completely configured."

printf "\n"
echo "**************************************"
echo " Step 16. Setup Images                "
echo "**************************************"
printf "\n"

copycds CentOS-5.2-i386-bin-DVD.iso
Note: Do this for the DVD ISO and ”’NOT”’ the cd!

printf "\n"
echo "**************************************"
echo " Step 17. Install the node!           "
echo "**************************************"
printf "\n"

# Bootstrap a node via xCAT
rinstall $nodename

# Check if there is error
if [ $? -eq 0 ]; then
    printf "\n"
    echo "xcat installation done and now exiting"
else
    printf "\n"
    echo "An error has encountered, installation fails"
fi

