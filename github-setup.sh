#!/bin/bash

clear 

echo -e "\e[3J"	#disable scroll 



usage(){ 

echo "repositoriy name was not supplied" 

echo "Usage $0 github-setup" 

echo "Ex: $ bridge-networking" 

echo "repositoriy name was not supplied" 

echo "Ex: ./github-setup.sh <name of the repository>" 

exit 1 

} 



# check if repository name is supplied in the command line # 

# if not call usage() function # 

[[ $# -eq 0 ]] && usage 



# check if directory already exist?

count=$(locate -c $1)

if [[ count -gt 0 ]]

then 

   cd $1

   exit 1

else

   # install git package # 

   sudo apt-get install git -y 

   # git configuration setup # 

   git config --global user.name "acduroy" 

   git config --global user.email "acduroy@yahoo.com" 

   git config --global color.ui auto 

   # create repositories at home directory # 

   cd $PWD 

   git clone https://github.com/acduroy/$1.git 

   exit 0 

fi
