#!/bin/bash

# This program is a Main menu to run various commands on RHEL7 system
# Copyright (C) 2019  Alec Duroy

clear

while [ 1 ]
do
CHOICE=$(
whiptail --title "RHEL7 Systems" --menu "Make your choice" 16 100 9 \
	"1)" "Build HTTP server Only."   \
	"2)" "Build Local Repository for RHEL7 DVD iso."  \
	"3)" "Build NFS server Only." \
	"4)" "Build KVM server." \
	"5)" "Build PXE server." \
	"6)" "Build DHCP server." \
	"9)" "End script"  3>&2 2>&1 1>&3	
)


result=$(whoami)
case $CHOICE in
	"1)")   
		result="Building a HTTP server for RHEL7 system ..."
		command="$HOME/script-to-run/create-http-server.sh"
		source $command
	;;
	"2)")   
	        OP=$(uptime | awk '{print $3;}')
		result="This system has been up $OP minutes"
	;;

	"3)")   
	        p=$(ps ax | wc -l)
                t=$(ps amx | wc -l)
		result="Number of processes $p\nNumber os threads $t"
        ;;

	"4)")   
	        contextSwitch
		read -r result < result
        ;;

	"5)")   
                userKernelMode
		read -r result < result
        ;;

	"6)")   
		interupts
		read -r result < result
        ;;

	"9)") exit
        ;;
esac
whiptail --msgbox "$result" 20 78
done
exit