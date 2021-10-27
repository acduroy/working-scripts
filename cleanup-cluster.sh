#!/bin/bash

while read HOST 
do
    # formatting drives
    sudo sfdisk --delete  /dev/sda
    sudo sfdisk --delete  /dev/sdb
    sudo sfdisk --delete  /dev/sdd
    sudo sgdisk --zap-all  /dev/sda
    sudo sgdisk --zap-all  /dev/sdb
    sudo sgdisk --zap-all  /dev/sdd
    sudo wipefs /dev/sda -af
    sudo wipefs /dev/sdb -af
    sudo wipefs /dev/sdd -af
   
    # deleting ceph files
    sudo rm -rf /var/lib/ceph
    sudo rm -rf /etc/ceph
    sudo rm -f /etc/systemd/system/multi-user.target.wants/ceph*
    sudo rm -f /etc/systemd/system/multi-user.target.wants/ceph*
done < server-list.txt

