#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

clear
read -p "source link: " installer_link
while ! [[ $installer_link == *"dl=0"* ]]; do
    clear
    echo "[ERROR] Wrong link"
    echo "[EXAMPLE] https://www.dropbox.com/s/.../...?dl=0"
    read -p "paste DropBox link [?dl=0]: " installer_link
done
installer_link=${installer_link%?}1

# TODO: придумать какое-то нормальное название службы
service_name="mtcore-metrics-server"

default_user=$(last pts/0 -1 | awk '{print $1; exit}')
default_user_directory=$(eval echo ~$default_user)

metrics_folder="$default_user_directory/$service_name"
metrics_executable=$metrics_folder/mtcore-metrics-server
metrics_service="$metrics_folder/$service_name.

echo $default_user
echo $metrics_folder
echo $metrics_executable
echo $metrics_service

# if [ ! -d "$metrics_folder" ]; then
#     echo "Directory $default_user_directory does not exist, create."
#     mkdir $metrics_folder

#     if [ ! -f "$metrics_executable" ]; then
#         echo "File $metrics_executable does not exists, download"
#         wget -O $metrics_executable $installer_link
#         chmod +x $metrics_executable
#     fi

#     if [ ! -f "$metrics_service" ]; then
#         touch $metrics_service
#         echo "[Unit]" >$metrics_service
#         echo "Description=MTCore metrics API" >>$metrics_service
#         echo "After=network.target" >>$metrics_service
#         echo "[Install]" >>$metrics_service
#         echo "WantedBy=multi-user.target" >>$metrics_service
#         echo "[Service]" >>$metrics_service
#         echo "Type=simple" >>$metrics_service
#         echo "ExecStart=${metrics_executable}" >>$metrics_service
#         echo "WorkingDirectory=${metrics_folder}" >>$metrics_service
#         echo "Restart=always" >>$metrics_service
#         echo "RestartSec=5" >>$metrics_service
#         echo "StandardOutput=syslog" >>$metrics_service
#         echo "StandardError=syslog" >>$metrics_service
#         echo "SyslogIdentifier=%n" >>$metrics_service

#         mv -f $metrics_service /etc/systemd/system/
#         systemctl daemon-reload
#         systemctl enable $service_name
#         systemctl start $service_name
#         systemctl status $service_name
#     fi
# else
#     echo "Directory $metrics_folder exist. Already installed"
# fi

