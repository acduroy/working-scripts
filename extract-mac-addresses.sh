#!/bin/bash

usage() {
  echo "Usage: $0 [options] argument"
  echo "Options:"
  echo "   -h, --help       ->    Show this help message"
  echo "Arguments:"
  echo "  no input_file     ->    Will extract data from ALL files in the folder"
  echo "  single input file ->    Will extract data from ONE file in the folder" 
  exit 1
}

# Function to create header
create_header() {
  echo "Date,Chassis Serial,Product Name,Node Serial,Mellanox Type,Hostname,Data IP MacAddresses" >> report.csv
}

# Function to get network devices from user input
get_iface_device() {
  local -n list_devices=$1
  
  printf "\n" 
  echo "*******************"
  echo "List of interfaces:"
  for dev in ${list_devices[@]}; do 
      printf '%4s%s\n' '' "-> ${dev}"
  done
  echo "******************"
  printf "\n"
  read -p "Enter device names space-seperated [ex. eno1 eno2]: " user_input
  printf "\n"
  selected_devices=($user_input)
  
  # convert string to array, variable user_input to if_name
  #IFS=' ' read -r -a selected_devices <<< "$user_input"
    
  valid=true

  for input in "${selected_devices[@]}"; do
    found=false
    for option in "${list_devices[@]}"; do
      if [[ "$input" == "$option" ]]; then
        found=true
        break
      fi
    done
    if ! $found; then
      printf "\n"
      echo "Invalid input: $input"
      valid=false
    fi
  done
  
  if $valid; then
    printf "\n"
    #echo "All inputs are valid."
  else
    printf "\n"
    echo "Invalid input(s) found."
  fi  
  #printf "\n"
  #echo "You've selected interface device names -> ${selected_devices[@]}"
  list_devices=("${selected_devices[@]}")
}

# Function to add data to the CSV Report 
add_data() {
  FILE=$1
  local netdev

  # Date:
  DT=$(cat $FILE | grep -a "Date" | head -1 | cut -d"_" -f20,21,22)

  # Chassis number:
  CSN=$(cat $FILE | grep -a "Chassis Serial Number" -A0 | head -1 | cut -d"_" -f3)

  # Product Name:
  PN=$(cat $FILE  | grep -a "Product Name" | head -1 | cut -d"_" -f12)

  # Node Serial number:
  NS=$(cat $FILE | grep -a "Node Serial" | head -1 | cut -d"_" -f6)

  # Mellanox Type:
  MT=$(cat $FILE | grep -a "Mellanox Type" | head -1 | cut -d"_" -f11)

  # Hostname
  HN=$(cat $FILE | grep -a "Hostname" | head -1 | cut -d"_" -f16)

  # retrieve MAC Addresses for CX7
  if [[ FLAG -eq 0 ]]; then
    netdev=($(cat $FILE | grep -a "BROADCAST" | cut -d":" -f2))
    get_iface_device netdev
    declare -p netdev
    netdev_select=("${netdev[@]}") 
  fi
  DIP1=$(cat $FILE | grep -a "${netdev_select[0]}" -A1 | grep -i "ether" | cut -d" " -f6)
  DIP2=$(cat $FILE | grep -a "${netdev_select[1]}" -A1 | grep -i "ether" | cut -d" " -f6)

  echo "$DT,$CSN,$PN,$NS,$MT,$HN,$DIP1,$DIP2" >> report.csv
}

#*****************
# Main function
#*****************

FLAG=0
# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  usage
fi

# Checck if csv file is missing
if [[ ! -f report.csv ]]; then
  touch report.csv
fi

# Check for no argument 
if [[ $# -eq 0 ]]; then
  # Extract all files found in the folder
  DIR=$(pwd)
  echo "Extracting data in all files at $DIR"
  echo -n "" > report.csv
  create_header 
  for file in $DIR/WEKA*; do
    # Add data rows
    add_data $file 
    FLAG=1
  done
else
  # Extract the provided file	
  if [[ $(cat report.csv) == "" ]]; then
    create_header
  fi
  echo "Extracting data on this file $1:"
  add_data $1
fi

# Show the csv report
cat report.csv
echo 
echo "---------------------------------------------------"
echo "csv file created successfully -> see report.csv !!!"
echo "---------------------------------------------------"

exit 0
