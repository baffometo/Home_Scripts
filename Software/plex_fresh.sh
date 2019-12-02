#!/bin/bash -   
#Plex Installer

wget https://downloads.plex.tv/plex-media-server/1.14.1.5488-cc260c476/plexmediaserver_1.14.1.5488-cc260c476_amd64.deb -P ~/Downloads/
sudo dpkg -i ~/Downloads/plexmediaserver*.deb
sudo systemctl enable plexmediaserver.service

cd /media
mkdir server server2 server3 server4
mkdir ~/.icons

cd ~/Downloads
wget https://www.dropbox.com/s/un8n4rqacsof4dr/fstab2?dl=0 -O fstab
wget https://www.dropbox.com/s/9aofju1eo1lxbfw/plex_icon.jpg?dl=0 -O plexico

sudo cp fstab /etc/fstab
sudo cp plexico ~/.icons

sudo sed -i '3 s/# deb/deb/' /etc/apt/sources.list.d/plexmediaserver.list
wget -q https://downloads.plex.tv/plex-keys/PlexSign.key -O - | sudo apt-key add -

sudo apt update
sudo apt upgrade

echo "[Desktop Entry]
Encoding=UTF-8
Name=PLex
Type=Link
URL=http://localhost:32400/
Icon=/home/baffometo/.icons/plexico" > ~/Desktop/plex.desktop


sudo systemctl enable plexmediaserver.service
sudo systemctl start plexmediaserver.service

