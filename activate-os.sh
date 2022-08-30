#! /bin/bash
# Description: To activate RedHat 8.5 using subscription manager
# Ref: https://access.redhat.com/solutions/253273
# Auth: acd

if [[ $EUID -ne 0 ]]; then
    echo "ERROR: This script must be run as root"
    exit 1
fi

echo "To register and activate RHEL 8.5 on this system"
echo "************************************************"
echo "*"

echo "*  Testing network connectivity"
[[ ! `ping -c 1 www.ubuntu.com` ]] \
    && echo "ERROR: This script requires internet access to function correctly" \
    && exit 1

UN="alecd-smci"
#PASSWD="GodIsGood!67"
PASSWD=`cat .secret.lck | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:garbageKey`

printf "\n"
echo "registering and activating in process, this may take some time ..."
subscription-manager register --username  admin --password secret --auto-attach --force

printf "\n"
echo "Activation is done"
