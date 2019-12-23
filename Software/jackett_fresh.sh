#!/bin/bash -  

#JAckett INstallation



sudo wget https://github.com/Jackett/Jackett/releases/download/v0.12.869/Jackett.Binaries.LinuxAMDx64.tar.gz -P /opt/
sudo tar -xvzf /opt/Jackett.Binaries.LinuxAMDx64.tar.gz -C /opt/
sudo /opt/Jackett/install_service_systemd.sh

cd ~/Downloads
wget https://www.dropbox.com/s/r8mwdqqi7tkqfui/28728094-99f3e3f6-73c7-11e7-8f8d-28912dc6ac0d.png?dl=0 -O Jackico

if [ -d "~/.icons" ] 
then
    sudo mv Jackico ~/.icons
else
    sudo mkdir -r ~/.icons
	sudo mv Jackico ~/.icons
fi



echo "[Desktop Entry]
Encoding=UTF-8
Name=Jackett
Type=Link
URL=http://localhost:9117/
Icon=/home/baffometo/.icons/Jackico" > ~/Desktop/jackett.desktop

sudo systemctl start jackett.service



