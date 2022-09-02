#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

service_name="mtcore-metrics.service"

default_user=$(last pts/0 -1 | awk '{print $1; exit}')
default_user_directory=$(eval echo ~$default_user)

metrics_folder="$default_user_directory/mt_metrics"
metrics_executable=$default_user_directory/mt_metrics/mtcore-metrics
metrics_service=$metrics_folder/$service_name

# echo $default_user
# echo $metrics_folder
# echo $metrics_executable
# echo $metrics_service

if dpkg -s iptables-persistent >/dev/null 2>&1; then
    if ! iptables -nL | grep 48620 >/dev/null 2>&1; then
        iptables -F
        iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
        iptables -A INPUT -m state --state INVALID -j DROP
        iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
        iptables -A INPUT -p udp --dport 4242 -j ACCEPT
        iptables -A INPUT -p tcp --dport 48620 -j ACCEPT
        iptables -A INPUT -p tcp --dport ssh -j ACCEPT
        iptables -A INPUT -i lo -j ACCEPT
        iptables -A INPUT -j DROP
        netfilter-persistent save
        echo green "Firewall allow tcp22, udp4242, tcp48620. Drop all other connections"
    else
        echo green "Security already enabled"
    fi
else
    echo "iptables-persistent not installed"
fi

if [ ! -d "$metrics_folder" ]; then
    echo "Directory $default_user_directory does not exist, create."
    mkdir $metrics_folder

    if [ ! -f "$metrics_executable" ]; then
        echo "File $metrics_executable does not exists, download"
        wget -O $metrics_executable "https://www.dropbox.com/s/knr91osy2cxzkuo/mt_metrics?dl=1"
        chmod +x $metrics_executable
    fi

    if [ ! -f "$metrics_service" ]; then
        touch $metrics_service
        echo "[Unit]" >$metrics_service
        echo "Description=MTCore metrics API" >>$metrics_service
        echo "After=network.target" >>$metrics_service
        echo "[Install]" >>$metrics_service
        echo "WantedBy=multi-user.target" >>$metrics_service
        echo "[Service]" >>$metrics_service
        echo "Type=simple" >>$metrics_service
        echo "ExecStart=${metrics_executable}" >>$metrics_service
        echo "WorkingDirectory=${metrics_folder}" >>$metrics_service
        echo "Restart=always" >>$metrics_service
        echo "RestartSec=5" >>$metrics_service
        echo "StandardOutput=syslog" >>$metrics_service
        echo "StandardError=syslog" >>$metrics_service
        echo "SyslogIdentifier=%n" >>$metrics_service

        mv -f $metrics_service /etc/systemd/system/
        systemctl daemon-reload
        systemctl enable $service_name
        systemctl start $service_name
        systemctl status $service_name
    fi
else
    echo "Directory $metrics_folder exist. Already installed"
fi
