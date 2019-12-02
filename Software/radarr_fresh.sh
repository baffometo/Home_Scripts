#!/bin/bash -  

#Radarr 
 install
sudo apt update && apt install curl mediainfo
cd /opt
curl -L -O $( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 )
tar -xvzf Radarr.develop.*.linux.tar.gz

#Radarr auto start file
read -r -p "Do you want to specify username and group? [Y/n] if no is selected it  will use root for both " input
 
case $input in
    [yY][eE][sS]|[yY])
 echo "Yes"

echo "Please Inser Username for Ssonarr"

read user

echo "Now Enter group"

read group

echo "[Unit]
Description=Radarr Daemon
After=syslog.target network.target

[Service]
# Change the user and group variables here.
User=$user
Group=$group

Type=simple

# Change the path to Radarr or mono here if it is in a different location for you.
ExecStart=/usr/bin/mono --debug /opt/Radarr/Radarr.exe -nobrowser
TimeoutStopSec=20
KillMode=process
Restart=on-failure

# These lines optionally isolate (sandbox) Radarr from the rest of the system.
# Make sure to add any paths it might use to the list below (space-separated).
#ReadWritePaths=/opt/Radarr /path/to/movies/folder
#ProtectSystem=strict
#PrivateDevices=true
#ProtectHome=true

[Install]
WantedBy=multi-user.target" > /lib/systemd/system/radarr.service

 ;;
    [nN][oO]|[nN])
 echo "No"
echo "[Unit]
Description=Radarr Daemon
After=syslog.target network.target

[Service]
# Change the user and group variables here.
User=root
Group=root

Type=simple

# Change the path to Radarr or mono here if it is in a different location for you.
ExecStart=/usr/bin/mono --debug /opt/Radarr/Radarr.exe -nobrowser
TimeoutStopSec=20
KillMode=process
Restart=on-failure

# These lines optionally isolate (sandbox) Radarr from the rest of the system.
# Make sure to add any paths it might use to the list below (space-separated).
#ReadWritePaths=/opt/Radarr /path/to/movies/folder
#ProtectSystem=strict
#PrivateDevices=true
#ProtectHome=true

[Install]
WantedBy=multi-user.target" > /lib/systemd/system/radarr.service


       ;;
    *)
 echo "Invalid input..."
 exit 1
 ;;
esac

#Radarr Desktop Icon

cd ~/Downloads/
wget  https://www.dropbox.com/s/4m6n98lxe19zaui/25025331.png?dl=0 -O radarrico
sudo cp radarrico ~/.icons
echo "[Desktop Entry]
Encoding=UTF-8
Name=Radarr
Type=Link
URL=http://localhost:7878/
Icon=/home/baffometo/.icons/radarrico" > ~/Desktop/radarr.desktop

sudo systemctl enable radarr.service

