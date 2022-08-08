#!/bin/bash

# Функция вывода цветной консоли
function color_echo {
    text_red="\e[0;31m"
    text_gold="\e[0;33m"
    text_green="\e[0;32m"
    text_cyan="\e[0;36m"
    text_magenta="\e[0;35m"
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
        "magenta")
            echo -e "${text_magenta}$2${text_dafault}"
        ;;
        "title")
            text_cyan=$(tput setaf 6)
            text_dafault=$(tput sgr0)
            COLUMNS=$(tput cols)
            title=$2
            printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "${text_cyan}$title${text_dafault}"
        ;;
    esac
}

# Проверка операционной системы
# Return
# OS_NAME - operating system name
function check_os(){
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "$ID" = "debian" ]; then
            if [ "$VERSION_ID" = "10" ]; then
                OS_NAME="Debian 10"
                elif [ "$VERSION_ID" = "11" ]; then
                OS_NAME="Debian 11"
            fi
            elif [ "$ID" = "ubuntu" ]; then
            if [ "$VERSION_ID" = "20.04" ]; then
                OS_NAME="Ubuntu 20.04"
                elif [ "$VERSION_ID" = "22.04" ]; then
                OS_NAME="Ubuntu 22.04"
            fi
        else
            color_echo red "This script must be run on Debian or Ubuntu"
            exit 1
        fi
        color_echo title "###  Operation System: $OS_NAME  ###"
        echo -e "\n"
    fi
}

# Проверка на запуск от root
function check_root {
    if [ "$(id -u)" != "0" ]; then
        if [[ $OS_NAME == *"Debian"* ]]; then
            color_echo red "This script must be run as root"
            color_echo gold "Try with: su -"
            exit 1
        fi
        if [[ $OS_NAME == *"Ubuntu"* ]]; then
            color_echo red "This script must be run as root"
            color_echo gold "Try with: sudo su"
            exit 1
        fi
    fi
}

# Выбор пользователя
# Return
# default_user - user
# default_user_directory - home directory of default_user
function choose_user() {
    color_echo title "Select installation user"
    list_usrers=($(awk -F: '($3>=1000)&&($1!="nobody"){print $1}' /etc/passwd | paste -sd " "))
    color_echo magenta "Select the user with which you connected via SSH"
    color_echo magenta "Выберите пользователя с помощью которого подключались по SSH"
    PS3='Enter number of user/Введите номер пользователя: '
    select default_user in "${list_usrers[@]}" "root" "Exit"
    do
        case $default_user in
            "root")
                default_user_directory=$(eval echo ~$USER)
                break
            ;;
            $default_user)
                default_user_directory=$(eval echo ~$default_user)
                break
            ;;
            "Exit")
                exit 1
            ;;
        esac
    done
    color_echo green "Default user: $default_user"
    color_echo green "Default user directory: $default_user_directory"
}


# Выбор способа установки
# Return
# mt_link - installation archive link
# mt_extension - installation archive extension
function choose_install_type(){
    color_echo title "Select installation type"
    install_type_list=(
        "Automatic installation of the latest version"
        "Install your version using the Dropbox link [.tar.xz]"
        "Install your version using the Dropbox link [.7z]"
        "Exit"
    )
    color_echo magenta "Select installation option"
    color_echo magenta "Выберите вариант установки"
    PS3="Enter number option: "
    select install_type in "${install_type_list[@]}"
    do
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
            "Exit")
                color_echo red "Exit script"
                exit 1
            ;;
            *)
                color_echo red "[ERROR] Wrong answer, try again"
            ;;
        esac
    done
    color_echo green "You choose: $install_type"
    color_echo green "Install link: $mt_link"
}

function install_packages(){
    # Установка пакетов
    color_echo title "Install packages"
    apt update > /dev/null 2>&1
    add_pkgs=(
        fail2ban
        chrony
        htop
        mc
        tmux
        iptables-persistent
        psmisc
        libncurses5
        libtommath1
        p7zip-full
        apt-transport-https
        dotnet-sdk-6.0
    )
    for pkg in "${add_pkgs[@]}"; do
        if ! dpkg -s $pkg > /dev/null 2>&1; then
            color_echo green "Install $pkg"
            case $pkg in
                "fail2ban")
                    apt install -y $pkg
                    touch /etc/fail2ban/jail.local
                    service fail2ban restart
                    echo -e "[sshd]\nport = ssh\nfindtime = 3600\nmaxretry = 3\nbantime = 86400" > /etc/fail2ban/jail.local
                ;;
                "libtommath1")
                    apt install -y $pkg
                    if [ -f "/usr/lib/x86_64-linux-gnu/libtommath.so.0" ]; then
                        rm /usr/lib/x86_64-linux-gnu/libtommath.so.0
                    fi
                    ln -s libtommath.so.1 /usr/lib/x86_64-linux-gnu/libtommath.so.0
                ;;
                "dotnet-sdk-6.0")
                    if [ "$OS_NAME" == "Debian 10" ]; then
                        wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
                        elif [ "$OS_NAME" == "Debian 11" ]; then
                        wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
                        elif [ "$OS_NAME" == "Ubuntu 20.04" ]; then
                        wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
                        elif [ "$OS_NAME" == "Ubuntu 22.04" ]; then
                        wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
                    fi
                    dpkg -i packages-microsoft-prod.deb
                    rm packages-microsoft-prod.deb
                    apt update
                    apt install -y dotnet-sdk-6.0
                ;;
                *)
                    DEBIAN_FRONTEND=noninteractive apt install -y $pkg
                ;;
            esac
            color_echo green "complete \n"
        else
            color_echo green "$pkg already installed"
        fi
    done
}

function remove_packages(){
    # Удаление ненужных пакетов
    color_echo title "Remove packages"
    rm_pkgs=(snapd exim exim4)
    for pkg in "${rm_pkgs[@]}"; do
        if dpkg -s $pkg > /dev/null 2>&1; then
            color_echo green "Remove $pkg"
            if [ $pkg == "snapd" ]; then
                apt -yqq remove $pkg --purge
                rm -rf ~/snap
                rm -rf /var/snap
                rm -rf /var/lib/snapd
            else
                apt -yqq remove $pkg
            fi
            color_echo green "complete \n"
        else
            color_echo green "$pkg already removed"
        fi
    done
}

function update_packages(){
    # Обновление пакетов
    color_echo title "Update packages"
    apt update > /dev/null 2>&1
    DEBIAN_FRONTEND=noninteractive apt upgrade -y
    color_echo green "Updating packages complete"
}

function create_mt_folder(){
    # Создание папки с MoonTrader
    color_echo title "Create MoonTrader folder"
    mt_folder="MoonTrader"
    while [ -d "$default_user_directory/$mt_folder" ]; do
        color_echo gold "[WARNING] Folder $default_user_directory/$mt_folder already exist"
        read -p 'Enter a new folder name: ' new_foldername
        mt_folder=$new_foldername
    done
    mkdir "$default_user_directory/$mt_folder"
    color_echo green "MoonTrader installation folder $default_user_directory/$mt_folder created"
}

function enable_swap(){
    # Включение swap если он выключен и RAM меньше 2Gb
    color_echo title "Enable swap"
    if free | awk '/^Swap:/ {exit !$2}'; then
        color_echo green "swap already enabled \n"
    else
        if [ $(awk '/^MemTotal:/{print $2}' /proc/meminfo) -lt 2030664 ]; then
            sudo fallocate -l 2G /swapfile
            sudo chmod 600 /swapfile
            sudo mkswap /swapfile
            sudo swapon /swapfile
            sudo bash -c 'echo "/swapfile none swap sw 0 0" >>/etc/fstab'
            color_echo green "RAM < 2GB, swap enabled"
        else
            color_echo green "RAM > 1GB, swap not needed"
        fi
    fi
}

# Включение и настройка firewall
function setup_firewall(){
    color_echo title "Enable firewall"
    if ! iptables -nL | grep 4242; then
        iptables -F
        iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
        iptables -A INPUT -m state --state INVALID -j DROP
        iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
        iptables -A INPUT -p udp --dport 4242 -j ACCEPT
        iptables -A INPUT -p tcp --dport ssh -j ACCEPT
        iptables -A INPUT -i lo -j ACCEPT
        iptables -A INPUT -j DROP
        netfilter-persistent save
        color_echo green "Firewall allow tcp22, udp4242. Drop all other connections"
    else
        color_echo green "Security already enabled"
    fi
    
}

function install_mt(){
    # Установка MoonTrader
    color_echo title "Installing MoonTrader"
    if [ $mt_extention == ".tar.xz" ]; then
        wget -O MoonTrader-linux-x86_64.tar.xz $mt_link && tar -xpJf MoonTrader-linux-x86_64.tar.xz -C "$default_user_directory/$mt_folder"
        rm MoonTrader-linux-x86_64.tar.xz
        elif [ $mt_extention == ".7z" ]; then
        wget -O MoonTrader-linux-x86_64.7z $mt_link && 7z x "-o${default_user_directory}/${mt_folder}" MoonTrader-linux-x86_64.7z
        rm MoonTrader-linux-x86_64.7z
    fi
    
    # Создание файла запуска MTCore для корректного обновления MoonTrader при запуске из usr/bin
    if [ -f "$default_user_directory/$mt_folder/MTCore" ] && [ ! -f "$default_user_directory/$mt_folder/start_mt.sh" ]; then
        chmod +x "$default_user_directory/$mt_folder/MTCore"
        touch $default_user_directory/$mt_folder/start_mt.sh && chmod +x $default_user_directory/$mt_folder/start_mt.sh
        # ToDo сделать запись строк в файл как-то по красивее...
        echo -e "if [ -n \"\$1\" ]; then" > $default_user_directory/$mt_folder/start_mt.sh
        echo -e "    if [ \"\$1\" == \"--no-update\" ]; then" >> $default_user_directory/$mt_folder/start_mt.sh
        echo -e "        cd $default_user_directory/$mt_folder" >> $default_user_directory/$mt_folder/start_mt.sh
        echo -e "        ./MTCore --no-update" >> $default_user_directory/$mt_folder/start_mt.sh
        echo -e "    else" >> $default_user_directory/$mt_folder/start_mt.sh
        echo -e "        cd $default_user_directory/$mt_folder" >> $default_user_directory/$mt_folder/start_mt.sh
        echo -e "        $default_user_directory/$mt_folder/MTCore" >> $default_user_directory/$mt_folder/start_mt.sh
        echo -e "    fi" >> $default_user_directory/$mt_folder/start_mt.sh
        echo -e "else" >> $default_user_directory/$mt_folder/start_mt.sh
        echo -e "    cd $default_user_directory/$mt_folder" >> $default_user_directory/$mt_folder/start_mt.sh
        echo -e "    $default_user_directory/$mt_folder/MTCore" >> $default_user_directory/$mt_folder/start_mt.sh
        echo -e "fi" >> $default_user_directory/$mt_folder/start_mt.sh
        
        rm /usr/bin/MoonTrader > /dev/null 2>&1
        ln -s "$default_user_directory/$mt_folder/start_mt.sh" /usr/bin/MoonTrader
    fi
    chown -R $default_user:$default_user "$default_user_directory/$mt_folder"
    color_echo green "MoonTrader installed"
}

# main

clear
check_os
check_root
choose_user
choose_install_type
create_mt_folder
remove_packages
install_packages
update_packages
enable_swap
setup_firewall
install_mt

color_echo title "### Install complete ###"
# Перезагрузка для применения всех изменинй
color_echo gold "[WARNING] SERVER WILL BE RESTART"
systemctl reboot