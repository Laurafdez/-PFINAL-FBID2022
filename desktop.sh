#!/bin/bash

# Installation of NoMachine for Ubuntu Desktop
sudo apt update && sudo apt -y upgrade
sudo apt install -y ubuntu-desktop
wget https://download.nomachine.com/download/8.2/Linux/nomachine_8.2.3_4_amd64.deb
sudo apt install ./nomachine_8.2.3_4_amd64.deb
rm nomachine_8.2.3_4_amd64.deb

# Creation of the sudo user
sudo passwd
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo adduser fbid
sudo usermod -a -G sudo,adm fbid
