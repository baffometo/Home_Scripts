#!/bin/bash -   
#title          :media_fresh
#description    :This is a script for plex and mining
#author         :Baffo  
#date           :20191026
#version        :1.0    
#usage          :
#notes          :       
#bash_version   :4.4.20(1)-release
#============================================================================

clear
echo Welcome to Wanatux v1.0 Installer, we will just get a few things ready.

echo This installer will convert your server to a media center manager.

read -r -p "Do you want to continue? [Y/n] " input
 
case $input in
    [yY][eE][sS]|[yY])
echo "."
echo "."
echo "."
echo "."
 echo "Lets proceed with update/upgrade then install some packages."
echo "."
echo "."
echo "."
echo "."
sudo apt update
sudo apt upgrade 

sudo ubuntu-drivers devices
sudo ubuntu-drivers autoinstall

dpkg-query -l 'nvidia*' &> /dev/null

if [ $? -eq 0 ]; then
    sudo apt install nvidia-cuda-toolkit apt-transport-http mono-devel git-core 
python python-setuptools tzdata 
else
    echo "Package  is NOT installed, not cuda needed!"
fi


#================================================

#Plex Installer
dpkg-query -l 'plexmed*' &> /dev/null

if [ $? -eq 0 ]; then
    echo "Package  is installed!"
else
    sh ./software/plexfresh.sh
fi


#===========================
#Sonar Installer

dpkg-query -l 'nzbdrone*' &> /dev/null

if [ $? -eq 0 ]; then
    echo "Package  is installed!"
else
    sh ./software/sonarr_fresh.sh
fi


#=====================================
#JAcket Installer

if [ -d "/opt/Jackett" ]; then
    echo "Package  is installed!"
else
    sh ./software/jackett.fresh.sh
fi

#=====================================
#Radarr Installer


if [ -d "/opt/Radarr" ]; then
    echo "Package  is installed!"
else
    sh ./software/jackett.fresh.sh
fi

#=====================================

#OMbi Installation

dpkg-query -l 'ombi*' &> /dev/null

if [ $? -eq 0 ]; then
    echo "Package  is installed!"
else
 sh ./software/ombi.fresh.sh

fi





#=====================================
#Tautulli installation


#cd /opt
#sudo git clone https://github.com/Tautulli/Tautulli.git
#sudo addgroup tautulli && sudo adduser --system --no-create-home tautulli --ingroup tautulli
#sudo chown -R tautulli:tautulli /usr/local/share/Tautulli
#sudo cp /usr/local/share/Tautulli/init-scripts/init.freebsd /usr/local/etc/rc.d/tautulli
#sudo sysrc tautulli_enable="YES"

#Enable/Start all Services
#sudo service tautulli start

#=====================================



#Cleaning Download folder
echo "."
echo "."
echo "."
echo "."
echo "."
echo "We are almot done lets just clean trash."
echo "."
echo "."
echo "."
sudo apt update
sudo apt upgrade 

#sudo shutdown -r +1 "Server is going down for software updates/upgrades. Please save your work ASAP."
 ;;
    [nN][oO]|[nN])
 echo "Ok Please try when you are ready"
echo "."
echo "."
echo "."
echo "."
       ;;
    *)
 echo "Invalid input..."
 exit 1
 ;;
esac
