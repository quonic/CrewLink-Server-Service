#!/bin/bash

base=/opt/crewlink-server
script=/opt/crewlink-scripts

if [ "$EUID" -ne 0 ]
  then echo "Please run as root. sudo ./add-server.sh"
  exit 1
fi

if [ $1 -gt 1024 ]
then
    if [ -d "/etc/systemd/system/crewlink-$1.service" ]
    then
        echo "/etc/systemd/system/crewlink-$1.service already exists. Pick another port."
        exit
    fi
    cp $script/crewlink.service /etc/systemd/system/crewlink-$1.service
    sed -i "s/Environment=PORT=9736/Environment=PORT=$1/" /etc/systemd/system/crewlink-$1.service
    sed -i "s/SyslogIdentifier=crewlink/SyslogIdentifier=crewlink-$1/" /etc/systemd/system/crewlink-$1.service
    systemctl enable crewlink-$1
    systemctl start crewlink-$1
    systemctl status crewlink-$1
else
    echo "Add Server will create a new CrewLink-Server instance"
    echo "on the specified port as a new service."
    echo "Usage add-server.sh <port>"
    echo " port must be greater than 1024"
fi