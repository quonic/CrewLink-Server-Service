#!/bin/bash

opt=/opt
base=/opt/crewlink-server
script=/opt/crewlink-scripts
account=crewlink

if [ "$EUID" -ne 0 ]
  then echo "Please run as root. sudo ./setup.sh"
  exit 1
fi

# Download node.js and git
curl -sL https://deb.nodesource.com/setup_15.x | bash -
apt-get install -y nodejs git

# Install yarn
npm install yarn -g

# Check that the directories exist and create them if they don't exist
[ ! -d "$opt" ] && mkdir $opt
[ ! -d "$base" ] && mkdir $base
[ ! -d "$script" ] && mkdir $script

cp ./* $script

# Create crewlink service user
adduser --disabled-password --gecos "" $account
chown -R crewlink:crewlink $base

# Install CrewLink-Server
pushd $base
git clone https://github.com/ottomated/crewlink-server.git $base
yarn install
popd

# Copy service and timer files
pushd $script
cp $script/crewlink.service /etc/systemd/system/crewlink-9736.service
cp $script/crewlinkupdater.service /etc/systemd/system/crewlinkupdater.service
cp $script/crewlinkupdater.timer /etc/systemd/system/crewlinkupdater.timer
popd

# Enable and start service and timer
systemctl daemon-reload
systemctl enable crewlink-9736.service
systemctl start crewlink-9736.service
systemctl status crewlink-9736.service
systemctl enable crewlinkupdater.timer
exit 0