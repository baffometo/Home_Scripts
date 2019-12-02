#!/bin/bash -  
#Dropbox

sudo mkdir /opt/dropbox/
cd ~/Downloads/
wget https://www.dropbox.com/download?plat=lnx.x86_64 -O dropbox-linux.tar.gz 

sudo tar xvf dropbox-linux.tar.gz --strip 1 -C /opt/dropbox


echo "Please Inser Username for dropbox"

read user


echo "[Unit]
Description=Dropbox Daemon
After=network.target

[Service]
Type=simple
User=$user
ExecStart=/opt/dropbox/dropboxd
ExecStop=/bin/kill -HUP $MAINPID
Restart=always

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/dropbox.service


sudo systemctl start dropbox
sudo systemctl enable dropbox


