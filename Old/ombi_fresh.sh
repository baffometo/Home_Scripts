#!/bin/bash -   



#OMbi Installation
echo "deb [arch=amd64,armhf] http://repo.ombi.turd.me/stable/ jessie main" | sudo tee "/etc/apt/sources.list.d/ombi.list"
wget -qO - https://repo.ombi.turd.me/pubkey.txt | sudo apt-key add -
sudo apt update && sudo apt install ombi

cd ~/Downloads/
wget https://www.dropbox.com/s/qblbj3ndlgqy0sc/communityIcon_j21ttug6nka11.png?dl=0 -O ombiico
sudo cp ombiico ~/.icons
echo "[Desktop Entry]
Encoding=UTF-8
Name=Ombi
Type=Link
URL=http://localhost:5000/
Icon=/home/baffometo/.icons/ombiico" > ~/Desktop/ombi.desktop


