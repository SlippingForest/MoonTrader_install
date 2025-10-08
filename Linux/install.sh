#!/bin/bash

declare -A tips=(
    ["h_check_os_valid"]='{"en":"Current operating system","ua":"Поточна операційна система","ru":"Текущая операционная система","es":"Sistema operativo actual"}'
    ["h_check_os_wrong"]='{"en":"This script only supports Ubuntu20+ operating systems","ua":"Цей скрипт підтримує тільки операційні системи Ubuntu20+","ru":"Этот скрипт поддерживает только операционные системы Ubuntu20+","es":"Este script solo es compatible con los sistemas operativos Ubuntu20+"}'
    ["h_check_arch_wrong"]='{"en":"This script only supports AMD64 and ARM architectures","ua":"Цей скрипт підтримує тільки архітектури AMD64 і ARM","ru":"Этот скрипт поддерживает только архитектуры AMD64 и ARM","es":"Este script solo es compatible con las arquitecturas AMD64 y ARM"}'
    ["h_check_arch_valid"]='{"en":"Current architecture","ua":"Поточна архітектура","ru":"Текущая архитектура","es":"Arquitectura actual"}'

    ["h_check_root_wrong"]='{"en":"This script must be run as root","ua":"Цей скрипт має бути виконаний від імені користувача root","ru":"Этот скрипт должен выполнятся от пользователя root","es":"Este script debe ejecutarse como root"}'

    ["h_exit"]='{"en":"Installation canceled.","ua":"Встановлення скасовано.","ru":"Установка отменена.","es":"Instalación cancelada."}'

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
    ["h_setup_install_option_automatic"]='{"en":"Automatic installation","ua":"Автоматичне встановлення","ru":"Автоматическая установка","es":"Instalación automática"}'
    ["h_setup_install_option_custom"]='{"en":"Custom installation","ua":"Користувацьке встановлення","ru":"Пользовательская установка","es":"Instalación personalizada"}'
    ["h_setup_install_text"]='{"en":"Select installation option","ua":"Оберіть варіант встановлення","ru":"Выберите вариант установки","es":"Seleccione una opción de instalación"}'
    ["h_setup_install_tips"]='{"en":"Use numbers to toggle, Enter to confirm, Q to exit.","ua":"Використовуйте цифри для перемикання, Enter для підтвердження, Q для виходу.","ru":"Используйте цифры для переключения, Enter для подтверждения, Q для выхода.","es":"Use números para alternar, Enter para confirmar, Q para salir."}'
    ["h_setup_custom_title"]='{"en": "Custom installation setup:","ua": "Налаштування користувацького встановлення:","ru": "Настройка пользовательской установки:","es": "Configuración de instalación personalizada:"}'

    # select messages
    ["h_select_installation_title"]='{"en":"Choose an installation option","ua":"Оберіть варіант встановлення","ru":"Выберите вариант установки","es":"Elija una opción de instalación"}'
    ["h_select_installation_dropbox"]='{"en":"Installation using https://www.dropbox.com/","ua":"Встановлення за допомогою https://www.dropbox.com/","ru":"Установка с использованием https://www.dropbox.com/","es":"Instalación usando https://www.dropbox.com/"}'
    ["h_select_installation_dropbox_link"]='{"en":"Insert link","ua":"Вставте посилання","ru":"Вставьте ссылку","es":"Insertar enlace"}'
    ["h_select_installation_dropbox_link_wrong"]='{"en":"Invalid link, please try again","ua":"Невірне посилання, спробуйте ще раз","ru":"Неправильная ссылка, попробуйте еще раз","es":"Enlace no válido, por favor inténtelo de nuevo"}'
    ["h_select_installation_type"]='{"en":"Selected installation type","ua":"Вибраний тип встановлення","ru":"Выбранный тип установки","es":"Tipo de instalación seleccionado"}'
    ["h_select_installation_link"]='{"en":"Link to installation archive","ua":"Посилання на інсталяційний архів","ru":"Ссылка на установочный архив","es":"Enlace al archivo de instalación"}'

    # setup message for all
    ["h_setup_start"]='{"en":"Setting up:","ua":"Налаштування:","ru":"Настройка:","es":"Configuración:"}'
    ["h_setup_complete"]='{"en":"Setup completed successfully:","ua":"Налаштування успішно завершено:","ru":"Настройка успешно завершена:","es":"Configuración completada con éxito:"}'
    ["h_setup_already"]='{"en":"Already set up:","ua":"Вже налаштовано:","ru":"Уже настроено:","es":"Ya configurado:"}'
    ["h_setup_error"]='{"en":"Setup failed with an error:","ua":"Налаштування завершилось з помилкою:","ru":"Настройка завершилась с ошибкой:","es":"La configuración falló con un error:"}'

    ["h_install_packages_title"]='{"en":"Installing necessary packages and dependencies","ua":"Встановлення необхідних пакетів та залежностей","ru":"Установка необходимых пакетов и зависимостей","es":"Instalando paquetes y dependencias necesarios"}'
    ["h_install_packages_start"]='{"en":"Installation","ua":"Встановлення","ru":"Установка","es":"Instalación"}'
    ["h_install_packages_complete"]='{"en":"Installation successful","ua":"Встановлення успішне","ru":"Установка успешна","es":"Instalación exitosa"}'
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
    ["h_setup_firewall_complete"]='{"en":"The firewall is configured, allowed","ua":"Брандмауер налаштован, дозволено","ru":"Брандмауэр настроен, разрешено","es":"El firewall está configurado, permitido"}'
    ["h_setup_firewall_already"]='{"en":"Firewall is already configured, allowed","ua":"Брандмауер вже налаштовано, дозволено","ru":"Брандмауэр уже настроен, разрешено","es":"El firewall ya está configurado, permitido"}'

    ["h_install_title"]='{"en":"Installing MoonTrader trading terminal core","ua":"Встановлення ядра торгового терміналу MoonTrader","ru":"Установка ядра торгового терминала MoonTrader","es":"Instalando núcleo del terminal de trading de MoonTrader"}'
    ["h_install_mt_execute"]='{"en":"Downloading, unpacking and installing the MoonTrader trading terminal core...","ua":"Завантаження, розпакування та встановлення ядра торгового терміналу MoonTrader...","ru":"Загрузка, распаковка и установка ядра торгового терминала MoonTrader...","es":"Descargando, descomprimiendo e instalando el núcleo del terminal de trading de MoonTrader..."}'
    ["h_install_mt_complete"]='{"en":"Install, creation of startup script and quick launch link completed","ua":"Встановлення, створення скрипту запуску та посилання швидкого запуску завершено","ru":"Установка, создание скрипта запуска и ccылки быстрого запуска завершены","es":"Instalación, creación de script de inicio y enlace de inicio rápido completados"}'

    ["h_complete_install_title"]='{"en":"All installation operations completed successfully","ua":"Всі операції встановлення успішно завершені","ru":"Все операции установки успешно завершены","es":"Todas las operaciones de instalación se han completado correctamente"}'
    ["h_complete_install_warning"]='{"en":"Make sure to use tmux/screen to run the MoonTrader trading terminal in the background, otherwise, after disconnecting from SSH, the MTCore will also be forcibly closed.","ua":"Переконайтеся, що ви використовуєте tmux/screen для запуску торгового терміналу MoonTrader в фоновому режимі, інакше після відключення від SSH - MTCore також буде примусово закрито.","ru":"Убедитесь, что вы используете tmux/screen для запуска торгового терминала MoonTrader в фоновом режиме, иначе после отключения от SSH - MTCore также будет принудительно закрыт.","es":"Asegúrese de usar tmux/screen para ejecutar el terminal de trading de MoonTrader en segundo plano, de lo contrario, después de desconectarse de SSH, MTCore también se cerrará forzosamente."}'

    ["h_complete_install_info"]='{"en":"Full installation information","ua":"Повна інформація про встановлення","ru":"Полная информация об установке","es":"Información completa de instalación"}'
    ["h_complete_install_os"]='{"en":"Operating system","ua":"Операційна система","ru":"Операционная система","es":"Sistema operativo"}'
    ["h_complete_install_user"]='{"en":"User for whom the installation was performed","ua":"Користувач, для якого проведено встановлення","ru":"Пользователь, для которого произведена установка","es":"Usuario para quien se realizó la instalación"}'
    ["h_complete_install_dir"]='{"en":"MoonTrader is installed in the directory","ua":"MoonTrader встановлено в каталог","ru":"MoonTrader установлен в каталог","es":"MoonTrader se ha instalado en el directorio"}'
    ["h_complete_install_fail2ban"]='{"en":"Protection against password guessing has been set up based on Fail2Ban","ua":"Налаштован захист від перебору паролів на основі Fail2Ban","ru":"Настроена защита от перебора паролей на основе Fail2Ban","es":"Se ha configurado la protección contra adivinanza de contraseñas basada en Fail2Ban"}'
    ["h_complete_install_start"]='{"en":"Command to start","ua":"Команда для запуску","ru":"Команда для запуска","es":"Comando para iniciar"}'
    ["h_complete_install_reboot"]='{"en":"Press any key to apply all settings, the server will be restarted.","ua":"Для застосування всіх налаштувань натисніть будь-яку клавішу, сервер буде перезавантажено.","ru":"Для применения всех настроек нажмите любую клавишу, сервер будет перезагружен.","es":"Presione cualquier tecla para aplicar todas las configuraciones, el servidor se reiniciará."}'
    ["h_complete_install_firewall"]='{"en":"Firewall enabled, allowed","ua":"Брандмауер увімкнено, дозволено","ru":"Брандмауэр включен, разрешено","es":"Firewall habilitado, permitido"}'

    # services message
    ["h_service_enable_error"]='{"en":"Failed to enable service","ua":"Не вдалося увімкнути службу","ru":"Не удалось включить службу","es":"Error al habilitar servicio"}'
    ["h_service_restart_error"]='{"en":"Failed to restart service","ua":"Не вдалося перезапустити службу","ru":"Не удалось перезапустить службу","es":"Error al reiniciar servicio"}'

    # Enhanced error messages for better debugging
    ["h_get_user_error"]='{"en":"Could not determine default user","ua":"Не вдалося визначити користувача за замовчуванням","ru":"Не удалось определить пользователя по умолчанию","es":"No se pudo determinar el usuario predeterminado"}'
    ["h_package_install_error"]='{"en":"Failed to install package","ua":"Не вдалося встановити пакет","ru":"Не удалось установить пакет","es":"Error al instalar el paquete"}'
    ["h_package_remove_error"]='{"en":"Failed to remove package","ua":"Не вдалося видалити пакет","ru":"Не удалось удалить пакет","es":"Error al eliminar el paquete"}'
    ["h_update_packages_error"]='{"en":"Failed to update packages","ua":"Не вдалося оновити пакети","ru":"Не удалось обновить пакеты","es":"Error al actualizar paquetes"}'
    ["h_firewall_rule_error"]='{"en":"Failed to apply firewall rule","ua":"Не вдалося застосувати правило брандмауера","ru":"Не удалось применить правило брандмауэра","es":"Error al aplicar regla de firewall"}'
    ["h_download_error"]='{"en":"Failed to download file","ua":"Не вдалося завантажити файл","ru":"Не удалось загрузить файл","es":"Error al descargar archivo"}'
    ["h_extract_error"]='{"en":"Failed to extract archive","ua":"Не вдалося розпакувати архів","ru":"Не удалось извлечь архив","es":"Error al extraer archivo"}'
    ["h_chown_error"]='{"en":"Failed to change file ownership","ua":"Не вдалося змінити власника файлу","ru":"Не удалось изменить владельца файла","es":"Error al cambiar propietario del archivo"}'
    ["h_get_mt_official_link_error"]='{"en":"Unsupported CPU architecture for official download","ua":"Непідтримувана архітектура процесора для офіційного завантаження","ru":"Неподдерживаемая архитектура процессора для официальной загрузки","es":"Arquitectura de CPU no compatible para descarga oficial"}'
    ["h_get_mt_link_error"]='{"en":"Invalid archive source specified","ua":"Вказано недійсне джерело архіву","ru":"Указан недействительный источник архива","es":"Fuente de archivo no válida especificada"}'
    ["h_link_not_reachable"]='{"en":"Link not accessible","ua":"Посилання недоступне","ru":"Ссылка недоступна","es":"Enlace no accesible"}'
    ["h_remote_file_not_found"]='{"en":"Remote file not found","ua":"Віддалений файл не знайдено","ru":"Удаленный файл не найден","es":"Archivo remoto no encontrado"}'
)

# Global variables
declare SCRIPT_LANG=""
declare OS_NAME=""
declare CPU_ARCH=""
declare DEFAULT_USER=""
declare DEFAULT_USER_DIRECTORY=""
declare INSTALL_OPTION=""
declare SETUP_CUSTOM_LINK=""
declare SETUP_TIME=""
declare SETUP_FIREWALL=""
declare SETUP_FAIL2BAN=""
declare SETUP_MT_GUARDIAN=""
declare SETUP_MT_LINK=""

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
        log select "$(extract_tips "h_setup_install_tips")"
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
        [Qq]) echo && log info "$(extract_tips "h_exit")" && exit 0 ;;
        esac
    done
}

# Function to extract tips for the current language
function extract_tips() {
    local var_name="$1"

    # Default to English if language not set
    if [ -z "$SCRIPT_LANG" ]; then
        SCRIPT_LANG="en"
    fi

    # Extract hint for the variable in the specified language
    local hint=$(echo "${tips[$var_name]}" | awk -F'"' -v l="$SCRIPT_LANG" '{for(i=2;i<=NF;i+=4)if($i==l)print $(i+2)}')

    # Print hint if not empty
    if [ -n "$hint" ]; then
        echo "$hint"
    else
        echo "Hint not found for variable $var_name in language $SCRIPT_LANG"
    fi
}

# Logging functions
function log {
    local message_type="$1"
    local message="$2"

    # Basic ANSI colors
    local color_info="\e[1;34m"      # Bold Blue
    local color_warning="\e[1;33m"   # Bold Yellow
    local color_error="\e[1;31m"     # Bold Red
    local color_help="\e[1;36m"      # Bold Cyan
    local color_execution="\e[1;35m" # Bold Purple
    local color_success="\e[1;32m"   # Bold Green
    local color_example="\e[37m"     # Light Gray
    local color_hint="\e[36m"        # Cyan
    local color_select="\e[1;32m"    # Bold Green
    local color_reset="\e[0m"        # Reset

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
        echo -e "${color_select}>>> $message${color_reset}" >&2
        ;;
    "title")
        local color_title="\e[1;36m" # Bold cyan
        local color_reset_title="\e[0m"
        local columns=$(tput cols 2>/dev/null || echo 80)
        local separator=$(printf '%*s' "$columns" '' | tr ' ' '=')
        echo -e "${color_title}${separator}${color_reset_title}" >&2

        # Calculate padding for centered text
        local text_length=${#message}
        local padding=$(((columns - text_length) / 2))
        local spaces=$(printf '%*s' "$padding" '')

        # Print centered text with colors using echo -e instead of printf
        echo -e "${spaces}${color_title}${message}${color_reset_title}" >&2
        echo -e "${color_title}${separator}${color_reset_title}" >&2
        ;;
    esac
}

# Operating system check function with enhanced error handling
function check_os() {
    if [ -f /etc/os-release ]; then
        if ! source /etc/os-release 2>/dev/null; then
            log error "Failed to read /etc/os-release"
            return 1
        fi

        if [ "$ID" = "ubuntu" ]; then
            case "$VERSION_ID" in
            "20.04") OS_NAME="Ubuntu 20.04" ;;
            "22.04") OS_NAME="Ubuntu 22.04" ;;
            "24.04") OS_NAME="Ubuntu 24.04" ;;
            *)
                log error "$(extract_tips "h_check_os_wrong"): Ubuntu $VERSION_ID not supported"
                return 1
                ;;
            esac
        elif [ "$ID" = "debian" ]; then
            case "$VERSION_ID" in
            "12") OS_NAME="Debian 12" ;;
            *)
                log error "$(extract_tips "h_check_os_wrong"): Debian $VERSION_ID not supported"
                return 1
                ;;
            esac
        else
            log warning "Unknown OS '$ID', defaulting to Debian 12"
            OS_NAME="Debian 12"
        fi
    else
        log error "/etc/os-release not found - cannot determine OS"
        return 1
    fi
    return 0
}

# Architecture check function
function check_arch() {
    local arch=$(uname -m)
    case "$arch" in
    "x86_64") CPU_ARCH="AMD64" ;;
    "aarch64") CPU_ARCH="ARM" ;;
    *)
        log error "$(extract_tips "h_check_arch_wrong"): $arch"
        return 1
        ;;
    esac
    return 0
}

# Root check function
function check_root() {
    if [ "$(id -u)" != "0" ]; then
        log error "$(extract_tips "h_check_root_wrong")"
        return 1
    fi
    return 0
}

# Enhanced user detection function
function get_user() {
    local user=""
    local last_login_user
    local list_users
    local error_output

    # Get last login user with error handling
    if ! error_output=$(last pts/0 -1 2>&1); then
        log warning "Failed to get last login user: $error_output"
        last_login_user=""
    else
        last_login_user=$(echo "$error_output" | awk '{print $1; exit}')
    fi

    # Get user list with error handling
    if ! list_users=($(awk -F: '($3>=1000)&&($1!="nobody"){print $1}' /etc/passwd 2>/dev/null)); then
        log error "$(extract_tips "h_get_user_error"): Failed to read /etc/passwd"
        return 1
    fi

    # Find matching user - simplified logic
    for list_user in "${list_users[@]}" "root"; do
        if [[ "$list_user" == "$last_login_user" ]]; then
            user=$list_user
            break
        fi
    done

    if [ -n "$user" ]; then
        DEFAULT_USER=$user
        if ! DEFAULT_USER_DIRECTORY=$(eval echo ~$user 2>/dev/null); then
            log error "$(extract_tips "h_get_user_error"): Cannot get home directory for $user"
            return 1
        fi
        log info "Selected user: $DEFAULT_USER (home: $DEFAULT_USER_DIRECTORY)"
    else
        log error "$(extract_tips "h_get_user_error"): Last login: '$last_login_user', Available: ${list_users[*]}"
        return 1
    fi
    return 0
}

# Enhanced download link function with better error handling
function get_mt_link() {
    local cpu_arch=$1
    local archive_from=$2
    local link=""
    local error_output exit_code

    # Input validation
    if [[ -z "$cpu_arch" || -z "$archive_from" ]]; then
        log error "Missing required parameters for get_mt_link (cpu_arch: '$cpu_arch', archive_from: '$archive_from')"
        return 1
    fi

    if [[ $archive_from == "official" ]]; then
        case "$cpu_arch" in
        "AMD64")
            link="https://cdn3.moontrader.com/beta/linux-x86_64/MoonTrader-linux-x86_64.tar.xz"
            ;;
        "ARM")
            link="https://cdn3.moontrader.com/beta/linux-arm64/MoonTrader-linux-arm64.tar.xz"
            ;;
        *)
            log error "$(extract_tips "h_get_mt_official_link_error"): $cpu_arch"
            return 1
            ;;
        esac
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
        log error "$(extract_tips "h_get_mt_link_error"): $archive_from"
        return 1
    fi

    # Enhanced link testing with detailed error reporting
    error_output=$(wget --spider "$link" 2>&1)
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log error "$(extract_tips "h_link_not_reachable"): $link (exit code: $exit_code)\nOutput: $error_output"
        return $exit_code
    fi

    if wget --quiet --spider "$link" 2>/dev/null; then
        echo "$link"
        return 0
    else
        log error "$(extract_tips "h_remote_file_not_found"): $link"
        return 1
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
            echo "1) [✔] $(extract_tips "h_setup_install_option_automatic")"
            echo "2) [ ] $(extract_tips "h_setup_install_option_custom")"
        else
            echo "1) [ ] $(extract_tips "h_setup_install_option_automatic")"
            echo "2) [✔] $(extract_tips "h_setup_install_option_custom")"
        fi
        echo
        log select "$(extract_tips "h_setup_install_tips")"
        read -n 1 input
        case $input in
        1) selected_option=1 ;;
        2) selected_option=2 ;;
        "") break ;;
        [Qq]) echo && log info "$(extract_tips "h_exit")" && exit 0 ;;
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
    local fail2ban_choice=1
    local guardian_choice=0

    while true; do
        clear
        log select "$(extract_tips "h_setup_custom_title")"
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
        if [[ $fail2ban_choice -eq 1 ]]; then
            echo "5) [✔] Setup Fail2Ban"
        else
            echo "5) [ ] Setup Fail2Ban"
        fi
        if [[ $guardian_choice -eq 1 ]]; then
            echo "6) [✔] Setup MT Guardian"
        else
            echo "6) [ ] Setup MT Guardian"
        fi
        echo
        log select "$(extract_tips "h_setup_install_tips")"
        read -n 1 input
        case $input in
        1) custom_link_choice=$((1 - custom_link_choice)) ;;
        2) custom_link_choice=$((1 - custom_link_choice)) ;;
        3) time_choice=$((1 - time_choice)) ;;
        4) firewall_choice=$((1 - firewall_choice)) ;;
        5) fail2ban_choice=$((1 - fail2ban_choice)) ;;
        6) guardian_choice=$((1 - guardian_choice)) ;;
        "") break ;;
        [Qq]) echo && log info "$(extract_tips "h_exit")" && exit 0 ;;
        esac
    done

    SETUP_CUSTOM_LINK=$((custom_link_choice))
    SETUP_TIME=$((time_choice))
    SETUP_FIREWALL=$((firewall_choice))
    SETUP_FAIL2BAN=$((fail2ban_choice))
    SETUP_MT_GUARDIAN=$((guardian_choice))
}

# Enhanced swap enable function
function enable_swap() {
    local error_output exit_code

    log execution "$(extract_tips "h_setup_start") Swap"
    if ! free | awk '/^Swap:/ {exit !$2}'; then
        error_output=$(fallocate -l 2G /swapfile 2>&1)
        exit_code=$?
        if [ $exit_code -ne 0 ]; then
            log error "Failed to create swap file: $error_output"
            return $exit_code
        fi

        chmod 600 /swapfile || log error "Failed to set swap file permissions"

        error_output=$(mkswap /swapfile 2>&1)
        exit_code=$?
        if [ $exit_code -ne 0 ]; then
            log error "Failed to make swap: $error_output"
            return $exit_code
        fi

        error_output=$(swapon /swapfile 2>&1)
        exit_code=$?
        if [ $exit_code -ne 0 ]; then
            log error "Failed to enable swap: $error_output"
            return $exit_code
        fi

        bash -c 'echo "/swapfile none swap sw 0 0" >>/etc/fstab'
        log success "$(extract_tips "h_setup_complete") Swap"
    else
        log success "$(extract_tips "h_setup_already") Swap"
    fi
}

# Enhanced package installation function with better error handling
install_package() {
    local package_name=$1
    local error_output exit_code

    log execution "$(extract_tips "h_install_packages_start"): $package_name"

    if dpkg -l | grep -q "^ii\s*$package_name\s"; then
        log success "$(extract_tips "h_install_packages_already"): $package_name"
        return 0
    fi

    error_output=$(DEBIAN_FRONTEND=noninteractive apt install -y "$package_name" 2>&1)
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        log success "$(extract_tips "h_install_packages_complete"): $package_name"
    else
        log error "$(extract_tips "h_package_install_error"): $package_name (exit code: $exit_code)\nOutput: $error_output"
        return $exit_code
    fi

    # Package-specific configurations with enhanced error handling
    case $package_name in
    "libtommath1")
        configure_libtommath || {
            log error "Configuration failed for $package_name"
            return 1
        }
        ;;
    "fail2ban")
        configure_fail2ban || {
            log error "Configuration failed for $package_name"
            return 1
        }
        ;;
    esac
    return 0
}

# Separate configuration function for libtommath
configure_libtommath() {
    local lib_path
    local target_link

    if [ "$CPU_ARCH" == "AMD64" ]; then
        lib_path="/usr/lib/x86_64-linux-gnu"
    elif [ "$CPU_ARCH" == "ARM" ]; then
        lib_path="/usr/lib/aarch64-linux-gnu"
    else
        log error "Unknown CPU architecture: $CPU_ARCH"
        return 1
    fi

    target_link="$lib_path/libtommath.so.0"

    if [ -f "$target_link" ]; then
        if ! rm "$target_link" 2>/dev/null; then
            log error "Failed to remove existing symlink $target_link"
            return 1
        fi
    fi

    if ! ln -s libtommath.so.1 "$target_link" 2>/dev/null; then
        log error "Failed to create symlink $target_link"
        return 1
    fi

    return 0
}

# Separate configuration function for fail2ban
configure_fail2ban() {
    local jail_config="/etc/fail2ban/jail.local"
    local error_output exit_code

    log execution "$(extract_tips "h_install_packages_configure_start"): fail2ban"

    if ! touch "$jail_config" 2>/dev/null; then
        log error "Failed to create $jail_config"
        return 1
    fi

    local fail2ban_jail_config_lines=(
        "[sshd]",
        "port = ssh",
        "findtime = 3600",
        "maxretry = 3",
        "bantime = 86400"
    )

    # Write configuration to jail.local
    if ! printf "%s\n" "${fail2ban_jail_config_lines[@]}" >"$jail_config" 2>/dev/null; then
        log error "Failed to write to $jail_config"
        return 1
    fi

    error_output=$(systemctl enable fail2ban 2>&1)
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log error "$(extract_tips "h_service_enable_error"): fail2ban (exit code: $exit_code)\nOutput: $error_output"
        return $exit_code
    fi

    error_output=$(systemctl restart fail2ban 2>&1)
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log error "$(extract_tips "h_service_restart_error"): fail2ban (exit code: $exit_code)\nOutput: $error_output"
        return $exit_code
    fi

    log success "$(extract_tips "h_install_packages_configure_complete"): fail2ban"
    return 0
}

# Enhanced package update function
function update_packages() {
    local error_output exit_code

    log execution "$(extract_tips "h_update_packages_title")..."

    error_output=$(apt update 2>&1)
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log error "$(extract_tips "h_update_packages_error"): Update failed (exit code: $exit_code)\nOutput: $error_output"
        return $exit_code
    fi

    error_output=$(DEBIAN_FRONTEND=noninteractive apt upgrade -y 2>&1)
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log error "$(extract_tips "h_update_packages_error"): Upgrade failed (exit code: $exit_code)\nOutput: $error_output"
        return $exit_code
    fi

    log success "$(extract_tips "h_update_packages_complete")"
    return 0
}

# Enhanced package removal function
function remove_packages() {
    local rm_pkgs=(snapd exim exim4)
    local error_output exit_code

    for pkg in "${rm_pkgs[@]}"; do
        log execution "$(extract_tips "h_remove_packages_start"): $pkg"
        if dpkg -s "$pkg" >/dev/null 2>&1; then
            if [ "$pkg" == "snapd" ]; then
                error_output=$(apt -yqq remove "$pkg" --purge 2>&1)
                exit_code=$?
                if [ $exit_code -ne 0 ]; then
                    log error "$(extract_tips "h_package_remove_error"): $pkg (exit code: $exit_code)\nOutput: $error_output"
                    continue
                fi
                rm -rf ~/snap /var/snap /var/lib/snapd 2>/dev/null
            else
                error_output=$(apt -yqq remove "$pkg" 2>&1)
                exit_code=$?
                if [ $exit_code -ne 0 ]; then
                    log error "$(extract_tips "h_package_remove_error"): $pkg (exit code: $exit_code)\nOutput: $error_output"
                    continue
                fi
            fi
            log success "$(extract_tips "h_remove_packages_complete"): $pkg"
        else
            log success "$(extract_tips "h_remove_packages_already"): $pkg"
        fi
    done

    error_output=$(apt autoremove -y 2>&1)
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log warning "Failed to autoremove packages: $error_output"
    fi
}

# Enhanced firewall setup function
function setup_firewall() {
    local error_output exit_code
    local rules=(
        "iptables -F"
        "iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT"
        "iptables -A INPUT -m state --state INVALID -j DROP"
        "iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT"
        "iptables -A INPUT -p udp --dport 4242 -j ACCEPT"
        "iptables -A INPUT -p tcp --dport ssh -j ACCEPT"
        "iptables -A INPUT -i lo -j ACCEPT"
        "iptables -A INPUT -j DROP"
    )

    log execution "$(extract_tips "h_setup_firewall_execute")"

    if ! iptables -nL | grep 4242 >/dev/null 2>&1; then
        for rule in "${rules[@]}"; do
            error_output=$(eval "$rule" 2>&1)
            exit_code=$?
            if [ $exit_code -ne 0 ]; then
                log error "$(extract_tips "h_firewall_rule_error"): '$rule' (exit code: $exit_code)\nOutput: $error_output"
                return $exit_code
            fi
        done

        error_output=$(netfilter-persistent save 2>&1)
        exit_code=$?
        if [ $exit_code -ne 0 ]; then
            log error "Failed to save firewall rules (exit code: $exit_code)\nOutput: $error_output"
            return $exit_code
        fi

        log success "$(extract_tips "h_setup_firewall_complete"): Ping,SSH,4242udp"
    else
        log success "$(extract_tips "h_setup_firewall_already"): Ping,SSH,4242udp"
    fi
}

# Enhanced MoonTrader installation function
function install_mt() {
    local user=$1
    local user_home=$2
    local link=$3
    local folder="$user_home/moontrader"
    local error_output exit_code

    log execution "$(extract_tips "h_install_mt_execute")"

    # If the folder exists, remove it and create a new one
    if [ -d "$folder" ]; then
        if ! rm -rf "$folder"; then
            log error "Failed to remove existing folder $folder"
            return 1
        fi
    fi

    if ! mkdir -p "$folder"; then
        log error "Failed to create directory $folder"
        return 1
    fi

    # Download the installation archive and extract it
    if [ ! -f "$folder/MTCore" ]; then
        error_output=$(wget -O MoonTrader.tar.xz "$link" 2>&1)
        exit_code=$?
        if [ $exit_code -ne 0 ]; then
            log error "$(extract_tips "h_download_error"): $link (exit code: $exit_code)\nOutput: $error_output"
            return $exit_code
        fi

        error_output=$(tar -xpJf MoonTrader.tar.xz -C "$folder" 2>&1)
        exit_code=$?
        if [ $exit_code -ne 0 ]; then
            log error "$(extract_tips "h_extract_error"): MoonTrader.tar.xz (exit code: $exit_code)\nOutput: $error_output"
            return $exit_code
        fi

        rm MoonTrader.tar.xz
    fi

    # Create a startup script and a quick launch link
    if [ -f "$folder/MTCore" ] && [ ! -f "$folder/start_mt.sh" ]; then
        if ! chmod +x "$folder/MTCore"; then
            log error "Failed to make MTCore executable"
            return 1
        fi

        if ! touch "$folder/start_mt.sh"; then
            log error "Failed to create startup script"
            return 1
        fi

        chmod +x "$folder/start_mt.sh"

        # Create startup script with proper variable expansion
        local script_lines=(
            '#!/bin/bash'
            ''
            "MTCORE_PATH=\"$folder/MTCore\""
            'TMUX_SESSION_NAME="mt"'
            'TMUX_WINDOW_NAME="MTCore"'
            ''
            '# Function to check if tmux session exists'
            'tmux_session_exists() {'
            '    tmux has-session -t "$TMUX_SESSION_NAME" 2>/dev/null'
            '}'
            ''
            '# Function to create tmux session'
            'create_tmux_session() {'
            '    echo "Creating tmux session: $TMUX_SESSION_NAME"'
            '    tmux new-session -d -s "$TMUX_SESSION_NAME" -n "$TMUX_WINDOW_NAME" -c "$(dirname "$MTCORE_PATH")"'
            '}'
            ''
            '# Function to check if we are inside tmux'
            'is_inside_tmux() {'
            '    [ -n "$TMUX" ]'
            '}'
            ''
            '# Function to check if we are inside the MT tmux session'
            'is_inside_mt_tmux() {'
            '    [ -n "$TMUX" ] && [ "$(tmux display-message -p '\''#S'\'')" = "$TMUX_SESSION_NAME" ]'
            '}'
            ''
            '# Function to start MTCore directly (when inside tmux)'
            'start_mtcore_direct() {'
            '    local args="$1"'
            '    echo "Starting MTCore directly in current tmux session..."'
            '    '
            '    # Change to MTCore directory'
            '    cd "$(dirname "$MTCORE_PATH")" || {'
            '        echo "Failed to change to MTCore directory"'
            '        return 1'
            '    }'
            '    '
            '    # Start MTCore with or without arguments'
            '    if [ -n "$args" ]; then'
            '        exec "$MTCORE_PATH" $args'
            '    else'
            '        exec "$MTCORE_PATH"'
            '    fi'
            '}'
            ''
            '# Function to start MTCore in tmux'
            'start_mtcore_in_tmux() {'
            '    local args="$1"'
            '    echo "Starting MTCore in tmux session..."'
            '    tmux send-keys -t "$TMUX_SESSION_NAME:$TMUX_WINDOW_NAME" C-c 2>/dev/null'
            '    sleep 1'
            '    tmux send-keys -t "$TMUX_SESSION_NAME:$TMUX_WINDOW_NAME" "cd $(dirname "$MTCORE_PATH")" Enter'
            '    sleep 1'
            '    if [ -n "$args" ]; then'
            '        tmux send-keys -t "$TMUX_SESSION_NAME:$TMUX_WINDOW_NAME" "\"$MTCORE_PATH\" $args" Enter'
            '    else'
            '        tmux send-keys -t "$TMUX_SESSION_NAME:$TMUX_WINDOW_NAME" "\"$MTCORE_PATH\"" Enter'
            '    fi'
            '}'
            ''
            '# Function to check if MTCore is running'
            'is_mtcore_running() {'
            '    pidof MTCore >/dev/null 2>&1'
            '}'
            ''
            '# Function to stop MTCore (gracefully, no force kill)'
            'stop_mtcore() {'
            '    local mtcore_pids=($(pidof MTCore))'
            '    if [ ${#mtcore_pids[@]} -gt 0 ]; then'
            '        echo "Stopping MTCore processes: ${mtcore_pids[*]}"'
            '        killall MTCore'
            '        echo "Waiting for MTCore to exit gracefully..."'
            '        # Wait for process to terminate gracefully'
            '        while is_mtcore_running; do'
            '            sleep 2'
            '            echo "Still waiting for MTCore to exit..."'
            '        done'
            '        echo "MTCore stopped successfully"'
            '    else'
            '        echo "No MTCore processes running"'
            '    fi'
            '}'
            ''
            '# Function to show MTCore status'
            'show_status() {'
            '    echo "=== MTCore Status ==="'
            '    if is_mtcore_running; then'
            '        local mtcore_pids=($(pidof MTCore))'
            '        echo "MTCore is running with PID(s): ${mtcore_pids[*]}"'
            '    else'
            '        echo "MTCore is not running"'
            '    fi'
            '    echo'
            '    echo "=== Tmux Session Status ==="'
            '    if tmux_session_exists; then'
            '        echo "Tmux session '\''$TMUX_SESSION_NAME'\'' exists"'
            '        echo "To attach: MoonTrader --attach"'
            '    else'
            '        echo "Tmux session '\''$TMUX_SESSION_NAME'\'' does not exist"'
            '    fi'
            '}'
            ''
            '# Function to show help'
            'show_help() {'
            '    echo "Usage: $(basename "$0") [OPTION]"'
            '    echo "Start MoonTrader MTCore in tmux session"'
            '    echo'
            '    echo "Options:"'
            '    echo "  (no args)     Start MTCore normally in tmux and attach"'
            '    echo "  --no-update   Start MTCore with --no-update flag in tmux and attach"'
            '    echo "  --stop        Stop all MTCore processes gracefully"'
            '    echo "  --status      Show MTCore and tmux session status"'
            '    echo "  --attach      Attach to tmux session (if exists)"'
            '    echo "  --help        Show this help message"'
            '    echo'
            '    echo "Tmux commands:"'
            '    echo "  MoonTrader --attach                  # Attach to session"'
            '    echo "  Ctrl+B, then D                      # Detach from session"'
            '}'
            ''
            '# Function to wait for MTCore to start'
            'wait_for_mtcore_start() {'
            '    local timeout=30'
            '    local count=0'
            '    echo "Waiting for MTCore to start..."'
            '    while [ $count -lt $timeout ]; do'
            '        if is_mtcore_running; then'
            '            echo "MTCore started successfully"'
            '            return 0'
            '        fi'
            '        sleep 1'
            '        ((count++))'
            '    done'
            '    echo "Timeout waiting for MTCore to start"'
            '    return 1'
            '}'
            ''
            '# Function to handle tmux attachment based on context'
            'handle_tmux_attachment() {'
            '    if is_inside_tmux; then'
            '        echo "You are already inside tmux"'
            '        if [ "$TMUX_SESSION_NAME" = "$(tmux display-message -p '\''#S'\'')" ]; then'
            '            echo "You are already in the MTCore session '\''$TMUX_SESSION_NAME'\''"'
            '            echo "Switching to MTCore window..."'
            '            tmux select-window -t "$TMUX_WINDOW_NAME" 2>/dev/null'
            '        else'
            '            echo "Switching to MTCore session..."'
            '            tmux switch-client -t "$TMUX_SESSION_NAME"'
            '        fi'
            '    else'
            '        echo "Attaching to tmux session..."'
            '        sleep 2'
            '        exec tmux attach -t "$TMUX_SESSION_NAME"'
            '    fi'
            '}'
            ''
            '# Main script logic'
            'case "$1" in'
            '    "--no-update")'
            '        # Check if user is inside the MT tmux session'
            '        if is_inside_mt_tmux; then'
            '            echo "You are inside the MTCore tmux session '\''$TMUX_SESSION_NAME'\''"'
            '            echo "Starting MTCore directly with --no-update..."'
            '            start_mtcore_direct "--no-update"'
            '            exit 0'
            '        fi'
            '        '
            '        # Check if user is inside any other tmux session'
            '        if is_inside_tmux; then'
            '            echo "Warning: You are inside a different tmux session: $(tmux display-message -p '\''#S'\'')"'
            '            echo "MTCore should run in its dedicated tmux session '\''$TMUX_SESSION_NAME'\''"'
            '            echo "Options:"'
            '            echo "  1. Switch to MTCore session: tmux switch-client -t $TMUX_SESSION_NAME"'
            '            echo "  2. Detach and run MoonTrader: Ctrl+B, then D, then run MoonTrader --no-update"'
            '            echo "  3. Start MTCore directly here (not recommended)"'
            '            read -p "Start MTCore in current session anyway? (y/n): " -n 1 choice'
            '            echo'
            '            if [[ $choice =~ ^[Yy]$ ]]; then'
            '                start_mtcore_direct "--no-update"'
            '            fi'
            '            exit 0'
            '        fi'
            '        '
            '        if is_mtcore_running; then'
            '            echo "MTCore is already running. Use --stop to stop it first."'
            '            show_status'
            '            exit 1'
            '        fi'
            '        if ! tmux_session_exists; then'
            '            create_tmux_session'
            '            if [ $? -ne 0 ]; then'
            '                echo "Failed to create tmux session"'
            '                exit 1'
            '            fi'
            '        fi'
            '        start_mtcore_in_tmux "--no-update"'
            '        echo "MTCore started with --no-update in tmux session '\''$TMUX_SESSION_NAME'\''"'
            '        if wait_for_mtcore_start; then'
            '            handle_tmux_attachment'
            '        else'
            '            echo "MTCore may not have started properly."'
            '            echo "Check with: MoonTrader --status"'
            '            echo "Or attach to see console: MoonTrader --attach"'
            '            exit 1'
            '        fi'
            '        ;;'
            '    "--stop")'
            '        stop_mtcore'
            '        ;;'
            '    "--status")'
            '        show_status'
            '        ;;'
            '    "--attach")'
            '        if tmux_session_exists; then'
            '            if is_inside_tmux; then'
            '                echo "You are already inside tmux"'
            '                if [ "$TMUX_SESSION_NAME" = "$(tmux display-message -p '\''#S'\'')" ]; then'
            '                    echo "You are already in the MTCore session '\''$TMUX_SESSION_NAME'\''"'
            '                    echo "Switching to MTCore window..."'
            '                    tmux select-window -t "$TMUX_WINDOW_NAME" 2>/dev/null'
            '                else'
            '                    echo "Switching to MTCore session..."'
            '                    tmux switch-client -t "$TMUX_SESSION_NAME"'
            '                fi'
            '            else'
            '                exec tmux attach -t "$TMUX_SESSION_NAME"'
            '            fi'
            '        else'
            '            echo "Tmux session '\''$TMUX_SESSION_NAME'\'' does not exist"'
            '            echo "Start MTCore first to create the session"'
            '            exit 1'
            '        fi'
            '        ;;'
            '    "--help")'
            '        show_help'
            '        ;;'
            '    "")'
            '        # Check if user is inside the MT tmux session'
            '        if is_inside_mt_tmux; then'
            '            echo "You are inside the MTCore tmux session '\''$TMUX_SESSION_NAME'\''"'
            '            echo "Starting MTCore directly..."'
            '            start_mtcore_direct'
            '            exit 0'
            '        fi'
            '        '
            '        # Check if user is inside any other tmux session'
            '        if is_inside_tmux; then'
            '            echo "Warning: You are inside a different tmux session: $(tmux display-message -p '\''#S'\'')"'
            '            echo "MTCore should run in its dedicated tmux session '\''$TMUX_SESSION_NAME'\''"'
            '            echo "Options:"'
            '            echo "  1. Switch to MTCore session: tmux switch-client -t $TMUX_SESSION_NAME"'
            '            echo "  2. Detach and run MoonTrader: Ctrl+B, then D, then run MoonTrader"'
            '            echo "  3. Start MTCore directly here (not recommended)"'
            '            read -p "Start MTCore in current session anyway? (y/n): " -n 1 choice'
            '            echo'
            '            if [[ $choice =~ ^[Yy]$ ]]; then'
            '                start_mtcore_direct'
            '            fi'
            '            exit 0'
            '        fi'
            '        '
            '        if is_mtcore_running; then'
            '            echo "MTCore is already running. Use --stop to stop it first."'
            '            show_status'
            '            exit 1'
            '        fi'
            '        if ! tmux_session_exists; then'
            '            create_tmux_session'
            '            if [ $? -ne 0 ]; then'
            '                echo "Failed to create tmux session"'
            '                exit 1'
            '            fi'
            '        fi'
            '        start_mtcore_in_tmux'
            '        echo "MTCore started in tmux session '\''$TMUX_SESSION_NAME'\''"'
            '        if wait_for_mtcore_start; then'
            '            handle_tmux_attachment'
            '        else'
            '            echo "MTCore may not have started properly."'
            '            echo "Check with: MoonTrader --status"'
            '            echo "Or attach to see console: MoonTrader --attach"'
            '            exit 1'
            '        fi'
            '        ;;'
            '    *)'
            '        echo "Unknown option: $1"'
            '        show_help'
            '        exit 1'
            '        ;;'
            'esac'
        )

        # Write script lines to file
        if ! printf '%s\n' "${script_lines[@]}" >"$folder/start_mt.sh"; then
            log error "Failed to write startup script"
            return 1
        fi

        if [ -f "/usr/bin/MoonTrader" ]; then
            rm /usr/bin/MoonTrader
        fi

        if ! ln -s "$folder/start_mt.sh" /usr/bin/MoonTrader; then
            log error "Failed to create MoonTrader symlink"
            return 1
        fi
    fi

    # Change ownership of the folder to the specified user
    error_output=$(chown -R "$user:$user" "$folder" 2>&1)
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log error "$(extract_tips "h_chown_error"): $folder to $user (exit code: $exit_code)\nOutput: $error_output"
        return $exit_code
    fi

    log success "$(extract_tips "h_install_mt_complete")"
    return 0
}

# Enhanced time setup function
function setup_time() {
    local error_output exit_code

    log execution "$(extract_tips "h_install_packages_configure_start"): chrony"

    if ! timedatectl set-timezone Etc/UTC; then
        log warning "Failed to set timezone to UTC"
    fi

    # Enable and start the chronyd service
    error_output=$(systemctl enable chrony 2>&1)
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log error "$(extract_tips "h_service_enable_error"): chrony (exit code: $exit_code)\nOutput: $error_output"
        return $exit_code
    fi

    # Configure the chrony service
    local chrony_config_lines=(
        '# Start of chrony configuration'
        'server 0.pool.ntp.org iburst'
        'server 1.pool.ntp.org iburst'
        'server 2.pool.ntp.org iburst'
        'server 3.pool.ntp.org iburst'
        'pool time.aws.com iburst'
        'minsources 2'
        'maxchange 1000 0 0'
        'makestep 0.1 1'
        'maxdrift 500'
        'maxslewrate 500'
        'driftfile /var/lib/chrony/drift'
        'rtcsync'
    )

    # Write chrony configuration to file
    if ! printf '%s\n' "${chrony_config_lines[@]}" >/etc/chrony/chrony.conf; then
        log error "Failed to write chrony configuration"
        return 1
    fi

    # Configure time sync for AWS EC2 if applicable
    if [[ $(dmidecode --string system-uuid 2>/dev/null) =~ ^[Ee][Cc]2 ]]; then
        sed -i '2i server 169.254.169.123 prefer iburst minpoll 4 maxpoll 4' /etc/chrony/chrony.conf
    fi

    error_output=$(systemctl restart chronyd 2>&1)
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log error "$(extract_tips "h_service_restart_error"): chronyd (exit code: $exit_code)\nOutput: $error_output"
        return $exit_code
    fi

    log success "$(extract_tips "h_install_packages_configure_complete"): chrony"
    return 0
}

# Enhanced MT Guardian setup function using automatic installer
function setup_mtguardian() {
    local error_output exit_code
    local mtg_temp_dir="/tmp/mtguardian_install"
    local service_name="mtguardian"

    log execution "$(extract_tips "h_install_packages_start"): MT Guardian"

    # Полная очистка старой установки MTGuardian
    log execution "Checking for existing MTGuardian installation..."
    
    # 1. Остановка и удаление systemd службы если существует
    if systemctl list-unit-files | grep -q "^${service_name}.service"; then
        log execution "Found existing MTGuardian systemd service, removing..."
        
        # Остановка службы если запущена
        if systemctl is-active --quiet "$service_name"; then
            log execution "Stopping MTGuardian service..."
            systemctl stop "$service_name" 2>/dev/null || log warning "Failed to stop service, continuing..."
        fi
        
        # Отключение автозапуска
        if systemctl is-enabled --quiet "$service_name" 2>/dev/null; then
            log execution "Disabling MTGuardian service..."
            systemctl disable "$service_name" 2>/dev/null || log warning "Failed to disable service, continuing..."
        fi
        
        # Удаление service файла
        if [ -f "/etc/systemd/system/${service_name}.service" ]; then
            rm -f "/etc/systemd/system/${service_name}.service"
            systemctl daemon-reload
            log success "Old MTGuardian systemd service removed"
        fi
    else
        log info "No existing MTGuardian systemd service found"
    fi
    
    # 2. Остановка процессов MTGuardian если запущены
    if pgrep -f "MTGuardian" >/dev/null 2>&1; then
        log execution "Stopping MTGuardian processes..."
        pkill -TERM -f "MTGuardian" 2>/dev/null || true
        sleep 2
        # Принудительная остановка если все еще работает
        if pgrep -f "MTGuardian" >/dev/null 2>&1; then
            pkill -KILL -f "MTGuardian" 2>/dev/null || true
        fi
        log success "MTGuardian processes stopped"
    fi
    
    # 3. Проверка и очистка старой установки через rc.local (если была)
    if [ -f "/etc/rc.local" ] && grep -q "MTGuardian" /etc/rc.local 2>/dev/null; then
        log execution "Found old MTGuardian installation (rc.local method)..."
        log info "Old installation method detected, will be cleaned up"
        
        # Удаляем записи MTGuardian из rc.local
        if grep -q "MTGuardian\|mt-service" /etc/rc.local 2>/dev/null; then
            cp /etc/rc.local "/etc/rc.local.backup.$(date +%Y%m%d_%H%M%S)" 2>/dev/null || true
            sed -i '/MTGuardian/d; /mt-service/d; /screen.*Binance/d' /etc/rc.local 2>/dev/null || true
            log success "Old MTGuardian entries removed from rc.local"
        fi
    fi
    
    # 4. Остановка старых screen сессий если есть
    if command -v screen &> /dev/null; then
        old_user="mt-service"
        if id "$old_user" &>/dev/null 2>&1; then
            if su - "$old_user" -c "screen -ls" 2>/dev/null | grep -q "Binance"; then
                log execution "Stopping old screen session..."
                su - "$old_user" -c "screen -S Binance -X quit" 2>/dev/null || true
                log success "Old screen session stopped"
            fi
        fi
    fi
    
    # 5. Удаление существующей директории MTGuardian
    if [ -d "$DEFAULT_USER_DIRECTORY/MTGuardian" ]; then
        log execution "Removing old MTGuardian directory..."
        if ! rm -rf "$DEFAULT_USER_DIRECTORY/MTGuardian"; then
            log error "Failed to remove existing MTGuardian directory"
            return 1
        fi
        log success "Old MTGuardian directory removed"
    fi
    
    log success "Cleanup completed, ready for fresh installation"

    # Определение пути к установщику для поиска локальной версии MTGuardian
    local installer_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
    local local_mtg_source=""
    
    # Проверка возможных локаций MTGuardian (для разработки через SFTP)
    local possible_paths=(
        "/home/$DEFAULT_USER/mtguardianinstall"          # путь путь для SFTP разработки
        "$installer_dir/../../MTGuardian"                # ../MTGuardian относительно Linux/install.sh
        "$installer_dir/../MTGuardian"                   # рядом с папкой Linux
    )
    
    # Поиск локальной версии MTGuardian
    log execution "Checking for local MTGuardian source..."
    for path in "${possible_paths[@]}"; do
        if [ -d "$path" ] && [ -f "$path/MTGuardian" ] && [ -f "$path/MTGuardian.settings" ]; then
            local_mtg_source="$(cd "$path" && pwd)"  # Получаем абсолютный путь
            log success "Found local MTGuardian source at: $local_mtg_source"
            break
        fi
    done
    
    # Получение исходников MTGuardian (локально или из репозитория)
    if [ -n "$local_mtg_source" ]; then
        # Использование локальной версии (для разработки)
        log execution "Using local MTGuardian source for installation..."
        log info "This is useful for testing local changes before pushing to repository"
        log info "Source: $local_mtg_source"
        log info "Destination: $DEFAULT_USER_DIRECTORY/MTGuardian"
        
        if ! cp -r "$local_mtg_source" "$DEFAULT_USER_DIRECTORY/MTGuardian"; then
            log error "Failed to copy local MTGuardian to $DEFAULT_USER_DIRECTORY"
            return 1
        fi
        
        log success "Local MTGuardian copied successfully to $DEFAULT_USER_DIRECTORY/MTGuardian"
    else
        # Клонирование из репозитория (production)
        log execution "No local MTGuardian found, cloning from repository..."
        
        # Создание временной директории

        if [ -d "$mtg_temp_dir" ]; then
            rm -rf "$mtg_temp_dir"
        fi
        mkdir -p "$mtg_temp_dir"
        
        error_output=$(git clone https://github.com/SlippingForest/MTGuardian "$mtg_temp_dir" 2>&1)
        exit_code=$?
        if [ $exit_code -ne 0 ]; then
            log error "Failed to clone MTGuardian repository (exit code: $exit_code)\nOutput: $error_output"
            rm -rf "$mtg_temp_dir"
            return $exit_code
        fi
        
        # Перемещение в конечную директорию
        log info "Moving MTGuardian to: $DEFAULT_USER_DIRECTORY/MTGuardian"
        if ! mv "$mtg_temp_dir" "$DEFAULT_USER_DIRECTORY/MTGuardian"; then
            log error "Failed to move MTGuardian to $DEFAULT_USER_DIRECTORY"
            rm -rf "$mtg_temp_dir"
            return 1
        fi
        
        log success "MTGuardian cloned from repository successfully to $DEFAULT_USER_DIRECTORY/MTGuardian"
    fi
    
    # Проверка что файлы действительно на месте
    if [ ! -f "$DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian" ]; then
        log error "MTGuardian script not found after installation!"
        log error "Expected location: $DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian"
        log info "Directory contents:"
        ls -la "$DEFAULT_USER_DIRECTORY/MTGuardian" 2>&1 | while read line; do log info "  $line"; done
        return 1
    fi
    
    log success "MTGuardian files verified in destination directory"

    # Установка разрешений
    if ! chmod +x "$DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian"; then
        log error "Failed to make MTGuardian executable"
        return 1
    fi

    if ! chmod +x "$DEFAULT_USER_DIRECTORY/MTGuardian/install.sh" 2>/dev/null; then
        log warning "install.sh not found or cannot be made executable"
    fi

    # Настройка конфигурационного файла MTGuardian.settings
    local settings_file="$DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian.settings"

    if [ ! -f "$settings_file" ]; then
        log error "MTGuardian settings file not found: $settings_file"
        return 1
    fi

    log execution "Configuring MTGuardian settings..."

    # Обновление путей в конфигурации
    if ! sed -i "s|MT_CORE_DIR=.*|MT_CORE_DIR=$DEFAULT_USER_DIRECTORY/moontrader|" "$settings_file"; then
        log error "Failed to update MT_CORE_DIR in settings"
        return 1
    fi

    if ! sed -i "s|MT_DEFAULT_PROFILE_CONFIG=.*|MT_DEFAULT_PROFILE_CONFIG=$DEFAULT_USER_DIRECTORY/.config/moontrader-data/data/default.profile|" "$settings_file"; then
        log error "Failed to update MT_DEFAULT_PROFILE_CONFIG in settings"
        return 1
    fi

    # Запрос данных у пользователя для конфигурации
    local G_SERVER_NAME TELEGRAM_BOT_TOKEN TELEGRAM_CHAT_ID

    echo
    log select "Enter MTGuardian configuration parameters:"
    echo

    while [[ -z "$G_SERVER_NAME" ]]; do
        read -p "Enter server name for MT Guardian: " G_SERVER_NAME
        if [[ -z "$G_SERVER_NAME" ]]; then
            log warning "Server name cannot be empty"
        fi
    done

    while [[ -z "$TELEGRAM_BOT_TOKEN" ]]; do
        read -p "Enter your Telegram bot token: " TELEGRAM_BOT_TOKEN
        if [[ -z "$TELEGRAM_BOT_TOKEN" ]]; then
            log warning "Telegram bot token cannot be empty"
        fi
    done

    while [[ -z "$TELEGRAM_CHAT_ID" ]]; do
        read -p "Enter your Telegram chat ID: " TELEGRAM_CHAT_ID
        if [[ -z "$TELEGRAM_CHAT_ID" ]]; then
            log warning "Telegram chat ID cannot be empty"
        fi
    done

    # Обновление конфигурации с введенными данными
    if ! sed -i "s|MT_CORE_SERVER_NAME=.*|MT_CORE_SERVER_NAME='$G_SERVER_NAME'|" "$settings_file"; then
        log error "Failed to update MT_CORE_SERVER_NAME in settings"
        return 1
    fi

    if ! sed -i "s|TG_API_TOKEN=.*|TG_API_TOKEN=$TELEGRAM_BOT_TOKEN|" "$settings_file"; then
        log error "Failed to update TG_API_TOKEN in settings"
        return 1
    fi

    if ! sed -i "s|TG_CHAT_ID=.*|TG_CHAT_ID='$TELEGRAM_CHAT_ID'|" "$settings_file"; then
        log error "Failed to update TG_CHAT_ID in settings"
        return 1
    fi

    log success "MTGuardian settings configured successfully"

    # Запуск автоматического установщика MTGuardian
    log execution "Running MTGuardian automatic installer..."
    
    local installer_script="$DEFAULT_USER_DIRECTORY/MTGuardian/install.sh"
    
    if [ -f "$installer_script" ]; then
        # Запуск установщика от имени root, но с передачей информации о пользователе
        # SUDO_USER используется установщиком для определения пользователя службы
        export SUDO_USER="$DEFAULT_USER"
        
        echo
        log info "Installation will use MTGuardian automatic installer..."
        log info "Configuration already set in MTGuardian.settings"
        echo
        
        # Запуск установщика с выводом в реальном времени
        # Установщик автоматически использует настройки из MTGuardian.settings
        # и SUDO_USER для определения пользователя
        if bash "$installer_script"; then
            log success "MTGuardian automatic installation completed successfully"
        else
            exit_code=$?
            
            # Проверяем, создана ли служба (может быть создана, но не запущена при первой установке)
            if systemctl list-unit-files | grep -q "^mtguardian.service"; then
                log info "MTGuardian installer exited with code: $exit_code"
                log info "However, systemd service was created successfully"
                log info "This is normal on first installation - MTGuardian waits for MTCore first run"
                log success "MTGuardian service created and will start automatically after first MTCore launch"
            else
                log warning "MTGuardian installer exited with code: $exit_code"
                log warning "Service not found, falling back to manual service creation..."
                
                # Если служба действительно не создана, создаем её вручную
                if ! create_mtguardian_service; then
                    log error "Failed to create MTGuardian systemd service"
                    return 1
                fi
            fi
        fi
    else
        log warning "MTGuardian installer script not found, creating service manually..."
        
        # Создание systemd службы вручную
        if ! create_mtguardian_service; then
            log error "Failed to create MTGuardian systemd service"
            return 1
        fi
    fi

    # Установка владельца директории MTGuardian
    if ! chown -R "$DEFAULT_USER:$DEFAULT_USER" "$DEFAULT_USER_DIRECTORY/MTGuardian"; then
        log error "Failed to set ownership of MTGuardian directory"
        return 1
    fi

    log success "$(extract_tips "h_install_packages_complete"): MT Guardian"
    return 0
}

# Function to create MTGuardian systemd service
create_mtguardian_service() {
    local service_file="/etc/systemd/system/mtguardian.service"
    local mtg_dir="$DEFAULT_USER_DIRECTORY/MTGuardian"
    local mtg_script="$mtg_dir/MTGuardian"
    
    # Проверка существования файлов перед созданием службы
    log execution "Verifying MTGuardian installation before creating service..."
    
    if [ ! -d "$mtg_dir" ]; then
        log error "MTGuardian directory not found: $mtg_dir"
        log error "Cannot create systemd service without MTGuardian files"
        return 1
    fi
    
    if [ ! -f "$mtg_script" ]; then
        log error "MTGuardian script not found: $mtg_script"
        log error "Directory exists but script is missing"
        log info "Directory contents:"
        ls -la "$mtg_dir" 2>&1 | while read line; do log info "  $line"; done
        return 1
    fi
    
    # Убедимся, что скрипт исполняемый
    if [ ! -x "$mtg_script" ]; then
        log execution "Making MTGuardian script executable..."
        chmod +x "$mtg_script"
    fi
    
    log success "MTGuardian files verified at: $mtg_dir"
    
    local service_content=(
        '[Unit]'
        'Description=MT Guardian Service with tmux support'
        'After=network.target'
        'Wants=network.target'
        ''
        '[Service]'
        'Type=simple'
        "User=$DEFAULT_USER"
        "Group=$(id -gn $DEFAULT_USER)"
        "WorkingDirectory=$mtg_dir"
        "ExecStart=$mtg_script"
        "ExecStop=/bin/kill -TERM \$MAINPID"
        'Restart=always'
        'RestartSec=30'
        'StandardOutput=journal'
        'StandardError=journal'
        'SyslogIdentifier=mtguardian'
        'KillMode=mixed'
        'TimeoutStopSec=60'
        'Environment=TERM=screen-256color'
        "Environment=HOME=$DEFAULT_USER_DIRECTORY"
        ''
        '[Install]'
        'WantedBy=multi-user.target'
    )

    log execution "Creating MTGuardian systemd service..."
    log info "Service configuration:"
    log info "  User: $DEFAULT_USER"
    log info "  Working Directory: $mtg_dir"
    log info "  Executable: $mtg_script"

    if ! printf '%s\n' "${service_content[@]}" >"$service_file"; then
        log error "Failed to create systemd service file: $service_file"
        return 1
    fi

    # Set proper permissions for service file
    if ! chmod 644 "$service_file"; then
        log error "Failed to set permissions for service file"
        return 1
    fi

    # Reload systemd daemon
    if ! systemctl daemon-reload; then
        log error "Failed to reload systemd daemon"
        return 1
    fi

    # Enable the service
    if ! systemctl enable mtguardian.service; then
        log error "Failed to enable MTGuardian service"
        return 1
    fi

    log success "MTGuardian systemd service created and enabled"
    log info "Service will start automatically on boot"
    log info "MTCore will run in tmux session for easy access"
    log info "Manual control: systemctl {start|stop|restart|status} mtguardian"
    log info "Access MTCore console: MoonTrader --attach"
    log info "List tmux sessions: tmux list-sessions"
    log info "Detach from tmux: Ctrl+B, then D"

    return 0
}

# Enhanced main execution with comprehensive error checking
main() {
    # Set error handling
    set -o pipefail

    # Language selection
    select_language || {
        log error "Language selection failed"
        exit 1
    }

    # System checks
    check_root || {
        log error "Root check failed"
        exit 1
    }

    check_os || {
        log error "OS check failed"
        exit 1
    }

    check_arch || {
        log error "Architecture check failed"
        exit 1
    }

    get_user || {
        log error "User detection failed"
        exit 1
    }

    # Installation option selection
    setup_install

    # Setup configuration based on installation option
    if [[ $INSTALL_OPTION -eq 1 ]]; then
        setup_automatic
    elif [[ $INSTALL_OPTION -eq 2 ]]; then
        setup_custom
    fi

    # Get the link to download MoonTrader
    if [[ $SETUP_CUSTOM_LINK -eq 0 ]]; then
        SETUP_MT_LINK=$(get_mt_link "$CPU_ARCH" "official") || {
            log error "Failed to get official MoonTrader link"
            exit 1
        }
    else
        SETUP_MT_LINK=$(get_mt_link "$CPU_ARCH" "dropbox") || {
            log error "Failed to get dropbox MoonTrader link"
            exit 1
        }
    fi

    clear
    log title "$(extract_tips "h_install_title")"

    # System preparation with error checking
    enable_swap || log warning "Swap setup failed, continuing..."

    remove_packages || log warning "Package removal had issues, continuing..."

    update_packages || {
        log error "Package update failed"
        exit 1
    }

    # Install required packages
    local required_packages=(
        "apt-transport-https"
        "dmidecode"
        "htop"
        "mc"
        "screen"
        "tmux"
        "psmisc"
        "libncurses6"
        "libtommath1"
        "p7zip-full"
        "git"
    )

    for package in "${required_packages[@]}"; do
        install_package "$package" || {
            log error "Failed to install required package: $package"
            exit 1
        }
    done

    # Optional installations with error checking
    if [[ $SETUP_TIME -eq 1 ]]; then
        install_package "chrony" || {
            log error "Failed to install chrony"
            exit 1
        }
        setup_time || {
            log error "Time setup failed"
            exit 1
        }
    fi

    if [[ $SETUP_FIREWALL -eq 1 ]]; then
        install_package "iptables-persistent" || {
            log error "Failed to install iptables-persistent"
            exit 1
        }
        setup_firewall || {
            log error "Firewall setup failed"
            exit 1
        }
    fi

    if [[ $SETUP_FAIL2BAN -eq 1 ]]; then
        install_package "fail2ban" || {
            log error "Failed to install fail2ban"
            exit 1
        }
    fi

    # Install MoonTrader FIRST (MTGuardian depends on it)
    install_mt "$DEFAULT_USER" "$DEFAULT_USER_DIRECTORY" "$SETUP_MT_LINK" || {
        log error "MoonTrader installation failed"
        exit 1
    }

    # Install MT Guardian AFTER MoonTrader
    if [[ $SETUP_MT_GUARDIAN -eq 1 ]]; then
        setup_mtguardian || {
            log error "MT Guardian setup failed"
            exit 1
        }
    fi

    # Installation complete
    log title "$(extract_tips "h_complete_install_title")"
    log info "$(extract_tips "h_complete_install_os"): $CPU_ARCH $OS_NAME"
    log info "$(extract_tips "h_complete_install_user"): $DEFAULT_USER"
    log info "$(extract_tips "h_complete_install_dir"): $DEFAULT_USER_DIRECTORY/moontrader"
    echo
    log hint "$(extract_tips "h_complete_install_start"): MoonTrader"
    log hint "$(extract_tips "h_complete_install_warning")"
    echo
    
    # MTGuardian information if installed
    if [[ $SETUP_MT_GUARDIAN -eq 1 ]]; then
        log info "MTGuardian service installed and configured:"
        log info "  - Service will monitor MTCore automatically after first launch"
        log info "  - Check service status: systemctl status mtguardian"
        log info "  - View MTGuardian logs: tail -f $DEFAULT_USER_DIRECTORY/MTGuardian/MTGuardian.log"
        log info "  - MTGuardian will send Telegram notifications on MTCore events"
        echo
    fi
    
    log warning "$(extract_tips "h_complete_install_reboot")"
    read -n 1
    reboot
}

# Execute main function
main "$@"
