#!/bin/bash

opt=/opt
base=/opt/crewlink-server
script=/opt/crewlink-scripts
account=crewlink

testsstatus=1

if [ "$EUID" -ne 0 ]
  then echo "Please run as root. sudo ./setup.sh"
  exit 1
fi

# Test that setup.sh works
mkdir $script
cp ../ $script
cd $script
[ ! -d "./setup.sh" ] && exit 1
./setup.sh
if [$? -eq 0]
then
    # Setup Installed
    if [ -d "$base/setup.sh" ]
    then
        echo "$base copied"
    else
        echo "$base failed to copy"
        testsstatus=0
    fi
    if [ -d "/etc/systemd/system/crewlink-9736.service" ]
    then
        echo "crewlink-9736.service copied"
    else
        echo "crewlink-9736.service failed to copy"
        testsstatus=0
    fi
    if [ -d "/etc/systemd/system/crewlinkupdater.service" ]
    then
        echo "crewlinkupdater.service copied"
    else
        echo "crewlinkupdater.service failed to copy"
        testsstatus=0
    fi
    if [ -d "/etc/systemd/system/crewlinkupdater.timer" ]
    then
        echo "crewlinkupdater.timer copied"
    else
        echo "crewlinkupdater.timer failed to copy"
        testsstatus=0
    fi
    if (systemctl -q is-active crewlink-9736.service)
        then
        echo "crewlink-9736.service is installed and running"
    else
        echo "crewlink-9736.service is not running"
        testsstatus=0
    fi
    systemctl list-timers crewlinkupdater.timer | grep crewlinkupdater &> /dev/null
    if [ $? == 0 ]; then
        echo "crewlinkupdater.timer is installed"
    else
        echo "crewlinkupdater.timer is not installed"
        testsstatus=0
    fi
else
    echo "setup.sh failed to run"
    testsstatus=0
fi



# Clean Up after setup.sh
servicename=crewlink-*
systemctl stop $servicename
systemctl disable $servicename
rm /etc/systemd/system/$servicename
rm /etc/systemd/system/$servicename # and symlinks that might be related
rm /usr/lib/systemd/system/$servicename 
rm /usr/lib/systemd/system/$servicename # and symlinks that might be related
systemctl daemon-reload
systemctl reset-failed
npm uninstall -g yarn
apt-get -qy remove nodejs
[ -d "$script" ] && rm -rf $script
[ -d "$base" ] && rm -rf $base
deluser $account

if [ testsstatus -eq 1 ]
    then
    exit 0
else
    exit 1
fi
