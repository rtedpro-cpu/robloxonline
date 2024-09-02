#!/bin/bash

echo "Roblox In Web Browser Server Installer"
sudo apt update
sudo apt install adb unzip wget docker docker.io -y
sudo systemctl start docker
sudo mkdir /root/rblxweb
sudo wget -O /root/rblxweb/startinstance.sh "https://github.com/rtedpro-cpu/robloxonline/raw/main/startinstance.sh"
sudo wget -O /root/rblxweb/latest.zip https://github.com/rtedpro-cpu/robloxonline/releases/download/2640a/roblox.zip
sudo mkdir /root/rblxweb/dataimages
sudo mkdir /root/rblxweb/gameusers
cd /root/rblxweb/
sudo unzip latest.zip
sudo rm latest.zip
echo "Installation finished! (Warring client website isnt included so run next installer"
