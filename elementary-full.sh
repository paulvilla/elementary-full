#!/bin/bash

blue='\e[1;38;5;27m'
red='\e[1;38;5;160m'
green='\e[1;38;5;46m'
NC='\e[0m'

clear;
FILE="/tmp/out.$$"
GREP="/bin/grep"
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
	echo -e "${red}Inicia el Script como root para que funcione${NC}";
	sleep 3s;
	clear;
	exit 1;
else
    echo -e "${blue}Vamos a comprobar si tienes conexion para poder instalar todos los modulos:${NC}";
    sleep 5s;
    if netcat -z google.com 80 &>/dev/null; then
        echo -e "${green}Tienes conexión, iniciando la instalación...${NC}";
        sleep 3s;

        echo -e "${blue}Actualizando el sistema...${NC}";
        sleep 3s;
            apt update && apt upgrade -y

        echo -e "${blue}Instalación de programas iniciales...${NC}";
        sleep 3s;
            apt install vim xterm chromium-browser -y

        echo -e "${blue}Instalación de temas e iconos...${NC}";
        sleep 3s;

            apt install software-properties-common -y
            add-apt-repository ppa:philip.scott/elementary-tweaks -y && add-apt-repository ppa:snwh/pulp -y && add-apt-repository ppa:papirus/papirus -y && add-apt-repository ppa:menulibre-dev/devel -y && add-apt-repository ppa:yunnxx/elementary -y
            apt update
            apt install autoconf automake pkg-config libgtk-3-dev git gnome-themes-standard gtk2-engines-murrine -y
            apt install elementary-tweaks paper-icon-theme paper-cursor-theme paper-gtk-theme papirus-icon-theme menulibre elementary-indicator-places -y
            cd
            git clone https://github.com/horst3180/arc-theme --depth 1 && cd arc-theme
            ./autogen.sh --prefix=/usr
            make install
            cp /usr/share/themes/elementary/plank/ /usr/share/themes/Arc -R
            cp /usr/share/themes/elementary/plank/ /usr/share/themes/Arc-Dark -R
            cp /usr/share/themes/elementary/plank/ /usr/share/themes/Arc-Darker/ -R

        echo -e "${blue}Instalación secundaria de programas...${NC}";
        sleep 3s;
            apt install dkms libreoffice gimp -y

        echo -e "${blue}Última instalación de programas...${NC}";
        sleep 3s;

            cd && mkdir wlan && cd wlan && wget https://launchpad.net/ubuntu/+archive/primary/+files/broadcom-sta-dkms_6.30.223.141-1_all.deb && dpkg -i *.deb
            cd && mkdir discord && cd discord && wget https://dl.discordapp.net/apps/linux/0.0.2/discord-0.0.2.deb && dpkg -i *.deb && apt install -f -y
            add-apt-repository ppa:videolan/master-daily -y && apt update && apt install vlc -y
            cd && mkdir sublime && wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - && apt install apt-transport-https -y && echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list && apt update && apt install sublime-text -y
	    
	    cd && mkdir steam && wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb && dpkg -i *.deb -y && apt install -f -y
            apt install playonlinux -y
            add-apt-repository ppa:xorg-edgers/ppa -y && apt update && apt update -y
            cd && mkdir teamspeak && cd teamspeak && wget http://dl.4players.de/ts/releases/3.1.6/TeamSpeak3-Client-linux_amd64-3.1.6.run && chmod +x TeamSpeak3-Client-linux_amd64-3.1.6.run && ./TeamSpeak3-Client-linux_amd64-3.1.6.run --quiet
            mv TeamSpeak3-Client-linux_amd64 teamspeak && mv teamspeak /opt/

    else
        echo -e "${red}No tienes conexión para instalar correctamente los modulos${NC}";
        sleep 3s;

        echo -e "${blue}Cerrando Script automaticamante${NC}";
        sleep 3s;
        clear;
    fi
fi
