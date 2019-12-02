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

echo "OK Lets start, you selected Home"
sudo apt update
sudo apt upgrade

suddo apt install gimp net-tools conky-all gnome-tweak-tool

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
sudo ./Software/dropbox.sh



#Conky Conky-Manager
sudo add-apt-repository ppa:mark-pcnetspec/conky-manager-pm9
sudo apt update
sudo apt-get install conky-manager
#






