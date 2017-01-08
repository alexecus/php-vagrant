# Restart the network manager
# This is a bug with Vagrant 1.9.1 with newer Linux distros
# like Centos 7
nmcli connection reload
systemctl restart network.service
