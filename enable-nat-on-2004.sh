Configure NAT on Ubuntu 20.04 Server
Ref: https://linuxhint.com/configure-nat-on-ubuntu/

echo "Step 1. Set the "net.ipv4.ip_forward” parameter of the Gateway/NAT router node by uncommenting it from the /etc/sysctl.conf file"
# Output should be:
# Uncomment the next line to enable packet forwarding for IPv4
# net.ipv4.ip_forward=1

# Ref: https://stackoverflow.com/questions/24889346/how-to-uncomment-a-line-that-contains-a-specific-string-using-sed
# sed -i '/<pattern>/s/^/#/g' file (comment line)
# sed -i '/<pattern>/s/^#//g' file (uncomment line)

sudo sed -i '/net.ipv4.ip_forward=1/s/^#//g' /etc/sysctl.conf    # (to uncomment)
# sed -i '/net.ipv4.ip_forward=1/s/^/#/g' /etc/sysctl.conf  # (to comment out)

echo "Step 2. Enable the changes to above file using the command:"
sudo sysctl -p

# Output should be:
# net.ipv4.ip_forward = 1

echo "Step 3. Install the iptables-persistent package using:"
sudo apt update
sudo apt upgrade -y
sudo apt install iptables-persistent

# show network devices
echo "Showing all the network devices discovered in the system ..."
ip a s

printf "\n"
printf "\n"
echo "***********************************************"

echo "Enter external interface [ex. eno]: "; read EXT
echo "Enter internal interface [ex. br1]: "; read INT

echo "***********************************************"

echo "Step 4. List the already configured iptable policies by issuing the command:"
sudo iptables -L

echo "Step 5. Now mask the requests from inside the LAN with the external IP of NAT router node."
sudo iptables -t nat -A POSTROUTING -o $EXT -j MASQUERADE
sudo iptables -A FORWARD -i $EXT -o $INT -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $EXT -o $INT -j ACCEPT
sudo iptables -t nat -L

echo "Step 6. Save the iptable rules using:"
sudo sh -c "iptables-save > /etc/iptables/rules.v4"

echo "NAT enablement is now complete, thank you !!!"
exit 0
