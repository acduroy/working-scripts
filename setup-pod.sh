#!/bin/sh
# ******************************************************
# Revision: 1
# Build Date: 05/19/2019
# Program Name: setup-pod.sh
# Usage: ~/.setup-pod.sh
# Author: acd
# ******************************************************

# Backup the current kube folder before deleting
TODATE=$(date +”%d-%b-%Y”)
mkdir ~/.kube_$TODATE
cp ~/.kube/ ~/.kube_$TODATE
rm -rf ~/.kube
mkdir -p ~/.kube
juju scp kubernetes-master/0:config ~/.kube/config
cd .kube/

# Get k8s cluster information 
kubectl cluster-info

# Enable admission controllers
ADMISSION_CONTROLLERS="$(juju ssh kubernetes-master/0 sudo snap get kube-apiserver admission-control)"
juju config kubernetes-master api-extra-args=admission-control=PodSecurityPolicy,$ADMISSION_CONTROLLERS

# Create Namespace
kubectl get namespaces
printf "\n"
echo -n "Enter namespace you want to create [ex. psp-cdk], make sure it is not listed above: "; read NAMESPACE
kubectl create namespace $NAMESPACE

# Create Service Account 
printf "\n"
echo -n "Enter service account username [ex. cert-user]: "; read USER

printf "\n"
kubectl create serviceaccount -n $NAMESPACE $USER
kubectl create rolebinding -n $NAMESPACE $USER --clusterrole=edit --serviceaccount=$NAMESPACE:$USER
alias kubectl-admin='kubectl -n $NAMESPACE'
alias kubectl-user='kubectl --as=system:serviceaccount:$NAMESPACE:$USER -n $NAMESPACE'

# Create Pod Security Policy (PSP) using cdk-psp.yaml file
FOUND_PSP=$(locate -c ~/cdk-psp.yaml) 

if [[ $FOUND_PSP eq 0 ]] 
then
  cp ~/backup-files/cdk-psp.yaml ~/
fi

echo "It will create PSP now using the cdk-psp.yaml ..."
kubectl-admin create -f cdk-psp.yaml
printf "\n"
echo "Check if psp is created successfully .."
kubectl get psp
printf "\n"
echo "Check what storage class exists .."
kubectl get storageclass
printf "\n"

# Create PV and PVC using create-pv.yaml file
FOUND_PVC=$(locate -c ~/create-pv.yaml)

if [[ $FOUND_PVC eq 0 ]] 
then
  cp ~/backup-files/create-pv.yaml ~/
fi

echo "It will create PV and PVC now using create-pv.yaml ..."
kubectl apply -f create-pv.yaml 
printf "\n"
echo "Check if volume is created successfully .."
kubectl get pv
printf "\n"

echo -n "Did you see 'ceph-pv-vol01' above?[Y/n]: ";read ANS
#ANS=$(echo $ANS | awk '{print toupper($0)}') 
if [[ $ANS == "n" ]]; then
  exit 1
  echo "Volume storage was not created successfully ..."
  exit 1
fi

printf "\n"
echo "Check status of persistent volume claim .."
kubectl get pvc
printf "\n"
echo -n "Did you see PVC status as 'BOUND'?[Y/n]:"; read ANS

if [[ $ANS == "N" || $ANS == "n" ]] 
then
  echo "Persistent Volume Claim was not created successfully ..."
  exit
fi

echo "Here's the summary of volume created ..."
kubectl describe pvc ceph-pvc-vol01
printf "\n"

# Create a pod using redis.yaml file
kubectl get pods  
FOUND_REDIS=$(locate -c ~/redis.yaml) 

if [[ $FOUND_REDIS eq 0 ]] 
then
  cp ~/backup-files/redis.yaml ~/
fi

echo "It will now create a pod ..."
kubectl create -f redis.yaml
printf "\n"
echo "Check if  pod is created successfully .."
kubectl get pods |grep -i redis
echo -n "Is redis pod exist? [Y/n]:"; read ANS

if [[ $ANS == "N" || $ANS == "n" ]] 
then
  echo "Creation of pod is NOT successful ..."
else
  echo "SUCCESS !!! you've just created a pod. Continue to deploy kubeflow !!!" 
fi



