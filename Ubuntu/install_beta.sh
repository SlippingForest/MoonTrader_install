#!/bin/bash

# Функция вывода цветной консоли
function color_echo {
    text_red="\e[0;31m"
    text_gold="\e[0;33m"
    text_green="\e[0;32m"
    text_cyan="\e[0;36m"
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
        "cyan")
            echo -e "${text_cyan}$2${text_dafault}"
        ;;
    esac
}

# Выбор варианта установки
clear
color_echo cyan "Choose an installation option"
PS3="Enter number option: "
select install_type in "Automatic installation of the latest version" "Install your version using the Dropbox link [.tar.xz]" "Install your version using the Dropbox link [.7z]"
do
    clear
    case $install_type in
        "Automatic installation of the latest version")
            mt_link="https://cdn3.moontrader.com/beta/linux-x86_64/MoonTrader-linux-x86_64.tar.xz"
            mt_extention=".tar.xz"
            break
        ;;
        "Install your version using the Dropbox link [.tar.xz]")
            read -p "paste DropBox link [.tar.xz]: " mt_link
            while ! [[ $mt_link == *".tar.xz"* ]]; do
                clear
                color_echo red "[ERROR] Wrong link"
                color_echo gold "[EXAMPLE] https://www.dropbox.com/s/.../archive_name.tar.xz?dl=0"
                read -p "paste DropBox link [.tar.xz]: " mt_link
            done
            mt_link=${mt_link%?}1
            mt_extention=".tar.xz"
            break
        ;;
        "Install your version using the Dropbox link [.7z]")
            read -p "paste DropBox link [.7z]: " mt_link
            while ! [[ $mt_link == *".7z"* ]]; do
                clear
                color_echo red "[ERROR] Wrong link"
                color_echo gold "[EXAMPLE] https://www.dropbox.com/s/.../archive_name.7z?dl=0"
                read -p "paste DropBox link [.7z]: " mt_link
            done
            mt_link=${mt_link%?}1
            mt_extention=".7z"
            break
        ;;
        *)
            color_echo red "[ERROR] Wrong answer, exit"
            exit 1
        ;;
    esac
done

# Создание папки с MoonTrader
default_user = $USER
mt_folder="MoonTrader"
while [ -d "$HOME/$mt_folder" ]; do
    color_echo gold "[WARNING] Folder $HOME/$mt_folder already exist"
    read -p 'Enter a new folder name: ' new_foldername
    mt_folder=$new_foldername
done
mkdir "$HOME/$mt_folder"
chown -R $default_user:$default_user "$HOME/$mt_folder"

# Установка необходимых пакетов
clear
color_echo cyan "Installing packages"
sudo apt -yqq update >/dev/null 2>&1
add_pkgs=(fail2ban mc libncurses5 libtommath1 p7zip-full apt-transport-https dotnet-sdk-6.0)
for pkg in "${add_pkgs[@]}"; do
    if ! dpkg -s $pkg >/dev/null 2>&1; then
        color_echo green "Install $pkg"
        case $pkg in
            "fail2ban")
                sudo apt -yqq install $pkg
                sudo touch /etc/fail2ban/jail.local
                sudo bash -c 'sudo echo "[sshd]" >>/etc/fail2ban/jail.local'
                sudo bash -c 'sudo echo "port = ssh" >>/etc/fail2ban/jail.local'
                sudo bash -c 'sudo echo "findtime = 3600" >>/etc/fail2ban/jail.local'
                sudo bash -c 'sudo echo "maxretry = 3" >>/etc/fail2ban/jail.local'
                sudo bash -c 'sudo echo "bantime = 86400" >>/etc/fail2ban/jail.local'
                sudo service fail2ban restart
            ;;
            "libtommath1")
                sudo apt -yqq install $pkg
                if [ -f "/usr/lib/x86_64-linux-gnu/libtommath.so.0" ]; then
                    sudo rm /usr/lib/x86_64-linux-gnu/libtommath.so.0
                fi
                sudo ln -s libtommath.so.1 /usr/lib/x86_64-linux-gnu/libtommath.so.0
            ;;
            "dotnet-sdk-6.0")
                wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
                sudo dpkg -i packages-microsoft-prod.deb
                rm packages-microsoft-prod.deb
                sudo apt-get update >/dev/null 2>&1
                sudo apt -yqq install $pkg
            ;;
            *)
                sudo apt -yqq install $pkg
            ;;
        esac
        color_echo green "complete \n"
    else
        color_echo green "$pkg already installed \n"
    fi
done

# Удаление ненужных пакетов
color_echo cyan "Remove packages"
rm_pkgs=(snapd exim exim4)
for pkg in "${rm_pkgs[@]}"; do
    if dpkg -s $pkg >/dev/null 2>&1; then
        color_echo green "Remove $pkg"
        if [ $pkg == "snapd" ]; then
            sudo apt -yqq remove $pkg --purge
            sudo rm -rf ~/snap
            sudo rm -rf /var/snap
            sudo rm -rf /var/lib/snapd
        else
            sudo apt -yqq remove $pkg
        fi
        color_echo green "complete \n"
    else
        color_echo green "$pkg already removed \n"
    fi
done

# Разрешения проходжение трафика на порт 4242 UDP
color_echo cyan "Firewall permissions"
sudo ufw allow 4242/udp > /dev/null 2>&1
color_echo green "4242/udp allowed \n"

# Включение синхронизации времени
# ToDo - причесать эту часть
color_echo cyan "Enable NTP"
sudo timedatectl set-ntp true
sudo systemctl enable systemd-timesyncd
sudo systemctl restart systemd-timesyncd
color_echo green "Enable NTP complete \n"

# Включение swap если он выключен и RAM меньше 2Gb
color_echo cyan "Enable swap if needed"
if free | awk '/^Swap:/ {exit !$2}'; then
    color_echo green "swap already enabled \n"
else
    if [ $(awk '/^MemTotal:/{print $2}' /proc/meminfo) -lt 2030664 ]; then
        sudo fallocate -l 2G /swapfile
        sudo chmod 600 /swapfile
        sudo mkswap /swapfile
        sudo swapon /swapfile
        sudo bash -c 'echo "/swapfile none swap sw 0 0" >>/etc/fstab'
        color_echo green "RAM < 2GB, swap enabled \n"
    else
        color_echo green "RAM > 1GB, swap not needed \n"
    fi
fi

# Подчищаем установленные не актуальные пакеты
color_echo cyan "Clear packages"
sudo apt -yqq autoremove
color_echo green "complete \n"

# Установка MoonTrader
color_echo cyan "Installing MoonTrader"
if [ $mt_extention == ".tar.xz" ]; then
    wget -O MoonTrader-linux-x86_64.tar.xz $mt_link && tar -xpJf MoonTrader-linux-x86_64.tar.xz -C "$HOME/$mt_folder"
    rm MoonTrader-linux-x86_64.tar.xz
elif [ $mt_extention == ".7z" ]; then
    wget -O MoonTrader-linux-x86_64.7z $mt_link && 7z x -o"$HOME/$mt_folder" MoonTrader-linux-x86_64.7z
    rm MoonTrader-linux-x86_64.7z
fi
if [ -f "$HOME/$mt_folder/MTCore" ]; then
    chmod +x "$HOME/$mt_folder/MTCore"
    sudo rm /usr/bin/MoonTrader
    sudo ln -s "$HOME/$mt_folder/MTCore" /usr/bin/MoonTrader
fi
color_echo green "Installing MoonTrader complete to $HOME/$mt_folder \n"

# Установка обновлений операционной системы
color_echo cyan "Install updates OS, please wait..."
sudo apt update > /dev/null 2>&1
sudo apt -yqq upgrade > /dev/null 2>&1
color_echo green "complete \n"

# Перезагрузка для применения всех изменинй
#color_echo gold "[WARNING] SERVER WILL BE RESTART"
#sudo reboot
