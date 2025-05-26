#!/bin/bash

FILE=$1

while [ -n $FILE ]; do
  # Code to execute if argument is not empty
  case $FILE in 
    "reset-hostname-and-ip")
      echo "Downloading the script to reset the hostname and ip for Weka installation"
      raw_url="https://raw.githubusercontent.com/acduroy/working-scripts/refs/heads/master/reset-hostname-and-ip-assignment-for-weka.sh"
      output_file="reset-hostname-and-ip.sh"
      curl -s -L -o "$output_file" "$raw_url"
      echo "File downloaded successfully to $output_file"
      ;;
    "extract-mac-address")
      echo "Downloading the script to retrieve the MAC addresses for Weka installation"
      raw_url="https://raw.githubusercontent.com/acduroy/working-scripts/refs/heads/master/extract-mac-addresses.sh"
      output_file="extract-mac-addresses.sh"
      curl -s -L -o "$output_file" "$raw_url"
      echo "File downloaded successfully to $output_file"
      ;; 
    *)
      echo "Invalid argument"
      break
      ;;
  esac
done

