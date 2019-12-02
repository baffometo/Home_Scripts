#!/bin/bash -  

#Sonarr install

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0xA236C58F409091A18ACA53CBEBFF6B99D9B78493
echo "deb http://apt.sonarr.tv/ master main" | sudo tee /etc/apt/sources.list.d/sonarr.list
sudo apt install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list

sudo apt update
sudo apt upgrade

sudo apt install nzbdrone 

#SOnarr auto start file

read -r -p "Do you want to specify username and group? [Y/n] if no is selected it  will use root for both " input
 
case $input in
    [yY][eE][sS]|[yY])
 echo "Yes"

echo "Please Inser Username for Ssonarr"

read user

echo "Now Enter group"

read group

echo "[Unit]
Description=Sonarr Daemon
After=network.target

[Service]
User=$user
Group=$group

Type=simple
ExecStart=/usr/bin/mono /opt/NzbDrone/NzbDrone.exe -nobrowser
TimeoutStopSec=20
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target" > /lib/systemd/system/sonarr.service

 ;;
    [nN][oO]|[nN])
 echo "No"
echo "[Unit]
Description=Sonarr Daemon
After=network.target

[Service]
User=root
Group=root

Type=simple
ExecStart=/usr/bin/mono /opt/NzbDrone/NzbDrone.exe -nobrowser
TimeoutStopSec=20
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target" > /lib/systemd/system/sonarr.service

       ;;
    *)
 echo "Invalid input..."
 exit 1
 ;;
esac

#Sonarr Desktop Icon
cd ~/Downloads/
wget https://www.dropbox.com/s/9p60wken45bjweu/256.png?dl=0 -O sonarrico
sudo cp sonarrico ~/.icons
echo "[Desktop Entry]
Encoding=UTF-8
Name=Sonarr
Type=Link
URL=http://localhost:8989/
Icon=/home/baffometo/.icons/sonarrico" > ~/Desktop/sonarr.desktop

sudo systemctl enable sonarr.service


