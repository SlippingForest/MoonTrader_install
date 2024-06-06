#!/bin/bash

declare -A tips=(
    ["h_check_os_valid"]='{"en":"Current operating system","ua":"Поточна операційна система","ru":"Текущая операционная система","es":"Sistema operativo actual"}'
    ["h_check_os_wrong"]='{"en":"This script only supports Debian10+ and Ubuntu20+ operating systems","ua":"Цей скрипт підтримує тільки операційні системи Debian10+ і Ubuntu20+","ru":"Этот скрипт поддерживает только операционные системы Debian10+ и Ubuntu20+","es":"Este script solo es compatible con los sistemas operativos Debian10+ y Ubuntu20+"}'
    ["h_check_arch_wrong"]='{"en":"This script only supports AMD64 and ARM architectures","ua":"Цей скрипт підтримує тільки архітектури AMD64 і ARM","ru":"Этот скрипт поддерживает только архитектуры AMD64 и ARM","es":"Este script solo es compatible con las arquitecturas AMD64 y ARM"}'
    ["h_check_arch_valid"]='{"en":"Current architecture","ua":"Поточна архітектура","ru":"Текущая архитектура","es":"Arquitectura actual"}'
    
    ["h_check_root_wrong"]='{"en":"This script must be run as root","ua":"Цей скрипт має бути виконаний від імені користувача root","ru":"Этот скрипт должен выполнятся от пользователя root","es":"Este script debe ejecutarse como root"}'
    
    ["h_exit"]='{"en":"Installation caneled.","ua":"Встановлення скасовано.","ru":"Установка отменена.","es":"Instalación cancelada."}'
    
    # log messages
    ["h_msg_info"]='{"en":"Info","ua":"Інформація","ru":"Информация","es":"Info"}'
    ["h_msg_warning"]='{"en":"Warning","ua":"Попередження","ru":"Предупреждение","es":"Advertencia"}'
    ["h_msg_error"]='{"en":"Script stopped with an Error","ua":"Скрипт зупинено з Помилкою","ru":"Скрипт остановлен с Ошибкой","es":"Script detenido con un Error"}'
    
    ["h_msg_start"]='{"en":"Start","ua":"Запуск","ru":"Запуск","es":"Inicio"}'
    ["h_msg_success"]='{"en":"Success","ua":"Успіх","ru":"Успех","es":"Éxito"}'
    
    ["h_msg_example"]='{"en":"Example","ua":"Приклад","ru":"Пример","es":"Ejemplo"}'
    ["h_msg_hint"]='{"en":"Hint","ua":"Підказка","ru":"Подсказка","es":"Sugerencia"}'
    ["h_msg_select"]='{"en":"Select","ua":"Вибір","ru":"Выбор","es":"Seleccionar"}'
    
    # setup messages
    ["h_setup_install_text"]='{"en":"Select installation option","ua":"Оберіть варіант встановлення","ru":"Выберите вариант установки","es":"Seleccione una opción de instalación"}'
    ["h_setup_tips"]='{"en":"Use numbers to toggle, Enter to confirm, Q to exit.","ua":"Використовуйте цифри для перемикання, Enter для підтвердження, Q для виходу.","ru":"Используйте цифры для переключения, Enter для подтверждения, Q для выхода.","es":"Use números para alternar, Enter para confirmar, Q para salir."}'
    ["h_custom_setup_request"]='{"en": "Custom installation setup:","ua": "Налаштування користувацького встановлення:","ru": "Настройка пользовательской установки:","es": "Configuración de instalación personalizada:"}'
    
    # select messages
    ["h_select_installation_title"]='{"en":"Choose an installation option","ua":"Оберіть варіант встановлення","ru":"Выберите вариант установки","es":"Elija una opción de instalación"}'
    ["h_select_installation_dropbox"]='{"en":"Installation using https://www.dropbox.com/","ua":"Встановлення за допомогою https://www.dropbox.com/","ru":"Установка с использованием https://www.dropbox.com/","es":"Instalación usando https://www.dropbox.com/"}'
    ["h_select_installation_dropbox_link"]='{"en":"Insert link","ua":"Вставте посилання","ru":"Вставьте ссылку","es":"Insertar enlace"}'
    ["h_select_installation_dropbox_link_wrong"]='{"en":"Invalid link, please try again","ua":"Невірне посилання, спробуйте ще раз","ru":"Неправильная ссылка, попробуйте еще раз","es":"Enlace no válido, por favor inténtelo de nuevo"}'
    ["h_select_installation_type"]='{"en":"Selected installation type","ua":"Вибраний тип встановлення","ru":"Выбранный тип установки","es":"Tipo de instalación seleccionado"}'
    ["h_select_installation_link"]='{"en":"Link to installation archive","ua":"Посилання на інсталяційний архів","ru":"Ссылка на установочный архив","es":"Enlace al archivo de instalación"}'
    
    ["h_install_packages_title"]='{"en":"Installing necessary packages and dependencies","ua":"Встановлення необхідних пакетів та залежностей","ru":"Установка необходимых пакетов и зависимостей","es":"Instalando paquetes y dependencias necesarios"}'
    ["h_install_packages_start"]='{"en":"Installation","ua":"Встановлення","ru":"Установка","es":"Instalación"}'
    ["h_install_packages_comlpete"]='{"en":"Installation successful","ua":"Встановлення успішне","ru":"Установка успешна","es":"Instalación exitosa"}'
    ["h_install_packages_already"]='{"en":"Already installed","ua":"Вже встановлено","ru":"Уже установлено","es":"Ya instalado"}'
    ["h_install_packages_configure_start"]='{"en":"Configuring","ua":"Налаштування","ru":"Настройка","es":"Configuración"}'
    
    ["h_install_packages_configure_complete"]='{"en":"Configuration completed","ua":"Налаштування завершено","ru":"Настройка завершена","es":"Configuración completada"}'
    
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
    
    ["h_setup_firewall_execute"]='{"en":"Setting up the firewall","ua":"Налаштування брандмауера","ru":"Настройка брандмауэра","es":"Configuración del firewall"}'
    ["h_setup_firewall_complete"]='{"en""The firewall is configured, allowed","ua""Брандмауер налаштован, дозволено","ru""Брандмауэр настроен, разрешено","es""El firewall está configurado, permitido"}'
    ["h_setup_firewall_already"]='{"en""Firewall is already configured, allowed","ua""Брандмауер вже налаштовано, дозволено","ru""Брандмауэр уже настроен, разрешено","es""El firewall ya está configurado, permitido"}'
    
    
    ["h_install_title"]='{"en":"Installing MoonTrader trading terminal core","ua":"Встановлення ядра торгового терміналу MoonTrader","ru":"Установка ядра торгового терминала MoonTrader","es":"Instalando núcleo del terminal de trading de MoonTrader"}'
    ["h_install_mt_execute"]='{"en":"Downloading, unpacking and installing the MoonTrader trading terminal core...","ua":"Завантаження, розпакування та встановлення ядра торгового терміналу MoonTrader...","ru":"Загрузка, распаковка и установка ядра торгового терминала MoonTrader...","es":"Descargando, descomprimiendo e instalando el núcleo del terminal de trading de MoonTrader..."}'
    ["h_install_mt_complete"]='{"en":"Install, creation of startup script and quick launch link completed","ua":"Встановлення, створення скрипту запуску та посилання швидкого запуску завершено","ru":"Установка, создание скрипта запуска и ccылки быстрого запуска завершены","es":"Instalación, creación de script de inicio y enlace de inicio rápido completados"}'
    
    ["h_complete_install_title"]='{"en":"All installation operations completed successfully","ua":"Всі операції встановлення успішно завершені","ru":"Все операции установки успешно завершены","es":"Todas las operaciones de instalación se han completado correctamente"}'
    ["h_complete_install_waring"]='{"en":"Make sure to use tmux/screen to run the MoonTrader trading terminal in the background, otherwise, after disconnecting from SSH, the MTCore will also be forcibly closed.","ua":"Переконайтеся, що ви використовуєте tmux/screen для запуску торгового терміналу MoonTrader в фоновому режимі, інакше після відключення від SSH - MTCore також буде примусово закрито.","ru":"Убедитесь, что вы используете tmux/screen для запуска торгового терминала MoonTrader в фоновом режиме, иначе после отключения от SSH - MTCore также будет принудительно закрыт.","es":"Asegúrese de usar tmux/screen para ejecutar el terminal de trading de MoonTrader en segundo plano, de lo contrario, después de desconectarse de SSH, MTCore también se cerrará forzosamente."}'
    
    ["h_complete_install_info"]='{"en":"Full installation information","ua":"Повна інформація про встановлення","ru":"Полная информация об установке","es":"Información completa de instalación"}'
    ["h_complete_install_os"]='{"en":"Operating system","ua":"Операційна система","ru":"Операционная система","es":"Sistema operativo"}'
    ["h_complete_install_user"]='{"en":"User for whom the installation was performed","ua":"Користувач, для якого проведено встановлення","ru":"Пользователь, для которого произведена установка","es":"Usuario para quien se realizó la instalación"}'
    ["h_complete_install_dir"]='{"en":"MoonTrader is installed in the directory","ua":"MoonTrader встановлено в каталог","ru":"MoonTrader установлен в каталог","es":"MoonTrader se ha instalado en el directorio"}'
    ["h_complete_install_fail2ban"]='{"en":"Protection against password guessing has been set up based on Fail2Ban","ua":"Налаштован захист від перебору паролів на основі Fail2Ban","ru":"Настроена защита от перебора паролей на основе Fail2Ban","es":"Se ha configurado la protección contra adivinanza de contraseñas basada en Fail2Ban"}'
    ["h_complete_install_start"]='{"en":"Command to start","ua":"Команда для запуску","ru":"Команда для запуска","es":"Comando para iniciar"}'
    ["h_complete_install_reboot"]='{"en":"Press any key to apply all settings, the server will be restarted.","ua":"Для застосування всіх налаштувань натисніть будь-яку клавішу, сервер буде перезавантажено.","ru":"Для применения всех настроек нажмите любую клавишу, сервер будет перезагружен.","es":"Presione cualquier tecla para aplicar todas las configuraciones, el servidor se reiniciará."}'
    ["h_complete_install_firewall"]='{"en":"Firewall enabled, allowed","ua":"Брандмауер увімкнено, дозволено","ru":"Брандмауэр включен, разрешено","es":"Firewall habilitado, permitido"}'
)

# Function to select language
select_language() {
    local selected_lang=1
    local lang_list=("English" "Русский" "Українська" "Español")
    
    declare -A messages=(
        ["en"]="Select script language"
        ["ru"]="Выберите язык скрипта"
        ["ua"]="Виберіть мову скрипта"
        ["es"]="Seleccione el idioma del script"
    )
    
    SCRIPT_LANG="en"
    
    while true; do
        clear
        log select "${messages[$SCRIPT_LANG]}"
        echo
        for i in "${!lang_list[@]}"; do
            if [[ $selected_lang -eq $((i + 1)) ]]; then
                echo "$((i + 1))) [✔] ${lang_list[$i]}"
            else
                echo "$((i + 1))) [ ] ${lang_list[$i]}"
            fi
        done
        echo
        log select "$(extract_tips "h_setup_tips")"
        read -n 1 input
        case $input in
            [1-4])
                selected_lang=$input
                if [[ $selected_lang -eq 1 ]]; then
                    SCRIPT_LANG="en"
                    elif [[ $selected_lang -eq 2 ]]; then
                    SCRIPT_LANG="ru"
                    elif [[ $selected_lang -eq 3 ]]; then
                    SCRIPT_LANG="ua"
                    elif [[ $selected_lang -eq 4 ]]; then
                    SCRIPT_LANG="es"
                fi
            ;;
            "") break ;;
            [Qq]) echo && log info "$(extract_tips "h_exit")" && exit 0;;
        esac
    done
}


# Функция для отображения подсказки для переменной на указанном языке
function extract_tips() {
    local var_name="$1"
    
    # если lang не задан, то по умолчанию en
    if [ -z "$SCRIPT_LANG" ]; then
        SCRIPT_LANG="en"
    fi
    
    # Получить подсказку для переменной на указанном языке
    local hint=$(echo "${tips[$var_name]}" | awk -F'"' -v l="$SCRIPT_LANG" '{for(i=2;i<=NF;i+=4)if($i==l)print $(i+2)}')
    
    # Распечатать подсказку, если она не пуста
    if [ -n "$hint" ]; then
        echo "$hint"
    else
        echo "Hint not found for variable $var_name in language $SCRIPT_LANG"
    fi
}

# Функции для логирования
function log {
    local message_type="$1"
    local message="$2"
    
    local color_info="\e[34m"      # Синий
    local color_warning="\e[33m"   # Желтый
    local color_error="\e[31m"     # Красный
    
    local color_help="\e[36m"      # Бирюзовый (Циан)
    local color_execution="\e[35m" # Пурпурный
    local color_success="\e[32m"   # Зеленый
    local color_example="\e[90m"   # Серый (темный)
    local color_hint="\e[94m"      # Светло-синий
    local color_select="\e[92m"    # Светло-зеленый
    
    local color_reset="\e[0m"      # Сброс всех цветовых настроек
    
    
    case $message_type in
        "execution")
            echo -e "${color_execution}[$(extract_tips "h_msg_start")] $message${color_reset}" >&2
        ;;
        "success")
            echo -e "${color_success}[$(extract_tips "h_msg_success")] $message${color_reset}" >&2
        ;;
        "info")
            echo -e "${color_info}[$(extract_tips "h_msg_info")] $message${color_reset}" >&2
        ;;
        "warning")
            echo -e "${color_warning}[$(extract_tips "h_msg_warning")] $message${color_reset}" >&2
        ;;
        "error")
            echo -e "${color_error}[$(extract_tips "h_msg_error")] $message${color_reset}" >&2
            exit 1
        ;;
        "example")
            echo -e "${color_example}[$(extract_tips "h_msg_example")] $message${color_reset}" >&2
        ;;
        "hint")
            echo -e "${color_hint}[$(extract_tips "h_msg_hint")] $message${color_reset}" >&2
        ;;
        "select")
            echo -e "${color_select}$message${color_reset}" >&2
        ;;
        "title")
            local color_tittle=$(tput setaf 6)    # cyan color
            local color_tittle_reset=$(tput sgr0) # reset color
            local columns=$(tput cols)
            printf "%*s\n" $(((${#message} + $columns) / 2)) "${color_tittle}$message${color_tittle_reset}" >&2
        ;;
    esac
}

# Функция проверки операционной системы
# Return: $(check_os)
function check_os() {
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        if [ "$ID" = "ubuntu" ]; then
            if [ "$VERSION_ID" = "20.04" ]; then
                OS_NAME="Ubuntu 20.04"
                elif [ "$VERSION_ID" = "22.04" ]; then
                OS_NAME="Ubuntu 22.04"
                elif [ "$VERSION_ID" = "24.04" ]; then
                OS_NAME="Ubuntu 24.04"
            else
                log error "$(extract_tips "h_check_os_wrong")"
            fi
        else
            log error "$(extract_tips "h_check_os_wrong")"
        fi
    fi
}

function check_arch() {
    if [ "$(uname -m)" == "x86_64" ]; then
        CPU_ARCH="AMD64"
        elif [ "$(uname -m)" == "aarch64" ]; then
        CPU_ARCH="ARM"
    else
        log error "$(extract_tips "h_check_arch_wrong")"
    fi
}

# Функция проверки на запуск от root
function check_root {
    local os=$(check_os)
    
    if [ "$(id -u)" != "0" ]; then
        log error "$(extract_tips "h_check_root_wrong")"
    fi
}

function get_user() {
    local user=""
    local last_login_user=$(last pts/0 -1 | awk '{print $1; exit}')
    local list_usrers=($(awk -F: '($3>=1000)&&($1!="nobody"){print $1}' /etc/passwd | paste -sd " "))
    for list_user in "${list_usrers[@]}" "root"; do
        if [[ "$list_user" == *"$last_login_user"* ]]; then
            user=$list_user
            break
            return
        fi
    done
    
    if [ -n "$user" ]; then
        DEFAULT_USER=$user
        DEFAULT_USER_DIRECTORY=$(eval echo ~$user)
    else
        log error "Error get_user"
    fi
}

function get_mt_link() {
    local cpu_arch=$1
    local archive_from=$2
    local link=""
    
    if [[ $archive_from == "official" ]]; then
        if [[ $cpu_arch == "AMD64" ]]; then
            link="https://cdn3.moontrader.com/beta/linux-x86_64/MoonTrader-linux-x86_64.tar.xz"
            elif [[ $cpu_arch == "ARM" ]]; then
            link="https://cdn3.moontrader.com/beta/linux-arm64/MoonTrader-linux-arm64.tar.xz"
        else
            log error "Error get_mt_official_link" # TODO: translate
        fi
        elif [[ $archive_from == "dropbox" ]]; then
        log select "$(extract_tips "h_select_installation_dropbox")"
        log example "https://www.dropbox.com/s/.../archive_name.tar.xz?dl=0"
        read -p "$(extract_tips "h_select_installation_dropbox_link"): " link
        while ! [[ $link == *".tar.xz"* ]]; do
            clear
            log warning "$(extract_tips "h_select_installation_dropbox_link_wrong")"
            log example "https://www.dropbox.com/s/.../...tar.xz?dl=0"
            read -p "$(extract_tips "h_select_installation_dropbox_link"): " link
        done
        link=${link%?}1
    else
        log error "Error get_mt_link" # TODO: translate
    fi
    
    if ! wget --spider $link 2>/dev/null; then
        log error "Error $link not reachable"
    else
        if wget --quiet --spider $link 2>/dev/null; then
            echo $link
        else
            log error "Error not found remote file $link" # TODO: translate
        fi
    fi
}


# Function to display the main menu
setup_install() {
    local selected_option=1
    
    while true; do
        clear
        log select "$(extract_tips "h_setup_install_text")"
        echo
        if [[ $selected_option -eq 1 ]]; then
            echo "1) [✔] Automatic"
            echo "2) [ ] Custom"
        else
            echo "1) [ ] Automatic "
            echo "2) [✔] Custom"
        fi
        echo
        log select "$(extract_tips "h_setup_tips")"
        read -n 1 input
        case $input in
            1) selected_option=1 ;;
            2) selected_option=2 ;;
            "") break ;;
            [Qq]) echo && log info "$(extract_tips "h_exit")" && exit 0;;
        esac
    done
    
    INSTALL_OPTION=$((selected_option))
}

# Function to handle automatic installation setup
setup_automatic() {
    SETUP_CUSTOM_LINK=0
    SETUP_TIME=1
    SETUP_FIREWALL=1
    SETUP_FAIL2BAN=1
    SETUP_MT_GUARDIAN=0
}

# Function to handle custom installation setup with multi-select options
setup_custom() {
    local custom_link_choice=0
    local time_choice=1
    local firewall_choice=1
    local fil2ban_choice=1
    local defender_choice=0
    
    while true; do
        clear
        log select "$(extract_tips "h_custom_setup_request")"
        echo
        if [[ $custom_link_choice -eq 0 ]]; then
            echo "1) [✔] MT Link: Official"
            echo "2) [ ] MT Link: Dropbox"
        else
            echo "1) [ ] MT Link: Official"
            echo "2) [✔] MT Link: Dropbox"
        fi
        if [[ $time_choice -eq 1 ]]; then
            echo "3) [✔] Setup Time(chrony)"
        else
            echo "3) [ ] Setup Time(chrony)"
        fi
        if [[ $firewall_choice -eq 1 ]]; then
            echo "4) [✔] Setup Firewall"
        else
            echo "4) [ ] Setup Firewall"
        fi
        if [[ $fil2ban_choice -eq 1 ]]; then
            echo "5) [✔] Setup Fail2Ban"
        else
            echo "5) [ ] Setup Fail2Ban"
        fi
        if [[ $defender_choice -eq 1 ]]; then
            echo "6) [✔] Setup MT Guardian"
        else
            echo "6) [ ] Setup MT Guardian"
        fi
        echo
        log select "$(extract_tips "h_setup_tips")"
        read -n 1 input
        case $input in
            1) custom_link_choice=$((1 - custom_link_choice)) ;;
            2) custom_link_choice=$((1 - custom_link_choice)) ;;
            3) time_choice=$((1 - time_choice)) ;;
            4) firewall_choice=$((1 - firewall_choice)) ;;
            5) fil2ban_choice=$((1 - fil2ban_choice)) ;;
            6) defender_choice=$((1 - defender_choice)) ;;
            "") break ;;
            [Qq]) echo && log info "$(extract_tips "h_exit")" && exit 0;;
        esac
    done
    
    SETUP_CUSTOM_LINK=$((custom_link_choice))
    SETUP_TIME=$((time_choice))
    SETUP_FIREWALL=$((firewall_choice))
    SETUP_FAIL2BAN=$((fil2ban_choice))
    SETUP_MT_GUARDIAN=$((defender_choice))
}

# Функция включения swap, если не включен
function enable_swap() {
    log execution "$(extract_tips "h_install_packages_start"): Swap"
    if ! free | awk '/^Swap:/ {exit !$2}'; then
        fallocate -l 2G /swapfile
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile
        bash -c 'echo "/swapfile none swap sw 0 0" >>/etc/fstab'
        log success "$(extract_tips "h_install_packages_comlpete"): Swap"
    else
        log success "$(extract_tips "h_install_packages_already"): Swap"
    fi
}

# Function to install a package if it's not already installed
install_package() {
    local package_name=$1
    
    log execution "$(extract_tips "h_install_packages_start"): $package_name"
    if dpkg -l | grep -q "^ii\s*$package_name\s"; then
        log success "$(extract_tips "h_install_packages_already"): $package_name"
    else
        DEBIAN_FRONTEND=noninteractive apt install -y $package_name >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            log success "$(extract_tips "h_install_packages_comlpete"): $package_name"
        else
            log error "Error occurred during installation of $package_name. Exiting."
        fi
        # Additional package-specific configurations
        case $package_name in
            "libtommath1")
                if [ $CPU_ARCH == "AMD64" ]; then
                    if [ -f "/usr/lib/x86_64-linux-gnu/libtommath.so.0" ]; then
                        rm /usr/lib/x86_64-linux-gnu/libtommath.so.0
                    fi
                    ln -s libtommath.so.1 /usr/lib/x86_64-linux-gnu/libtommath.so.0
                    elif [ $CPU_ARCH == "ARM" ]; then
                    if [ -f "/usr/lib/aarch64-linux-gnu/libtommath.so.0" ]; then
                        rm /usr/lib/aarch64-linux-gnu/libtommath.so.0
                    fi
                    ln -s libtommath.so.1 /usr/lib/aarch64-linux-gnu/libtommath.so.0
                fi
            ;;
            "fail2ban")
                log execution "$(extract_tips "h_install_packages_configure_start"): $package_name"
                touch /etc/fail2ban/jail.local
                echo -e "[sshd]\nport = ssh\nfindtime = 3600\nmaxretry = 3\nbantime = 86400" >/etc/fail2ban/jail.local
                systemctl enable fail2ban >/dev/null 2>&1 || log error "Error: Failed to enable fail2ban service."
                systemctl restart fail2ban
                log success "$(extract_tips "h_install_packages_configure_complete"): $package_name"
            ;;
        esac
    fi
}

# Функция обновления пакетов и зависимостей
function update_packages() {
    log execution "$(extract_tips "h_update_packages_title")..."
    apt update >/dev/null 2>&1 || log error "Error: Failed to update package lists."
    DEBIAN_FRONTEND=noninteractive apt upgrade -y >/dev/null 2>&1 || log error "Error: Failed to update packages."
    log success "$(extract_tips "h_update_packages_complete")"
}

# Функция удаления ненужных пакетов и зависимостей
function remove_packages() {
    local rm_pkgs=(snapd exim exim4)
    
    for pkg in "${rm_pkgs[@]}"; do
        log execution "$(extract_tips "h_remove_packages_start"): $pkg"
        if dpkg -s $pkg >/dev/null 2>&1; then
            if [ $pkg == "snapd" ]; then
                apt -yqq remove $pkg --purge >/dev/null 2>&1
                rm -rf ~/snap
                rm -rf /var/snap
                rm -rf /var/lib/snapd
            else
                apt -yqq remove $pkg >/dev/null 2>&1 || log error "Error: Failed to remove $pkg."
            fi
            log success "$(extract_tips "h_remove_packages_complete"): $pkg"
        else
            log success "$(extract_tips "h_remove_packages_already"): $pkg"
        fi
    done
    apt autoremove -y >/dev/null 2>&1 || log error "Error: Failed to remove unnecessary packages."
}

# Function to install .NET SDK or runtime and a specific .NET runtime version
# https://learn.microsoft.com/en-us/dotnet/core/install/linux-package-mixup?pivots=os-linux-ubuntu#i-need-a-version-of-net-that-isnt-provided-by-my-linux-distribution
install_dotnet() {
    local dotnet_version=$1
    local preferences_file="/etc/apt/preferences"
    local preferences_text="Package: dotnet* aspnet* netstandard*\nPin: origin \"packages.microsoft.com\"\nPin-Priority: -10"
    
    # Check if the preferences file exists
    if [ -f "$preferences_file" ]; then
        # Search for the pattern in /etc/apt/preferences
        if ! grep -qE "Package: (dotnet\*|aspnet\*|netstandard\*)" "$preferences_file"; then
            apt remove 'dotnet*' 'aspnet*' 'netstandard*' -y >/dev/null 2>&1
            echo -e "$preferences_text" >> "$preferences_file"
            apt-get update -y >/dev/null 2>&1
        fi
    else
        apt remove 'dotnet*' 'aspnet*' 'netstandard*' -y >/dev/null 2>&1
        echo -e "$preferences_text" > "$preferences_file"
        apt-get update -y >/dev/null 2>&1
    fi
    # Install the .NET SDK or runtime
    log execution "$(extract_tips "h_install_packages_start"): .NET $dotnet_version"
    if dotnet --list-runtimes &> /dev/null && dotnet --list-runtimes | grep -q "App $dotnet_version"; then
        log success "$(extract_tips "h_install_packages_already"): .NET runtime $dotnet_version"
    else
        apt-get install -y dotnet-sdk-$dotnet_version >/dev/null 2>&1 || log error "Error: Failed to install .NET runtime $dotnet_version."
        log success "$(extract_tips "h_install_packages_comlpete"): .NET runtime $dotnet_version"
    fi
}

# Function to install the Fail2Ban package and configure it
function setup_firewall() {
    log execution "$(extract_tips "h_setup_firewall_execute")"
    if ! iptables -nL | grep 4242 >/dev/null 2>&1; then
        iptables -F
        iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
        iptables -A INPUT -m state --state INVALID -j DROP
        iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
        iptables -A INPUT -p udp --dport 4242 -j ACCEPT
        iptables -A INPUT -p tcp --dport ssh -j ACCEPT
        iptables -A INPUT -i lo -j ACCEPT
        iptables -A INPUT -j DROP
        netfilter-persistent save >/dev/null 2>&1 || log error "Error: Failed to save the firewall rules."
        log success "$(extract_tips "h_setup_firewall_complete"): Ping,SSH,4242udp"
    else
        log success "$(extract_tips "h_setup_firewall_already"): Ping,SSH,4242udp"
    fi
}

# Function to install the MoonTrader trading terminal core
function install_mt() {
    log execution "$(extract_tips "h_install_mt_execute")"
    local user=$1
    local folder="$2/moontrader"
    local link=$3
    
    # If the folder exists, remove it and create a new one
    if [ -d "$folder" ]; then
        rm -rf "$folder"
    fi
    mkdir -p "$folder"
    # Download the installation archive and extract it
    if [ ! -f "$folder/MTCore" ]; then
        wget -O MoonTrader.tar.xz "$link" >/dev/null 2>&1 || log error "Error: Failed to download the installation archive from $link."
        tar -xpJf MoonTrader.tar.xz -C $folder >/dev/null 2>&1 || log error "Error: Failed to extract the installation archive."
        rm MoonTrader.tar.xz
    fi
    # Create a startup script and a quick launch link
    if [ -f "$folder/MTCore" ] && [ ! -f ""$folder/start_mt.sh"" ]; then
        chmod +x "$folder/MTCore"
        touch "$folder/start_mt.sh" && chmod +x "$folder/start_mt.sh"
        echo -e "#!/bin/bash" > "$folder/start_mt.sh"
        echo -e "MTCORE_PATH=\"$folder/MTCore\"" >> "$folder/start_mt.sh"
        echo -e "if [ -n \"\$1\" ] && [ \"\$1\" == \"--no-update\" ]; then" >> "$folder/start_mt.sh"
        echo -e "    \"\$MTCORE_PATH\" --no-update" >> "$folder/start_mt.sh"
        echo -e "elif [ \"\$1\" == \"--stop\" ]; then" >> "$folder/start_mt.sh"
        echo -e "    killall MTCore" >> "$folder/start_mt.sh"
        echo -e "else" >> "$folder/start_mt.sh"
        echo -e "    \"\$MTCORE_PATH\"" >> "$folder/start_mt.sh"
        echo -e "fi" >> "$folder/start_mt.sh"
        if [ -f "/usr/bin/MoonTrader" ]; then
            rm /usr/bin/MoonTrader
        fi
        ln -s "$folder/start_mt.sh" /usr/bin/MoonTrader
    fi
    # Change ownership of the folder to the specified user
    chown -R "$user:$user" "$folder" >/dev/null 2>&1 || log error "Error: Failed to change the owner of the folder to $user."
    log success "$(extract_tips "h_install_mt_complete")"
}

# Function to configure the time synchronization service
function setup_time() {
    log execution "$(extract_tips "h_install_packages_configure_start"): chrony"
    timedatectl set-timezone Etc/UTC
    # Enable and start the chronyd service
    systemctl enable chrony >/dev/null 2>&1 || log error "Error: Failed to enable chrony service."
    # Configure the chrony service
    echo -e "# Start of chrony configuration" >/etc/chrony/chrony.conf
    if [[ $(dmidecode --string system-uuid) =~ ^[Ee][Cc]2 ]]; then # Configure time sync for AWS EC2
        # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html
        echo -e "server 169.254.169.123 prefer iburst minpoll 4 maxpoll 4" >> /etc/chrony/chrony.conf
    fi
    echo -e "server 0.pool.ntp.org iburst" >> /etc/chrony/chrony.conf
    echo -e "server 1.pool.ntp.org iburst" >> /etc/chrony/chrony.conf
    echo -e "server 2.pool.ntp.org iburst" >> /etc/chrony/chrony.conf
    echo -e "server 3.pool.ntp.org iburst" >> /etc/chrony/chrony.conf
    echo -e "pool time.aws.com iburst" >> /etc/chrony/chrony.conf
    echo -e "minsources 2" >>/etc/chrony/chrony.conf
    echo -e "maxchange 1000 0 0" >>/etc/chrony/chrony.conf
    echo -e "makestep 0.1 1" >>/etc/chrony/chrony.conf
    echo -e "maxdrift 500" >>/etc/chrony/chrony.conf
    echo -e "maxslewrate 500" >>/etc/chrony/chrony.conf
    echo -e "driftfile /var/lib/chrony/drift" >>/etc/chrony/chrony.conf
    echo -e "rtcsync" >>/etc/chrony/chrony.conf
    systemctl restart chronyd >/dev/null 2>&1 || log error "Error: Failed to restart chronyd service."

    log success "$(extract_tips "h_install_packages_configure_complete"): chrony"
}


####################################################################################### Main body script #########################################################################################################
SCRIPT_LANG=
select_language

check_root

OS_NAME=
check_os

CPU_ARCH=
check_arch

DEFAULT_USER=
DEFAULT_USER_DIRECTORY=
get_user

INSTALL_OPTION=
setup_install

SETUP_CUSTOM_LINK=
SETUP_TIME=
SETUP_FIREWALL=
SETUP_FAIL2BAN=
SETUP_MT_GUARDIAN=
if [[ $INSTALL_OPTION -eq 1 ]]; then
    setup_automatic
    elif [[ $INSTALL_OPTION -eq 2 ]]; then
    setup_custom
fi

# Get the link to download MoonTrader
if [[ $SETUP_CUSTOM_LINK -eq 0 ]]; then
    SETUP_MT_LINK=$(get_mt_link "$CPU_ARCH" "official")
else
    SETUP_MT_LINK=$(get_mt_link "$CPU_ARCH" "dropbox")
fi
clear
log title "$(extract_tips "h_install_title")"
enable_swap

remove_packages
update_packages

install_package "apt-transport-https"
install_package "dmidecode"
install_package "htop"
install_package "mc"
install_package "tmux"
install_package "psmisc"
install_package "libncurses6"
install_package "libtommath1"
install_package "p7zip-full"
install_package "git"

# install_dotnet 6.0
# install_dotnet 7.0
# install_dotnet 8.0

# Install the necessary packages and dependencies
if [[ $SETUP_TIME -eq 1 ]]; then
    install_package "chrony"
    setup_time
fi

if [[ $SETUP_FIREWALL -eq 1 ]]; then
    install_package "iptables-persistent"
    setup_firewall
fi

if [[ $SETUP_FAIL2BAN -eq 1 ]]; then
    install_package "fail2ban"
fi

if [[ $SETUP_MT_GUARDIAN -eq 1 ]]; then
    log info "Setup MT Guardian"
    if [ -d $DEFAULT_USER_DIRECTORY/MTGuardian ]; then
        rm -rf $DEFAULT_USER_DIRECTORY/MTGuardian
    fi
    git clone https://github.com/SlippingForest/MTGuardian $DEFAULT_USER_DIRECTORY/MTGuardian
    chmod +x $DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian
    
    # find row MT_CORE_DIR=/full/path/to/mt/ in $DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian.settings and replace /full/path/to/mt/ to $DEFAULT_USER_DIRECTORY/moontrader
    sed -i "s|MT_CORE_DIR=.*|MT_CORE_DIR=$DEFAULT_USER_DIRECTORY/moontrader|" $DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian.settings

     # find row MT_DEFAULT_PROFILE_CONFIG=/full/path/to/user/.config/moontrader-data/data/default.profile in $DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian.settings and replace /full/path/to/user/.config/moontrader-data/data/default.profile to $DEFAULT_USER_DIRECTORY/.config/moontrader-data/data/default.profile
    sed -i "s|MT_DEFAULT_PROFILE_CONFIG=.*|MT_DEFAULT_PROFILE_CONFIG=$DEFAULT_USER_DIRECTORY/.config/moontrader-data/data/default.profile|" $DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian.settings


    # request telegram token and chat_id
    read -p "Enter name server for MT Guardian: " G_SERVER_NAME
    read -p "Enter your Telegram bot token: " TELEGRAM_BOT_TOKEN
    read -p "Enter your Telegram chat ID: " TELEGRAM_CHAT_ID

    # find row MT_CORE_SERVER_NAME=moontrader in $DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian.settings and replace moontrader to $G_SERVER_NAME
    sed -i "s|MT_CORE_SERVER_NAME=.*|MT_CORE_SERVER_NAME='$G_SERVER_NAME'|" $DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian.settings

    # find row TG_API_TOKEN=0000000000:AABBBBBBBBBBCCCCCCCCDDDDDDDFFFFFFFF in $DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian.settings and replace 0000000000:AABBBBBBBBBBCCCCCCCCDDDDDDDFFFFFFFF to $TELEGRAM_BOT_TOKEN
    sed -i "s|TG_API_TOKEN=.*|TG_API_TOKEN=$TELEGRAM_BOT_TOKEN|" $DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian.settings

    # find row TG_CHAT_ID='-1234567890123 -2345678912345' in $DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian.settings and replace '-1234567890123 -2345678912345' to $TELEGRAM_CHAT_ID
    sed -i "s|TG_CHAT_ID=.*|TG_CHAT_ID='$TELEGRAM_CHAT_ID'|" $DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian.settings
    
    
    rc_file="/etc/rc.local"
    rc_file_line="/bin/su -s /bin/bash $DEFAULT_USER -c \"/usr/bin/screen -dmS MoonTrader bash -c '$DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian; exec bash'\""
    
    # Check if rc.local exists and is executable
    if [ ! -f "$rc_file" ]; then
        echo "Creating $rc_file..."
        echo -e "#!/bin/bash\n\n$rc_file_line\nexit 0" > "$rc_file"
        chmod +x "$rc_file"
    else
        # Check if the script content is already in rc.local
        if ! grep -q "$DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian" "$rc_file"; then
            echo "Inserting script into $rc_file..."
            # insert $rc_file_line before the "exit 0" line
            sed -i "/exit 0/i $rc_file_line" "$rc_file"
        else
            echo "Script already exists in $rc_file."
        fi
    fi
    
    chown root:root "$rc_file"
    chmod 700 "$rc_file"
    log success "MT Guardian installed"
fi

install_mt "$DEFAULT_USER" "$DEFAULT_USER_DIRECTORY" "$SETUP_MT_LINK"


log title "$(extract_tips "h_complete_install_title")"
log info "$(extract_tips "h_complete_install_os"): $CPU_ARCH $OS_NAME"
log info "$(extract_tips "h_complete_install_user"): $DEFAULT_USER"
log info "$(extract_tips "h_complete_install_dir"): $DEFAULT_USER_DIRECTORY/moontrader"
echo
log hint "$(extract_tips "h_complete_install_start"): MoonTrader"
log hint "$(extract_tips "h_complete_install_waring")"
echo
log warning "$(extract_tips "h_complete_install_reboot")"
read -n 1
reboot