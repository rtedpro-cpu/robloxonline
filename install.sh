#!/bin/bash

echo "Roblox In Web Browser Server Installer"
sudo apt update
sudo apt install adb unzip wget qemu-kvm docker docker.io -y
sudo systemctl start docker
sudo mkdir /root/rblxweb
sudo wget -O /root/rblxweb/startinstance.sh "https://github.com/rtedpro-cpu/robloxonline/raw/main/startinstance.sh"
sudo wget -O /root/rblxweb/latest.zip https://github.com/rtedpro-cpu/robloxonline/releases/download/2642a/2642a.zip
sudo mkdir /root/rblxweb/dataimages
sudo mkdir /root/rblxweb/gameusers
cd /root/rblxweb/
sudo unzip latest.zip
sudo rm latest.zip
echo "Installation finished!
