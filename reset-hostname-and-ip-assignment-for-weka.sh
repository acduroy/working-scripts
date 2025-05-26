#!/bin/bash

usage() {
  echo "Usage: $0 [options] argument#1 argument#2"
  echo "Options:"
  echo "   -h, --help       ->    Show this help message"
  echo "Arguments:"
  echo "  1st argument#1    ->    1 out of 2 dual-port Interfaces of CX7"
  echo "  2nd argument#2    ->    2 out of 2 dual-port Interfaces of CX7"
  echo
  echo " ----------------------------------"
  echo " Instruction to execute the script "
  echo " ----------------------------------"
  echo " 1. Open a terminal console from PXE server"
  echo " 2. Get the script from github"
  echo " 3. Execute the script with two supplied arguments - i.e. the two ports of CX7 network interfaces"
  echo "    Sample command:" 
  echo "    ./reset-hostname-and-ip-for-weka.sh enp2s0f0np0 enp2s0f1np1" 
  exit 1
}

# Function to install required packages
install_packages() {
  sudo yum list installed nmap; sudo yum list installed sshpass
  if [[ $? -ne 0 ]]; then
    sudo yum install nmap sshpass -y
  fi
}

# Function to create host list connected to network
create_hostlist() {
  sudo nmap -sP 192.168.12.0/24 | grep -o "192.168.12.*" > host.txt
  echo "**********************"
  echo "Captured nodes' IPs::"
  echo "**********************"
  cat host.txt
}

# Global variable network interfaces list 
DEVNAME=("$1" "$2")

# Function to restore Hostname and Network Interfaces
restore_data() {
  for node in $(cat host.txt)
  do
    # Restore back hostname to default 'localhost.localdomain'
    CMD="echo 'super123' | sudo -S hostnamectl set-hostname localhost.localdomain"
    sshpass -psuper123 ssh smci@$node $CMD &>/dev/null

    # Disconnect the netwwork interfaces
    for i in {0..1}
    do
      echo "processing interface $DEVNAME[i]"
      CMD="echo 'super123' | sudo -S nmcli dev disconnect iface ${DEVNAME[i]}"
      sshpass -psuper123 ssh smci@$node $CMD &>/dev/null
    done
  done
}

#*****************
# Main Function
#*****************

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  usage
fi

#create_hostlist
restore_data
if [[ $? -ne 0 ]]; then
  echo "Hostname and IPs were restored back to default !!!"
else
  echo "Prgram failed, check for error ...."
fi

