
# Скрипт установки торгового терминала MoonTrader

Этот репозиторий предоставляет скрипт для установки торгового терминала MoonTrader на системах Ubuntu.

## Поддерживаемые версии
Скрипт был протестирован и проверен на следующих версиях Ubuntu:
- Ubuntu 20.04 LTS
- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS
- Debian 12

## Установка
1. Переключитесь на пользователя `root`
- Ubuntu: `sudo su` 
- Debian `su -`
2. Установите MoonTrader, выполнив следующую команду в терминале:
```bash
wget -O - https://raw.githubusercontent.com/SlippingForest/MoonTrader_install/master/Linux/install.sh | bash <(cat) </dev/tty
```
## Запуск MoonTrader с помощью tmux
Чтобы MoonTrader продолжал работать даже при отключении терминальной сессии, рекомендуется использовать `tmux`.

### Использование tmux
1. Запустите новую сессию tmux:
   ```bash
   tmux new -s moontrader
   ```
2. Внутри сессии tmux запустите MoonTrader:
   ```bash
   MoonTrader
   ```
3. Чтобы отсоединиться от сессии tmux (оставив MoonTrader работающим), нажмите `Ctrl+b`, затем `d`.
4. Чтобы снова подключиться к сессии tmux:
   ```bash
   tmux attach -t moontrader
   ```

## Остановка MoonTrader
   - Подключитесь к сессии `tmux`(4 пункт запуска), нажмите `Ctrl+c`. 
   - Бывают случаи, когда ядро не реагирует на комбинацию клавиш, тогда необходимо выполнить команду из любого места(можно не подключаясь к сессии `tmux`):
      ```bash
      MoonTrader --stop
      ```
   - Очистка профиля(для настройки как при первом запуске)
      ```bash
      rm -R ~/.config/moontrader-data/data
      ```
   - Очистка логов
      ```bash
      rm -R ~/.config/moontrader-data/data/logs/
      ```
   - Очистка архивных данных
      ```bash
      rm -R ~/.config/moontrader-data/data/archive/
      ```

## Дополнительная информация
- Запуск MoonTrader без обновления
   ```bash
   MoonTrader --no-update
   ```
---

## MTGuardian
- Для установки нужно выбрать пункт `Custom` 



Следуя этим инструкциям, вы сможете установить и запустить MoonTrader на вашей системе Ubuntu, обеспечив его непрерывную работу даже при завершении терминальной сессии. Удачной торговли!


# Пути к файлам
Каталог с ядром
```bash
cd ~/moontrader
```
Каталог с конфигом
```bash
cd ~/.config/moontrader-data/
```
Каталог с MTGuardian
```bash
cd ~/MTGuardian
```