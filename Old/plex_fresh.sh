#!/bin/bash -   
#Plex Installer

wget https://downloads.plex.tv/plex-media-server/1.14.1.5488-cc260c476/plexmediaserver_1.14.1.5488-cc260c476_amd64.deb -P ~/Downloads/
sudo dpkg -i ~/Downloads/plexmediaserver*.deb
sudo systemctl enable plexmediaserver.service


cd ~/Downloads
wget https://www.dropbox.com/s/9aofju1eo1lxbfw/plex_icon.jpg?dl=0 -O plexico
if [ -d "~/.icons" ] 
then
sudo mv plexico ~/.icons
else
    sudo mkdir -r ~/.icons
	sudo mv plexico ~/.icons
fi

sudo sed -i '3 s/# deb/deb/' /etc/apt/sources.list.d/plexmediaserver.list
wget -q https://downloads.plex.tv/plex-keys/PlexSign.key -O - | sudo apt-key add -

sudo apt update
sudo apt upgrade

echo "Please Inser Username for Dekstop Icon"

read user

echo "[Desktop Entry]
Encoding=UTF-8
Name=PLex
Type=Link
URL=http://localhost:32400/
Icon=/home/$user/.icons/plexico" > ~/Desktop/plex.desktop

sudo systemctl enable plexmediaserver.service
sudo systemctl start plexmediaserver.service
