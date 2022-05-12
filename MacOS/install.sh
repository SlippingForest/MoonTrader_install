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
color_echo cyan "Automatic installation of the latest version"
mt_link="https://cdn3.moontrader.com/beta/macosx-x86_64/MoonTrader-macosx-x86_64.tar.xz"
mt_extention=".tar.xz"


# Создание папки с MoonTrader
mt_folder="MoonTrader"
while [ -d "$HOME/Desktop/$mt_folder" ]; do
    color_echo gold "[WARNING] Folder $HOME/Desktop/$mt_folder already exist"
    read -p 'Enter a new folder name: ' new_foldername
    mt_folder=$new_foldername
done
mkdir "$HOME/Desktop/$mt_folder"

# Установка MoonTrader
color_echo cyan "Installing MoonTrader"
if [ $mt_extention == ".tar.xz" ]; then
    curl -o MoonTrader-linux-x86_64.tar.xz $mt_link && tar -xpJf MoonTrader-linux-x86_64.tar.xz -C "$HOME/Desktop/$mt_folder"
    rm MoonTrader-linux-x86_64.tar.xz
fi
if [ -f "$HOME/Desktop/$mt_folder" ]; then
    chmod +x "$HOME/Desktop/$mt_folder/MTCore"
	chmod +x "$HOME/Desktop/$mt_folder/MoonTrader.app/Contents/MacOS/MoonTrader"
	xattr -cr "$HOME/Desktop/$mt_folder/*"
fi
color_echo green "Installing MoonTrader to $HOME/$mt_folder  DONE! \n"
