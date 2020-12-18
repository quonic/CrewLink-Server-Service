#!/bin/bash

base=/opt/crewlink-server
status=0

if [ "$EUID" -ne 0 ]
  then echo "Please run as root. sudo ./setup.sh"
  exit 1
fi
pushd $base
journalctl -u crewlink-9736 --since=-1h | grep -Fxq "\"GET \/\d+.\d+.\d+.yml HTTP\/1.1\" 404" | tail -n 1
if [ "$(journalctl -u crewlink-9736 --since=-1h | awk '{print ($0 ~ /\"GET \/[0-9]+.[0-9]+.[0-9]+.yml HTTP\/1.1\" 404/)?1:0}' | tail -n 1)" -eq 1 ] || [ "$(git rev-list HEAD...origin/master --count)" -gt "0" ]; then
  echo "Updating CrewLink-Server"
  service crewlink-* stop
  su -c "git fetch --all;git reset --hard origin/master" crewlink
  chown -R crewlink:crewlink $base
  service crewlink-* start
  if [[ "$(journalctl -u crewlink-9736 --since=-1h | tail -n 4)" =~ .*"CrewLink Server started".* ]]; then
    echo "CrewLink Server started."
    status=0
  else
    echo "CrewLink failed to start."
    status=1
  fi
else
  echo "Nothing to Update."
  status=0
fi
popd
exit $status