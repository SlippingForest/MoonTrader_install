#!/bin/bash

declare -A hints=(
  ["h_selected_language"]='{"en":"The installation will continue in English","ua":"Встановлення буде продовжене українською мовою","ru":"Установка будет продолжена на русском языке","es":"La instalación continuará en inglés"}'

  ["h_check_os_valid"]='{"en":"Current operating system","ua":"Поточна операційна система","ru":"Текущая операционная система","es":"Sistema operativo actual"}'
  ["h_check_os_wrong"]='{"en":"This script only supports Debian10+ and Ubuntu20+ operating systems","ua":"Цей скрипт підтримує тільки операційні системи Debian10+ і Ubuntu20+","ru":"Этот скрипт поддерживает только операционные системы Debian10+ и Ubuntu20+","es":"Este script solo es compatible con los sistemas operativos Debian10+ y Ubuntu20+"}'

  ["h_check_arch_wrong"]='{"en":"This script only supports AMD64 and ARM architectures","ua":"Цей скрипт підтримує тільки архітектури AMD64 і ARM","ru":"Этот скрипт поддерживает только архитектуры AMD64 и ARM","es":"Este script solo es compatible con las arquitecturas AMD64 y ARM"}'
  ["h_check_arch_valid"]='{"en":"Current architecture","ua":"Поточна архітектура","ru":"Текущая архитектура","es":"Arquitectura actual"}'

  ["h_check_root_wrong"]='{"en":"This script must be run as root","ua":"Цей скрипт має бути виконаний від імені користувача root","ru":"Этот скрипт должен выполнятся от пользователя root","es":"Este script debe ejecutarse como root"}'

  ["h_exit_error"]='{"en":"Script stopped.","ua":"Скрипт зупинено.","ru":"Скрипт остановлен.","es":"Script detenido."}'
  ["h_exit_normal"]='{"en":"Script stopped.","ua":"Скрипт зупинено.","ru":"Скрипт остановлен.","es":"Script detenido."}'

  ["h_msg_warning"]='{"en":"Warning","ua":"Попередження","ru":"Предупреждение","es":"Advertencia"}'
  ["h_msg_error"]='{"en":"Error","ua":"Помилка","ru":"Ошибка","es":"Error"}'
  ["h_msg_example"]='{"en":"Example","ua":"Приклад","ru":"Пример","es":"Ejemplo"}'

  ["h_select_user_name"]='{"en":"User found","ua":"Користувача знайдено","ru":"Найден пользователь","es":"Usuario encontrado"}'
  ["h_select_user_directory"]='{"en":"User home directory","ua":"Домашня директорія користувача","ru":"Стандартный каталог пользователя","es":"Directorio principal del usuario"}'

  ["h_select_question_number"]='{"en":"Enter number","ua":"Введіть номер","ru":"Введите номер","es":"Ingrese número"}'
  ["h_select_question_wrong"]='{"en":"Wrong answer, please try again","ua":"Невірна відповідь, спробуйте ще раз","ru":"Неверный ответ, попробуйте еще раз","es":"Respuesta incorrecta, por favor intente de nuevo"}'

  ["h_select_installation_title"]='{"en":"Choose an installation option","ua":"Оберіть варіант встановлення","ru":"Выберите вариант установки","es":"Elija una opción de instalación"}'
  ["h_select_installation_auto"]='{"en":"Automatic installation of the latest version","ua":"Автоматичне встановлення останньої версії","ru":"Автоматическая установка самой последней версии","es":"Instalación automática de la última versión"}'
  ["h_select_installation_dropbox"]='{"en":"Installation using a link to the archive [.tar.xz] located on https://www.dropbox.com/","ua":"Встановлення за допомогою посилання на архів [.tar.xz], розташований на https://www.dropbox.com/","ru":"Установка используя ссылку на архив [.tar.xz] расположенного на https://www.dropbox.com/","es":"Instalación utilizando un enlace al archivo [.tar.xz] ubicado en https://www.dropbox.com/"}'
  ["h_select_installation_exit"]='{"en":"Cancel installation","ua":"Скасувати встановлення","ru":"Отменить установку","es":"Cancelar instalación"}'
  ["h_select_installation_dropbox_link"]='{"en":"Insert link","ua":"Вставте посилання","ru":"Вставьте ссылку","es":"Insertar enlace"}'
  ["h_select_installation_dropbox_link_wrong"]='{"en":"Invalid link, please try again","ua":"Невірне посилання, спробуйте ще раз","ru":"Неправильная ссылка, попробуйте еще раз","es":"Enlace no válido, por favor inténtelo de nuevo"}'

  ["h_select_installation_type"]='{"en":"Selected installation type","ua":"Вибраний тип встановлення","ru":"Выбранный тип установки","es":"Tipo de instalación seleccionado"}'
  ["h_select_installation_link"]='{"en":"Link to installation archive","ua":"Посилання на інсталяційний архів","ru":"Ссылка на установочный архив","es":"Enlace al archivo de instalación"}'

  ["h_install_packages_title"]='{"en":"Installing necessary packages and dependencies","ua":"Встановлення необхідних пакетів та залежностей","ru":"Установка необходимых пакетов и зависимостей","es":"Instalando paquetes y dependencias necesarios"}'
  ["h_install_packages_start"]='{"en":"Installation","ua":"Встановлення","ru":"Установка","es":"Instalación"}'
  ["h_install_packages_comlpete"]='{"en":"Installation successful","ua":"Встановлення успішне","ru":"Установка успешна","es":"Instalación exitosa"}'
  ["h_install_packages_already"]='{"en":"Already installed","ua":"Вже встановлено","ru":"Уже установлено","es":"Ya instalado"}'

  ["h_create_mt_folder_title"]='{"en":"Creating a directory for installing MoonTrader","ua":"Створення каталогу для встановлення MoonTrader","ru":"Создание каталога для установки MoonTrader","es":"Creando un directorio para instalar MoonTrader"}'
  ["h_create_mt_folder_already_exist"]='{"en":"Directory for installing MoonTrader already exists","ua":"Каталог для встановлення MoonTrader вже існує","ru":"Каталог для установки MoonTrader уже существует","es":"El directorio para instalar MoonTrader ya existe"}'
  ["h_create_mt_folder_new"]='{"en":"Enter a new name for the directory","ua":"Введіть нову назву для каталогу","ru":"Введите новое имя для каталога","es":"Ingrese un nuevo nombre para el directorio"}'
  ["h_create_mt_folder_install"]='{"en":"MoonTrader installation directory","ua":"Каталог встановлення MoonTrader","ru":"Установочный каталог MoonTrader","es":"Directorio de instalación de MoonTrader"}'

  ["h_remove_packages_title"]='{"en":"Removing unnecessary packages and dependencies","ua":"Видалення непотрібних пакетів та залежностей","ru":"Удаление ненужных пакетов и зависимостей","es":"Eliminando paquetes y dependencias innecesarios"}'
  ["h_remove_packages_start"]='{"en":"Removing","ua":"Видалення","ru":"Удаление","es":"Eliminando"}'
  ["h_remove_packages_complete"]='{"en":"Successfully removed","ua":"Успішно видалено","ru":"Успешно удалено","es":"Eliminado exitosamente"}'
  ["h_remove_packages_already"]='{"en":"Already removed","ua":"Вже видалено","ru":"Уже удалено","es":"Ya ha sido eliminado"}'

  ["h_update_packages_title"]='{"en":"Updating packages and dependencies","ua":"Оновлення пакетів та залежностей","ru":"Обновление пакетов и зависимостей","es":"Actualizando paquetes y dependencias"}'
  ["h_update_packages_complete"]='{"en":"Packages and dependencies update completed","ua":"Оновлення пакетів та залежностей завершено","ru":"Обновление пакетов и зависимостей завершено","es":"Actualización de paquetes y dependencias completada"}'

  ["h_setup_firewall_setup"]='{"en""The firewall is configured, allowed","ua""Брандмауер налаштован, дозволено","ru""Брандмауэр настроен, разрешено","es""El firewall está configurado, permitido"}'
  ["h_setup_firewall_enabled"]='{"en""Firewall is already configured, allowed","ua""Брандмауер вже налаштовано, дозволено","ru""Брандмауэр уже настроен, разрешено","es""El firewall ya está configurado, permitido"}'

  ["h_install_mt_title"]='{"en":"Installing MoonTrader trading terminal core","ua":"Встановлення ядра торгового терміналу MoonTrader","ru":"Установка ядра торгового терминала MoonTrader","es":"Instalando núcleo del terminal de trading de MoonTrader"}'
  ["h_install_mt_download"]='{"en":"Installation archive downloaded and unpacked successfully","ua":"Установочний архів завантажено та розпаковано успішно","ru":"Скачивание и распаковка установочного архива успешно завершено","es":"Archivo de instalación descargado y descomprimido con éxito"}'
  ["h_install_mt_complete"]='{"en":"Creation of startup script and quick launch link completed","ua":"Створення скрипту запуску та посилання для швидкого запуску завершено","ru":"Создание скрипта запуска и ссылки для быстрого запуска завершены","es":"Creación del script de inicio y del enlace de inicio rápido completados"}'

  ["h_complete_install_title"]='{"en":"All installation operations completed successfully","ua":"Всі операції встановлення успішно завершені","ru":"Все операции установки успешно завершены","es":"Todas las operaciones de instalación se han completado correctamente"}'
  ["h_complete_install_waring"]='{"en":"Make sure to use tmux to run the MoonTrader trading terminal in the background, otherwise, after disconnecting from SSH, the kernel will also be forcibly closed.","ua":"Переконайтеся, що використовуєте tmux для запуску торгового терміналу MoonTrader в фоновому режимі, інакше після відключення від SSH ядро також буде примусово закрито.","ru":"Обязательно используйте tmux для запуска торгового терминала MoonTrader в фоне, иначе после отключения от SSH ядро так же будет принудительно закрыто.","es":"Asegúrate de utilizar tmux para ejecutar el terminal de trading de MoonTrader en segundo plano, de lo contrario, después de desconectarte de SSH, el kernel también se cerrará forzosamente."}'

  ["h_complete_install_info"]='{"en":"Full installation information","ua":"Повна інформація про встановлення","ru":"Полная информация об установке","es":"Información completa de instalación"}'
  ["h_complete_install_os"]='{"en":"Operating system","ua":"Операційна система","ru":"Операционная система","es":"Sistema operativo"}'
  ["h_complete_install_user"]='{"en":"User for whom the installation was performed","ua":"Користувач, для якого проведено встановлення","ru":"Пользователь, для которого произведена установка","es":"Usuario para quien se realizó la instalación"}'
  ["h_complete_install_dir"]='{"en":"MoonTrader is installed in the directory","ua":"MoonTrader встановлено в каталог","ru":"MoonTrader установлен в каталог","es":"MoonTrader se ha instalado en el directorio"}'
  ["h_complete_install_fail2ban"]='{"en":"Protection against password guessing has been set up based on Fail2Ban","ua":"Налаштован захист від перебору паролів на основі Fail2Ban","ru":"Настроена защита от перебора паролей на основе Fail2Ban","es":"Se ha configurado la protección contra adivinanza de contraseñas basada en Fail2Ban"}'
  ["h_complete_install_start"]='{"en":"Command to start","ua":"Команда для запуску","ru":"Команда для запуска","es":"Comando para iniciar"}'
  ["h_complete_install_reboot"]='{"en":"Press any key to apply all settings, the server will be restarted.","ua":"Для застосування всіх налаштувань натисніть будь-яку клавішу, сервер буде перезавантажено.","ru":"Для применения всех настроек нажмите любую клавишу, сервер будет перезагружен.","es":"Presione cualquier tecla para aplicar todas las configuraciones, el servidor se reiniciará."}'
  ["h_complete_install_firewall"]='{"en":"Firewall enabled, allowed","ua":"Брандмауер увімкнено, дозволено","ru":"Брандмауэр включен, разрешено","es":"Firewall habilitado, permitido"}'
)

# Функция для отображения подсказки для переменной на указанном языке
function display_hint() {
  local var_name="$1"

  # Получить подсказку для переменной на указанном языке
  local hint=$(echo "${hints[$var_name]}" | awk -F'"' -v l="$lang" '{for(i=2;i<=NF;i+=4)if($i==l)print $(i+2)}')

  # Распечатать подсказку, если она не пуста
  if [ -n "$hint" ]; then
    echo "$hint"
  else
    echo "Hint not found for variable $var_name in language $lang"
  fi
}

# Функция для установки языковой переменной на основе пользовательского ввода
# Return
# lang - script language
function select_language() {
  # echo "Script language selection|Выбор языка скрипта|Вибір мови скрипту"
  color_echo select "Select language | Выберите язык | Виберіть мову | Elige lengua"
  language_list=(
    "English"
    "Русский"
    "Українська"
    "Español"
    "Exit/Выход/Вихід"
  )

  PS3="Enter the number | Введите номер | Введіть номер | Introduce el número: "

  select install_type in "${language_list[@]}"; do
    case $install_type in
    "English")
      lang="en"
      break
      ;;
    "Русский")
      lang="ru"
      break
      ;;
    "Українська")
      lang="ua"
      break
      ;;
    "Español")
      lang="es"
      break
      ;;
    "Exit/Выход/Вихід")
      echo "Exit"
      exit 1
      ;;
    *)
      echo "Warning: Wrong answer, please try again"
      ;;
    esac
  done
  clear
  color_echo title "$(display_hint "h_selected_language" $lang)"
  # echo "$(display_hint "h_selected_language" "$lang")"
}

# Функция вывода цветной консоли
# ToDo: сделать возможность отображения отдельных слов, вывод ошибкок и прочего
function color_echo {
  text_red="\e[0;31m"
  text_yellow="\e[0;33m"
  text_green="\e[92m"
  text_light_green="\e[1;32m"
  text_cyan="\e[0;36m"
  text_magenta="\e[95m"
  text_dafault="\e[0m"
  text_lightblue="\e[1;34m"
  text_blue="\e[34m"
  text_lightcyan="\e[1;36m"

  case $1 in
  "error")
    echo -e "\n${text_red}$(display_hint "h_msg_error"): $2${text_dafault}"
    ;;
  "warning")
    echo -e "\n${text_yellow}$(display_hint "h_msg_warning"): $2${text_dafault}"
    ;;
  "info")
    echo -e "${text_green}✔ $2${text_dafault}"
    ;;
  "example")
    echo -e "${text_blue}$(display_hint "h_msg_example"): $2${text_dafault}"
    ;;
  "cyan")
    echo -e "${text_cyan}$2${text_dafault}"
    ;;
  "select")
    echo -e "\n${text_magenta}$2${text_dafault}"
    ;;
  "title")
    text_cyan=$(tput setaf 6)
    text_dafault=$(tput sgr0)
    COLUMNS=$(tput cols)
    title=$2
    # printf "%*s\n" $(((${#title} + $COLUMNS) / 2)) "${text_cyan}$title${text_dafault}"
    echo -e "\n${text_magenta}# ${text_cyan}$title${text_dafault}"
    ;;
  esac
}

# Функция проверки операционной системы
# Return
# OS_NAME - operating system name
function check_os() {
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
      color_echo error "$(display_hint "h_check_os_wrong")"
      exit 1
    fi
    color_echo title "$(display_hint "h_check_os_valid"): $OS_NAME"
  fi
}

function check_arch() {
  if [ "$(uname -m)" == "x86_64" ]; then
    CPU_ARCH="AMD64"
  elif [ "$(uname -m)" == "aarch64" ]; then
    CPU_ARCH="ARM"
  else
    color_echo error "$(display_hint "h_check_arch_wrong")"
    exit 1
  fi

  color_echo title "$(display_hint "h_check_arch_valid"): $CPU_ARCH"
}

# Функция проверки на запуск от root
function check_root {
  if [ "$(id -u)" != "0" ]; then
    if [[ $OS_NAME == *"Debian"* ]]; then
      color_echo error "$(display_hint "h_check_root_wrong")"
      # color_echo cyan "su -"
      color_echo info "$(display_hint "h_exit_error")"
      exit 1
    fi
    if [[ $OS_NAME == *"Ubuntu"* ]]; then
      color_echo error "$(display_hint "h_check_root_wrong")"
      # color_echo cyan "sudo su"
      color_echo info "$(display_hint "h_exit_error")"
      exit 1
    fi
  fi
}

# Функция выбора пользователя
# Return
# default_user - user
# default_user_directory - home directory of default_user
function select_user() {
  last_login_user=$(last pts/0 -1 | awk '{print $1; exit}')
  list_usrers=($(awk -F: '($3>=1000)&&($1!="nobody"){print $1}' /etc/passwd | paste -sd " "))
  for list_user in "${list_usrers[@]}" "root"; do
    if [[ "$list_user" == *"$last_login_user"* ]]; then
      default_user=$list_user
      break
    fi
  done
  default_user_directory=$(eval echo ~$default_user)
  color_echo title "$(display_hint "h_select_user_name"): $default_user"
  color_echo title "$(display_hint "h_select_user_directory"): $default_user_directory"
}

# Функция выбора типа установки
# Return
# install_type - тип установки
# mt_link - ссылка на скачивание MoonTrader
function select_installation() {
  color_echo select "$(display_hint "h_select_installation_title")"
  install_type_list=(
    "$(display_hint "h_select_installation_auto")"
    "$(display_hint "h_select_installation_dropbox")"
    "$(display_hint "h_select_installation_exit")"
  )
  PS3="$(display_hint "h_select_question_number"): "
  select install_type in "${install_type_list[@]}"; do
    case $install_type in
    "$(display_hint "h_select_installation_auto")")
      if [ $CPU_ARCH == "AMD64" ]; then
        mt_link="https://cdn3.moontrader.com/beta/linux-x86_64/MoonTrader-linux-x86_64.tar.xz"
      elif [ $CPU_ARCH == "ARM" ]; then
        mt_link="https://cdn3.moontrader.com/beta/linux-arm64/MoonTrader-linux-arm64.tar.xz"
      fi

      mt_extention=".tar.xz"
      break
      ;;
    "$(display_hint "h_select_installation_dropbox")")
      color_echo example "https://www.dropbox.com/s/.../archive_name.tar.xz?dl=0"
      read -p "$(display_hint "h_select_installation_dropbox_link"): " mt_link
      while ! [[ $mt_link == *".tar.xz"* ]]; do
        # clear
        color_echo warning "$(display_hint "h_select_installation_dropbox_link_wrong")"
        color_echo example "https://www.dropbox.com/s/.../...tar.xz?dl=0"
        read -p "$(display_hint "h_select_installation_dropbox_link"): " mt_link
      done
      mt_link=${mt_link%?}1
      mt_extention=".tar.xz"
      break
      ;;
    "$(display_hint "h_select_installation_exit")")
      color_echo info "$(display_hint "h_exit_error")"
      exit 1
      ;;
    *)
      color_echo warning "$(display_hint "h_select_question_wrong")"
      ;;
    esac
  done
  color_echo title "$(display_hint "h_select_installation_type"): $install_type"
  color_echo title "$(display_hint "h_select_installation_link"): $mt_link"
}

# Функция установки пакетов и зависимостей
function install_packages() {
  color_echo title "$(display_hint "h_install_packages_title")"

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
  apt update >/dev/null 2>&1

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
    dotnet-sdk-7.0
  )

  for pkg in "${add_pkgs[@]}"; do
    if ! dpkg -s $pkg >/dev/null 2>&1; then
      color_echo info "$(display_hint "h_install_packages_start"): $pkg"
      case $pkg in
      "fail2ban")
        apt install -y $pkg
        touch /etc/fail2ban/jail.local
        echo -e "[sshd]\nport = ssh\nfindtime = 3600\nmaxretry = 3\nbantime = 86400" >/etc/fail2ban/jail.local
        systemctl restart fail2ban
        ;;
      "libtommath1")
        apt install -y $pkg
        if [ -f "/usr/lib/x86_64-linux-gnu/libtommath.so.0" ]; then
          rm /usr/lib/x86_64-linux-gnu/libtommath.so.0
        fi
        ln -s libtommath.so.1 /usr/lib/x86_64-linux-gnu/libtommath.so.0
        ;;
      *)
        DEBIAN_FRONTEND=noninteractive apt install -y $pkg
        ;;
      esac
      color_echo info "$(display_hint "h_install_packages_comlpete"): $pkg"
    else
      color_echo info "$(display_hint "h_install_packages_already"): $pkg"
    fi
  done
}

# Функция удаления ненужных пакетов и зависимостей
function remove_packages() {
  color_echo title "$(display_hint "h_remove_packages_title")"
  rm_pkgs=(snapd exim exim4)
  for pkg in "${rm_pkgs[@]}"; do
    if dpkg -s $pkg >/dev/null 2>&1; then
      color_echo info "$(display_hint "h_remove_packages_start"): $pkg"
      if [ $pkg == "snapd" ]; then
        apt -yqq remove $pkg --purge
        rm -rf ~/snap
        rm -rf /var/snap
        rm -rf /var/lib/snapd
      else
        apt -yqq remove $pkg
      fi
      color_echo info "$(display_hint "h_remove_packages_complete"): $pkg"
    else
      color_echo info "$(display_hint "h_remove_packages_already"): $pkg"
    fi
  done
}

# Функция обновления пакетов и зависимостей
function update_packages() {
  color_echo title "$(display_hint "h_update_packages_title")"
  apt update >/dev/null 2>&1
  DEBIAN_FRONTEND=noninteractive apt upgrade -y
  color_echo info "$(display_hint "h_update_packages_complete")"
}

# Функция создания папки с MoonTrader
function create_mt_folder() {
  mt_folder="MoonTrader"
  if [ -d "$default_user_directory/$mt_folder" ]; then
    rm -rf "$default_user_directory/$mt_folder"
  fi
  mkdir "$default_user_directory/$mt_folder"
  color_echo title "$(display_hint "h_create_mt_folder_install"): $default_user_directory/$mt_folder"
}

# Функция включения swap, если не включен
function enable_swap() {
  if ! free | awk '/^Swap:/ {exit !$2}'; then
    fallocate -l 2G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    bash -c 'echo "/swapfile none swap sw 0 0" >>/etc/fstab'
  fi
}

# Функция настройки конфигурации chrony(время)
function setup_time() {
  echo -e "server 0.pool.ntp.org iburst" >/etc/chrony/chrony.conf
  echo -e "server 1.pool.ntp.org iburst" >>/etc/chrony/chrony.conf
  echo -e "server 2.pool.ntp.org iburst" >>/etc/chrony/chrony.conf
  echo -e "server 3.pool.ntp.org iburst" >>/etc/chrony/chrony.conf
  echo -e "minsources 4" >>/etc/chrony/chrony.conf
  echo -e "maxchange 100 0 0" >>/etc/chrony/chrony.conf
  echo -e "makestep 0.001 1" >>/etc/chrony/chrony.conf
  echo -e "maxdrift 100" >>/etc/chrony/chrony.conf
  echo -e "maxslewrate 100" >>/etc/chrony/chrony.conf
  echo -e "driftfile /var/lib/chrony/drift" >>/etc/chrony/chrony.conf
  echo -e "rtcsync" >>/etc/chrony/chrony.conf
  systemctl restart chronyd
}

# Функция включения и настройка firewall
function setup_firewall() {
  if ! iptables -nL | grep 4242 >/dev/null 2>&1; then
    color_echo title "$(display_hint "h_setup_firewall_title")"
    iptables -F
    iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables -A INPUT -m state --state INVALID -j DROP
    iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
    iptables -A INPUT -p udp --dport 4242 -j ACCEPT
    iptables -A INPUT -p tcp --dport ssh -j ACCEPT
    iptables -A INPUT -i lo -j ACCEPT
    iptables -A INPUT -j DROP
    netfilter-persistent save
    color_echo title "$(display_hint "h_setup_firewall_setup"): Ping,SSH,4242udp"
  else
    color_echo title "$(display_hint "h_setup_firewall_enabled"): Ping,SSH,4242udp"
  fi
}

# Функция установки MoonTrader
function install_mt() {
  color_echo title "$(display_hint "h_install_mt_title")"

  if [ $mt_extention == ".tar.xz" ]; then
    wget -O MoonTrader-linux-x86_64.tar.xz $mt_link && tar -xpJf MoonTrader-linux-x86_64.tar.xz -C "$default_user_directory/$mt_folder"
    rm MoonTrader-linux-x86_64.tar.xz
  elif [ $mt_extention == ".7z" ]; then
    wget -O MoonTrader-linux-x86_64.7z $mt_link && 7z x "-o${default_user_directory}/${mt_folder}" MoonTrader-linux-x86_64.7z
    rm MoonTrader-linux-x86_64.7z
  fi
  color_echo info "$(display_hint "h_install_mt_download")"

  # Создание файла запуска MTCore для корректного обновления MoonTrader при запуске из usr/bin
  if [ -f "$default_user_directory/$mt_folder/MTCore" ] && [ ! -f "$default_user_directory/$mt_folder/start_mt.sh" ]; then
    chmod +x "$default_user_directory/$mt_folder/MTCore"
    touch $default_user_directory/$mt_folder/start_mt.sh && chmod +x $default_user_directory/$mt_folder/start_mt.sh
    # ToDo сделать запись строк в файл как-то красивее...
    echo -e "if [ -n \"\$1\" ]; then" >$default_user_directory/$mt_folder/start_mt.sh
    echo -e "    if [ \"\$1\" == \"--no-update\" ]; then" >>$default_user_directory/$mt_folder/start_mt.sh
    echo -e "        cd $default_user_directory/$mt_folder" >>$default_user_directory/$mt_folder/start_mt.sh
    echo -e "        ./MTCore --no-update" >>$default_user_directory/$mt_folder/start_mt.sh
    echo -e "    else" >>$default_user_directory/$mt_folder/start_mt.sh
    echo -e "        cd $default_user_directory/$mt_folder" >>$default_user_directory/$mt_folder/start_mt.sh
    echo -e "        $default_user_directory/$mt_folder/MTCore" >>$default_user_directory/$mt_folder/start_mt.sh
    echo -e "    fi" >>$default_user_directory/$mt_folder/start_mt.sh
    echo -e "else" >>$default_user_directory/$mt_folder/start_mt.sh
    echo -e "    cd $default_user_directory/$mt_folder" >>$default_user_directory/$mt_folder/start_mt.sh
    echo -e "    $default_user_directory/$mt_folder/MTCore" >>$default_user_directory/$mt_folder/start_mt.sh
    echo -e "fi" >>$default_user_directory/$mt_folder/start_mt.sh

    rm /usr/bin/MoonTrader >/dev/null 2>&1
    ln -s "$default_user_directory/$mt_folder/start_mt.sh" /usr/bin/MoonTrader
  fi
  chown -R $default_user:$default_user "$default_user_directory/$mt_folder"
  color_echo info "$(display_hint "h_install_mt_complete")"
}

main
clear
select_language
check_os
check_arch
check_root
select_user
select_installation
create_mt_folder
remove_packages
install_packages
update_packages
enable_swap
setup_time
setup_firewall
install_mt

clear
color_echo title "$(display_hint "h_complete_install_title")"
color_echo info "$(display_hint "h_complete_install_os"): $OS_NAME"
color_echo info "$(display_hint "h_complete_install_user"): $default_user"
color_echo info "$(display_hint "h_complete_install_dir"): $default_user_directory/$mt_folder"
color_echo info "$(display_hint "h_complete_install_firewall"): Ping,SSH,4242udp"
color_echo info "$(display_hint "h_complete_install_fail2ban")"
color_echo warning "$(display_hint "h_complete_install_waring")"
color_echo info "$(display_hint "h_complete_install_start"): MoonTrader"
color_echo warning "$(display_hint "h_complete_install_reboot")"
read -n 1
reboot
