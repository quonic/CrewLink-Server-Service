#!/bin/bash

base=/opt/crewlink-server

if [ "$EUID" -ne 0 ]
  then echo "Please run as root. sudo ./setup.sh"
  exit 1
fi

if [ "$(git rev-list HEAD...origin/master --count)" -gt "0" ]; then
    service crewlink-* stop
    su -c "pushd $base;git fetch;popd" crewlink
    service crewlink-* start
fi