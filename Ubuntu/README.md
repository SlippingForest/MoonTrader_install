# MoonTrader Ubuntu 20.04 LTS

Скрипт устанавливает MoonTrader, на Ubuntu 20.04 LTS
- Проверен на AWS, Vultr
  - Vultr что-то изменил в своих скриптах развертывания сервера, советую потождать минут 5 после того как сервер станет доступным, так как после доступности сервера установка продолжается(привет рукожопам из Vultr). При первом подключении сервер попросит его перезапустить```sudo reboot```, действуйте.
- Добавлена возможность установки с помощью ссылки на установочный архив размещенный на DropBox

# Важно к прочтению: 
- Для любителей открывать доступ с любого IP в FireWall - добавлена установка fail2ban, для защиты перебора паролей SSH. Три не верные попытки входа, блокировка доступа к SSH по IP на сутки.

# Установка

Залогиниться по SSH. В консоль вставить команду целиком от обычного пользователя, если просит пароль для повышения прав до root - вводим.
```bash
wget -O - https://raw.githubusercontent.com/SlippingForest/MoonTrader_install/master/Ubuntu/install.sh | bash <(cat) </dev/tty
```
после выполнения, хост перезагрузится

# Запуск

#### Настоятельно рекомендую использовать менеджер терминалов tmux(кто не знает что это, Google в помощь)

1. Создаем сессию tmux
```bash
tmux
```
2. Запуск ядра(MTCore)
```bash
MoonTrader
```
3. Если все прошло успешно, отключиться от сессии tmux сочитанием клавиш Ctrl+B D (клавишу D нажимать отдельно, без Ctrl)
4. Можно отключаться от SSH, MoonTrader продолжит работать в фоне
5. Для подключения к сессии где работает ядро(MTcore), чтоб остановить(Ctrl+C) или перезапустить
```bash
tmux attach
```
# Пути к файлам MoonTrader
Стандартные каталоги
```bash
cd ~/MoonTrader
```
Каталог с конфигом
```bash
cd ~/.config/moontrader-data/
```