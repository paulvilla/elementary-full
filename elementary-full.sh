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

        echo -e "${blue}Instalación programas básicos...${NC}";
        sleep 3s;


        apt install dkms vim xterm chromium-browser git gdebi gnome-system-monitor -y

        echo -e "${blue}Instalación de temas e iconos...${NC}";
        sleep 3s;""

        apt install software-properties-common autoconf automake pkg-config libgtk-3-dev gnome-themes-standard gtk2-engines-murrine -y
            cd
            git clone https://github.com/horst3180/arc-theme --depth 1 && cd arc-theme
            ./autogen.sh --prefix=/usr
            make install
            cp /usr/share/themes/elementary/plank/ /usr/share/themes/Arc -R
            cp /usr/share/themes/elementary/plank/ /usr/share/themes/Arc-Dark -R
            cp /usr/share/themes/elementary/plank/ /usr/share/themes/Arc-Darker/ -R
        add-apt-repository ppa:snwh/pulp -y && add-apt-repository ppa:papirus/papirus -y && add-apt-repository ppa:philip.scott/elementary-tweaks -y
            apt update
            apt install paper-icon-theme paper-cursor-theme paper-gtk-theme papirus-icon-theme elementary-tweaks -y

        echo -e "${blue}Instalación secundaria de programas...${NC}";
        sleep 3s;

            apt install libreoffice gimp menulibre kazam -y

            cd && mkdir wlan && cd wlan
                wget https://launchpad.net/ubuntu/+archive/primary/+files/broadcom-sta-dkms_6.30.223.141-1_all.deb
                gdebi -n *.deb

            cd && mkdir sublime && cd sublime 
                wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
                apt install apt-transport-https -y
                echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

            add-apt-repository ppa:videolan/master-daily -y && add-apt-repository ppa:obsproject/obs-studio -y
                apt update && apt update -y
                apt install vlc sublime-text obs-studio kdenlive -y

        echo -e "${blue}Instalación de aplicacines para juegos...${NC}";
        sleep 3s;

            cd && mkdir discord && cd discord
                wget https://dl.discordapp.net/apps/linux/0.0.2/discord-0.0.2.deb
                gdebi -n *.deb

            cd && mkdir teamspeak && cd teamspeak
	    	wget http://dl.4players.de/ts/releases/3.1.6/TeamSpeak3-Client-linux_amd64-3.1.6.run
                chmod +x *.run
                ./*.run --quiet
                mv TeamSpeak3-Client-linux_amd64 teamspeak
                mv teamspeak /opt/

            cd && mkdir steam && cd steam
                wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb
                gdebi-gtk --non-interactive --auto-close *.deb

            apt install playonlinux -y

            apt update && apt upgrade -y && apt autoremove -y

            # Si te da error Steam al iniciarlo lanza estos comandos
            #rm $HOME/.local/share/Steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu/libgcc_s.so.1
            #rm $HOME/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libstdc++.so.6

    else
        echo -e "${red}No tienes conexión para instalar correctamente los modulos${NC}";
        sleep 3s;

        echo -e "${blue}Cerrando Script automaticamante${NC}";
        sleep 3s;
        clear;
    fi
fi

