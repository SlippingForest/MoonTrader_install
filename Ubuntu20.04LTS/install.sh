#!/bin/bash

function color_echo {
	text_red="\e[0;31m"
	text_gold="\e[0;33m"
	text_green="\e[0;32m"
	text_dafault="\e[0m"
	
	case $1 in
		"red")
			echo -e "${text_red}$2${text_dafault}"
		;;
		"gold")
			echo -e "${text_gold}$2${text_dafault}"
		;;
		"green")
			echo -e "${text_green}$2${text_dafault}"
		;;
	esac
}

# Разрешения проходжение трафика на порт 4242 UDP(а так же тригер ввода пароля от root если требуется)
sudo ufw allow 4242/udp > /dev/null 2>&1
clear
# Выбор варианта установки
color_echo green "Choose an installation option"
# echo -e "${text_orange}Choose an installation option${text_dafault}"
PS3="Number: "

select install_type in "Automatic installation of the latest version" "Install your version using the Dropbox link [.tar.xz]" "Install your version using the Dropbox link [.7z]"
do
    break
done

mt_folder="MoonTrader"
while [ -d "$HOME/$mt_folder" ]
do
	clear
  	color_echo gold "[WARNING] Folder $HOME/$mt_folder already exist"
	read -p 'Enter a new folder name: ' new_foldername
	mt_folder=$new_foldername
done
mkdir "$HOME/$mt_folder"

# Скачивание и установка MoonTrader
color_echo green "Download and unpucking MoonTrader to $HOME/$mt_folder/"
case $install_type in
    "Automatic installation of the latest version")
        wget https://cdn3.moontrader.com/beta/linux-x86_64/MoonTrader-linux-x86_64.tar.xz && tar -xpJf MoonTrader-linux-x86_64.tar.xz -C "$HOME/$mt_folder"
		rm MoonTrader-linux-x86_64.tar.xz
    ;;
    "Install your version using the Dropbox link [.tar.xz]")
        read -p 'paste DropBox link [.tar.xz]: ' dropbox_tar_link
        wget -O MoonTrader-linux-x86_64.tar.xz ${dropbox_tar_link%?}1 && tar -xpJf MoonTrader-linux-x86_64.tar.xz -C "$HOME/$mt_folder"
		rm MoonTrader-linux-x86_64.tar.xz
    ;;
    "Install your version using the Dropbox link [.7z]")
        read -p 'paste DropBox link [.7z]: ' dropbox_7z_link
        sudo apt -yqq install p7zip-full > /dev/null 2>&1
        wget -O MoonTrader-linux-x86_64.7z ${dropbox_7z_link%?}1 && 7z x -o"$HOME/$mt_folder" MoonTrader-linux-x86_64.7z
		rm MoonTrader-linux-x86_64.7z
    ;;
    *)
        color_echo red "Wrong answer, exit"
        exit 1
    ;;
esac

if [ -f "$HOME/$mt_folder/MTCore" ]; then
    chmod +x "$HOME/$mt_folder/MTCore"
	sudo rm /usr/bin/MoonTrader
    sudo ln -s "$HOME/$mt_folder/MTCore" /usr/bin/MoonTrader
	color_echo green "Update /usr/bin/MoonTrader link to $HOME/$mt_folder/MTCore"
else
    color_echo red "Wrong link, exit"
    exit 1
fi

# Удаление менеджера пакетов snap
sudo apt -yqq remove snapd --purge
sudo rm -rf ~/snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd

# Удаление почтового сервера EXIM(если он есть)
sudo apt -yqq remove exim exim4

# Установка всех критических обновлений операционной системы
sudo apt update && sudo apt -yqq upgrade

# Уставка стабильного ядра linux и установка его по умолчанию при запуске
# sudo apt -yqq install linux-headers-5.4.0-104-generic linux-image-5.4.0-104-generic
# sudo sed -i "s/GRUB_DEFAULT=0/GRUB_DEFAULT='Advanced options for Ubuntu>Ubuntu, with Linux 5.4.0-104-generic'/" /etc/default/grub
# sudo update-grub

# Установка fail2ban, для защиты от перебора паролей SSH (3 неудачные попытки в течении 1 часа = бан на 24 часа)
if ! service --status-all | grep -Fq 'fail2ban'; then    
	sudo apt -yqq install fail2ban
	sudo touch /etc/fail2ban/jail.local
	sudo echo "[sshd]" >>/etc/fail2ban/jail.local
	sudo echo "port = ssh" >>/etc/fail2ban/jail.local
	sudo echo "findtime = 3600" >>/etc/fail2ban/jail.local
	sudo echo "maxretry = 3" >>/etc/fail2ban/jail.local
	sudo echo "bantime = 86400" >>/etc/fail2ban/jail.local
	sudo service fail2ban restart
fi

# Установка файлового менеджера Midnight Commander
sudo apt -yqq install mc

# Включение синхронизации времени
sudo timedatectl set-ntp true
sudo systemctl enable systemd-timesyncd
sudo systemctl restart systemd-timesyncd

# Установка .Net
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt update
sudo apt -yqq install apt-transport-https && sudo apt update && sudo apt install -y dotnet-sdk-6.0

# Включение swap если он выключен и RAM меньше 2Gb
if free | awk '/^Swap:/ {exit !$2}'; then
    wall "swap already enabled"
else
    if [ $(awk '/^MemTotal:/{print $2}' /proc/meminfo) -lt 2030664 ]; then
        sudo fallocate -l 2G /swapfile
        sudo chmod 600 /swapfile
        sudo mkswap /swapfile
        sudo swapon /swapfile
        echo "/swapfile none swap sw 0 0" >>/etc/fstab
        wall "RAM < 2GB, swap enabled"
    else
        wall "RAM > 1GB, swap not need"
    fi
fi

# Установка зависимостей для MoonTrader(без них как минимум не работают отчеты)
sudo apt -yqq install libncurses5 libtommath1
sudo ln -s libtommath.so.1 /usr/lib/x86_64-linux-gnu/libtommath.so.0

# Подчищаем установленные не актуальные пакеты
sudo apt -yqq autoremove

# Перезагрузка сервера
wall "The server will be restarted"
sudo reboot
