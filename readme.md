# How to CrewLink-Server to run as a service under systemd

## About

This will help setup a CrewLink-Server. You can also add more servers, running on other ports. It will also auto update all servers installed.

## Requirements

1. Debian 10 on a VM/VPS that either has a Public IP address or ports are forwarded to it

## CrewLink-Server service setup

* Run `apt install git`
* Create the folder `/opt/` if it doesn't exist
* Run `https://github.com/quonic/CrewLink-Server-SystemD-Service.git /opt/crewlink-scripts`
* `cd` into `/opt/crewlink-scripts`
* Run `./setup.sh`

This will create the first CrewLink-Server instance running under the newly created user account crewlink. The crewlink user is a no password account that can't be logged in and doesn't have root access.

## Add another CrewLink-Server instance

This is untested.

* `cd /opt/crewlink-scripts`
* Run `./add-server.sh <port>` , replacing `<port>` with a port above 1024 such as 9737 that isn't being used by another service. 9736 is used by the first CrewLink-Server instance.

## How to get your IP on a VPS

* Run `curl ifconfig.me` . This might require curl to be installed.
