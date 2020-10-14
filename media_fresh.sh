#!/bin/bash -   
#title          :media_fresh
#description    :This is a script for DB Pi
#author         :Baffo  
#date           :20201013
#version        :1.5    
#usage          :
#notes          :Code has been cleaned and organized, it doesnt ask what software is requiered to install, it will just install everything thats needed for DB    
#bash_version   :4.4.20(1)-release
#============================================================================

clear
figlet Pi Server
echo Welcome to Wanatux v1.0 Installer, we will just get a few things ready.
echo This installer will convert your server to a media center manager.
read -r -p "Do you want to continue? [Y/n] " input 
#Software Install Yes
case $input in
    [yY][eE][sS]|[yY])
		echo
		echo
		echo
		echo
		echo "Lets proceed with update/upgrade then install some packages."
		echo
		echo
		echo
		echo
		sudo apt update -y && sudo apt upgrade -y
		clear
		echo "Here we need to create some folders for the server HDDs"
		echo "It is not recommended to mount the HDDs in the default folder"
		echo "so we will create some folders in /media but we need to change the permissions first"
		echo "we dont want to have this folders under Root so please"
		echo "enter your username here"
		read user
		echo "Now Enter group"
		read group
		cd /media
		sudo mkdir server server2 Movies Cartoon TV Abigail Anime
		sudo chown -R $user:$group /media/server /media/server2 /media/Movies /media/Cartoon /media/TV /media/Abigail /media/Anime

		#Sonar Installer
		clear
		figlet Sonar
		echo "We are about to install Sonarr"
		sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0xA236C58F409091A18ACA53CBEBFF6B99D9B78493
		echo "deb http://apt.sonarr.tv/ master main" | sudo tee /etc/apt/sources.list.d/sonarr.list
		sudo apt install gnupg ca-certificates
		sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
		echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list

		#Jacket Installer
		clear
		figlet Jacket
		echo "We are about to install Jacket"
		sudo apt update && sudo apt install curl mediainfo
		cd /opt
		curl -L -O $( curl -s https://api.github.com/repos/Jackett/Jackett/releases | grep LinuxARM32.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 )
		tar -xvzf Jackett.Binaries.LinuxARM32.tar.gz
		sudo /opt/Jackett/install_service_systemd.sh
		#Radarr Installer
		figlet Radarr
		clear
		echo "We are about to install Radarr"
		sudo apt update && sudo apt install curl mediainfo
		cd /opt
		curl -L -O $( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 )
		tar -xvzf Radarr.develop.*.linux.tar.gz
		#NzGet Installer
		clear
		figlet NzGet
		echo "We are about to install NzGet"
		sudo mkdir /opt/nzbget
		wget https://nzbget.net/download/nzbget-latest-bin-linux.run -P /tmp
		chmod +x /tmp/nzbget-latest-bin-linux.run
		sudo sh /tmp/nzbget-latest-bin-linux.run --destdir /opt/nzbget
		sudo apt update
		sudo apt upgrade
		sudo apt install nzbdrone 
		#Transmission installer 
		figlet Transmission
		echo "We are about to install Transmission"
		sudo apt-get install transmission-cli transmission-common transmission-daemon
		sudo systemctl stop transmission-daemon
		echo "This is Transmission set up and we need to assign the debian-transmission to a specific user "
		echo "Please enter the user here: " 
		read user
		sudo usermod -a -G debian-transmission $user
		sudo chgrp debian-transmission /media/server 
		mkdir /media/server/downloads
		sudo chgrp debian-transmission /media/server/downloads
		sudo chmod 770 /media/server
		sudo chmod 770 /media/server/downloads
		#Samba Installer 
		clear
		figlet Samba
		echo "We are about to install Samba"
		sudo apt-get install samba samba-common-bin smbclient
		
		#############Auto start file#####################################################
		clear
		figlet Start on Boot
		echo "Now we need to create the .service files for auto start for all the applications installed"
		read -r -p "Do you want to specify username and group? [Y/n] if no is selected it  will use root for both: [Y/n] " input
		case $input in
			[yY][eE][sS]|[yY])
				echo "Please Inser Username for Auto Run Files"
				read user
				echo "Now Enter group"
				read group
				#Sonarr
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

				###RadARR auTO#########
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

				[Install]
				WantedBy=multi-user.target" > /lib/systemd/system/radarr.service
				sudo chown -R $user:$group /opt/Radarr 
				;;
			[nN][oO]|[nN])

				#Sonarr
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

				###Nzget#########
				echo "
				[Unit]
				Description=NZBGet
				After=network.target

				[Service]
				User=root
				Group=root
				Type=forking
				ExecStart=/opt/nzbget/nzbget -c /opt/nzbget/nzbget.conf -D
				ExecStop=/opt/nzbget/nzbget -Q
				ExecReload=/opt/nzbget/nzbget -O
				KillMode=process
				Restart=on-failure

				[Install]
				WantedBy=multi-user.target" > /lib/systemd/system/nzbget.service

				##RADARR AUTO###########
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

				[Install]
				WantedBy=multi-user.target" > /lib/systemd/system/radarr.service
			;;
			esac
		#Start Systemctl Files
		sudo systemctl enable sonarr.service jackett.service radarr.service nzbget
		sudo systemctl start sonarr.service jackett.service radarr.service nzbget transmission-daemon 
		clear
		echo
		echo
		echo
		echo
		echo
		echo "We are almost done lets just clean trash."
		echo
		echo
		echo
		sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y
		clear
		echo "Thanks for using this script"
		echo "Here is a list o the IP Addresses"
		echo "Plex: http://localhost:32400/web"
		echo "Sonarr: http://localhost:8989"
		echo "Radarr: http://localhost:7878"
		echo "Jackett: http://localhost:9117"
		echo "NZBGET: http://localhost:6789"
		read -r -p "Do you want to reboot now? [Y/n] " input
		case $input in
			[yY][eE][sS]|[yY])
			### Desktop Creation
			sudo reboot now
			;;
		[nN][oO]|[nN])
		echo "Thanks for using the script"
		figlet Wanatux
		esac
	;;
	[nN][oO]|[nN])
		echo "Ok Please try when you are ready"
		echo "."
		figlet Wanatux
		echo "."	
	;;
	*)
	echo "Invalid input..."
	exit 1

esac

