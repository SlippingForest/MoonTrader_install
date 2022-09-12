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
folder_name="metrics-server"
service_name="metrics-mtcore-server"

default_user=$(last pts/0 -1 | awk '{print $1; exit}')
default_user_directory=$(eval echo ~$default_user)

metrics_folder=$default_user_directory/$service_name
metrics_executable=$metrics_folder/$service_name

metrics_service=$service_name.service
metrics_service_file=$metrics_folder/$metrics_service

echo $default_user
echo $metrics_folder
echo $metrics_executable
echo $metrics_service
echo $metrics_service_file

# создать папку
if [ ! -d "$metrics_folder" ]; then
    echo "Directory $default_user_directory does not exist, create."
    mkdir $metrics_folder
else
    echo "Directory $metrics_folder exist"
fi

# скачать бинарник
if [ ! -f "$metrics_executable" ]; then
    echo "File $metrics_executable does not exists, download"
    wget -O $metrics_executable $installer_link
    chmod +x $metrics_executable
fi

# создать службу
if [ ! -f "$metrics_service_file" ]; then
    touch $metrics_service_file
    echo "[Unit]" >$metrics_service_file
    echo "Description=MTCore metrics API" >>$metrics_service_file
    echo "After=network.target" >>$metrics_service_file
    echo "[Install]" >>$metrics_service_file
    echo "WantedBy=multi-user.target" >>$metrics_service_file
    echo "[Service]" >>$metrics_service_file
    echo "Type=simple" >>$metrics_service_file
    echo "ExecStart=${metrics_executable}" >>$metrics_service_file
    echo "WorkingDirectory=${metrics_folder}" >>$metrics_service_file
    echo "Restart=always" >>$metrics_service_file
    echo "RestartSec=5" >>$metrics_service_file
    echo "StandardOutput=syslog" >>$metrics_service_file
    echo "StandardError=syslog" >>$metrics_service_file
    echo "SyslogIdentifier=%n" >>$metrics_service_file

    mv -f $metrics_service_file /etc/systemd/system/
    systemctl daemon-reload
    systemctl enable $service_name
    systemctl start $service_name
    systemctl status $service_name
fi
