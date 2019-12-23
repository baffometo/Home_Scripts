#!/bin/bash -   
#title          :home
#description    :This is for John Fresh Start
#author         :Baffo  
#date           :20191026
#version        :1.0    
#usage          :
#notes          :       
#bash_version   :4.4.20(1)-release
#============================================================================

echo "Welcome to Wanatux Baffo PC Home Installer"
echo "This will install the following software:"
echo "Gimp, net-tools, Conky, Conky Manager, Gnome-tweak, wine, Atom, Real VNC, chrome-browser, Google driver"

read -r -p "Do you want to continue? [Y/n] " input
 
case $input in
    [yY][eE][sS]|[yY])
	
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

sudo apt install gimp net-tools conky-all gnome-tweak-tool

#Wine
sudo dpkg --add-architecture i386 
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
sudo apt update
sudo apt install --install-recommends winehq-stable -y

#atom install
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install atom

#vns_Server"
cd ~/Downloads
wget https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.6.0-Linux-x86.deb
sudo apt install ~/VNC-Server-*-Linux-x86.deb


#chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb


#Google Drive
sudo apt install gnome-online-accounts
gnome-control-center online-accounts


#Dropbox
#sudo ./Software/dropbox.sh



#Conky Conky-Manager
sudo add-apt-repository ppa:mark-pcnetspec/conky-manager-pm9
sudo apt update
sudo apt-get install conky-manager
#
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





