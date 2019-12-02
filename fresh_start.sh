#!/bin/bash -   
#title          :fresh_Start
#description    :This is for John Fresh Start
#author         :Baffo  
#date           :20191026
#version        :1.0    
#usage          :
#notes          :       
#bash_version   :4.4.20(1)-release
#============================================================================

clear
figlet Baffo
echo "Hello friend, another fresh install?"
echo "dont you get bored reinstalling OS?"
echo
echo "I see that you installed" 
lsb_release -d
echo 
echo
echo "OK Which one do you need?"
echo

PS3='Please enter your choice: '
options=("Home" "Media Center" "Mining" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Home")
             ./home_fresh.sh
            ;;
        "Media Center")
            ./media_fresh.sh
            ;;
        "Mining")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
