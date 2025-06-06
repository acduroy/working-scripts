#!/bin/bash

# Update and Install necessary package
sudo apt update -y
sudo apt install pv -y

# Generate ssh keys 
KEY_PATH="$HOME/.ssh/id_rsa"
PASSPHRASE=""

ssh-keygen -t rsa -b 4096 -q -N "$PASSPHRASE" -f "$KEY_PATH" <<< y
touch $HOME/.ssh/authorized_keys

# Copy public key from source
PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFy1hH8BV94JJwNp4YqWwrkIRars/JvjWPhy66yIXJur6DdX7CQo956JfHwEArSNeQMqodAb3R+MndoE0oAcvjwTwYGhELZ+5BLT95vimLszENHPrdMlgVgEJM0mvCU1njn/CpfqksLYYBCHLtFMuj/teolVGyBiYzRJogmrenj4r6LjCsoqFkVSdXJsxK7wabQcGd8zv1x4lJXD0uetrIOTu3LQAh8ZzkIpkY0nyzPqa6+8kmAOdz7z0l/yNsL2ZIrg8RrzZI51Q/vrP3lhLsC7RQZZFNJyGbfwTUIUNyRBvGzIEDmdn98VZR4fwzwlsNUzpBVArwLJhMUAJIDZ3OYbMFAi/A9CEZZRR5iWsIcJ9RzoqwZ9GkfqpdrVfnhBoFEyLBg8karFCIaW4ASiHIp4RVwugDdiIyWA7g1akeWAz1gMvS11yepMYDQOxZattl8oSRs3QNgpE5D2Ca3LVQgbjIXL1uRTmOqRNXYOpqAdkLQzdjEJCU2EPT2LYtK8s= smci@r12u7-nodec-u22v04"
echo "$PUBLIC_KEY" > $HOME/.ssh/authorized_keys
chmod 600 $HOME/.ssh/authorized_keys
echo "SSH key generated at $KEY_PATH"

# Get the parttion files from source
sudo mkdir $HOME/clone-pxe-environment
cd $HOME/clone-pxe-environment
sudo scp smci@172.17.1.214:$HOME/pxe-weka-rocky/* .

# List all available drives
sudo lsblk -d -o NAME | grep -E '^(sd|nvme)'

# Get target drive 
printf "\n"
read -p "Enter the target drive from above list [ex. sdc]: " target_drive

# Check if target drive is HDD or NVMe
if [[ $target_drive == sd* ]]; then
  sudo sed -i "s/sdi/$target_drive/g" part_table
  sudo sfdisk  /dev/$target_drive <  part_table
  sudo dd if=part1 | sudo pv | sudo dd of=/dev/${target_drive}1  bs=28961
  sudo dd if=part2 | sudo pv | sudo dd of=/dev/${target_drive}2  bs=28961
  sudo dd if=part3 | sudo pv | sudo dd of=/dev/${target_drive}3  bs=28961
else
  sudo sed -i "s/device: \/dev\/nvme2n1/device: \/dev\/${target}/g" part_table_nvme
  sudo sed -i "s/nvme2n1p1/${target_drive}p1/g" part_table_nvme
  sudo sed -i "s/nvme2n1p2/${target_drive}p2/g" part_table_nvme
  sudo sed -i "s/nvme2n1p3/${target_drive}p3/g" part_table_nvme
  sudo sfdisk  /dev/$target_drive <  part_table_nvme
  sudo dd if=part1 | sudo pv | sudo dd of=/dev/${target_drive}p1  bs=28961
  sudo dd if=part2 | sudo pv | sudo dd of=/dev/${target_drive}p2  bs=28961
  sudo dd if=part3 | sudo pv | sudo dd of=/dev/${target_drive}p3  bs=28961
fi

# Error handling message
if [[ $? -eq 0 ]]; then
  echo "Clone is successfull and complete, thanks !!!"
else
  echo "Has encountered problem, please check and redo the clone process ..."
fi
