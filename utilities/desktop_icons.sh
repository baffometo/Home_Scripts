read -r -p "Do you want to create desktop icons? [Y/n] " input
 
case $input in
    [yY][eE][sS]|[yY])
### Desktop Creation

cd ~/Downloads
wget https://www.dropbox.com/s/9aofju1eo1lxbfw/plex_icon.jpg?dl=0 -O plexico
wget https://www.dropbox.com/s/9p60wken45bjweu/256.png?dl=0 -O sonarrico
wget https://www.dropbox.com/s/r8mwdqqi7tkqfui/28728094-99f3e3f6-73c7-11e7-8f8d-28912dc6ac0d.png?dl=0 -O Jackico
wget https://www.dropbox.com/s/4m6n98lxe19zaui/25025331.png?dl=0 -O radarrico

if [ -d "~/.icons" ] 
then
sudo mv plexico ~/.icons
else
    sudo mkdir ~/.icons
	sudo mv plexico ~/.icons
	sudo mv sonarrico ~/.icons
	sudo mv Jackico ~/.icons
	sudo mv radarrico ~/.icons
fi

clear
echo "Please type Username for Desktop Icon"

read user

#Plex Icon
echo "[Desktop Entry]
Encoding=UTF-8
Name=PLex
Type=Link
URL=http://localhost:32400/web
Icon=/home/$user/.icons/plexico" > ~/Desktop/plex.desktop

#Sonarr Icon
echo "[Desktop Entry]
Encoding=UTF-8
Name=Sonarr
Type=Link
URL=http://localhost:8989/
Icon=/home/$user/.icons/sonarrico" > ~/Desktop/sonarr.desktop

#Radarr
echo "[Desktop Entry]
Encoding=UTF-8
Name=Radarr
Type=Link
URL=http://localhost:7878/
Icon=/home/$user/.icons/radarrico" > ~/Desktop/radarr.desktop

#JAckett Icon
echo "[Desktop Entry]
Encoding=UTF-8
Name=Jackett
Type=Link
URL=http://localhost:9117/
Icon=/home/$user/.icons/Jackico" > ~/Desktop/jackett.desktop

 ;;
    [nN][oO]|[nN])
	echo "Ok Skipping Desktop icons"
       ;;
  *)	
 exit 1
 ;;
esac



#OMbi Installation

# dpkg-query -l 'ombi*' &> /dev/null

# if [ $? -eq 0 ]; then
#     echo "Package  is installed!"
# else
# sh ./Software/ombi.fresh.sh

#fi





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


#sudo ubuntu-drivers devices
#sudo ubuntu-drivers autoinstall

dpkg-query -l 'nvidia*' &> /dev/null

if [ $? -eq 0 ]; then
    sudo apt install nvidia-cuda-toolkit apt-transport-http mono-devel git-core 
python python-setuptools tzdata 
else
    echo "Package  is NOT installed, not cuda needed!"
fi




#sudo mkdir ~/.icons
#wget https://www.dropbox.com/s/un8n4rqacsof4dr/fstab2?dl=0 -O fstab
#sudo cp fstab /etc/fstab

#================================================

#Plex Installer
#wget https://downloads.plex.tv/plex-media-server-new/1.18.4.2171-ac2afe5f8/debian/plexmediaserver_1.18.4.2171-ac2afe5f8_amd64.deb -P ~/Downloads/
#sudo dpkg -i ~/Downloads/plexmediaserver*.deb
#sudo systemctl enable plexmediaserver.service
#sudo sed -i '3 s/# deb/deb/' /etc/apt/sources.list.d/plexmediaserver.list
#wget -q https://downloads.plex.tv/plex-keys/PlexSign.key -O - | sudo apt-key add -




#!/bin/bash
clear
i=$(ifconfig tap0 | awk '{print $2}' | egrep "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
read -p "Enter IP address: " prompt
while [ "$i" != "$prompt" ] ; do
  echo "Wrong IP address"
  read -p "Enter IP address: " prompt
done
echo "Correct IP, congrats"






#===========================