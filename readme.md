# How to setup multiple CrewLink-Server instances on one server

## About

This will help setup a CrewLink-Server. You can also add more servers, running on other ports. It will also auto update all servers installed.

## Requirements

1. Debian 10 on a VM/VPS that either has a Public IP address or ports are forwarded to it

## CrewLink-Server service setup

* Create the folder `/opt/crewlink-scripts`
* Copy all files into `/opt/crewlink-scripts`
* `cd` into `/opt/crewlink-scripts`
* Run `./setup.sh`

This will create the first CrewLink-Server instance.

## Add another CrewLink-Server instance

This is untested.

* `cd /opt/crewlink-scripts`
* Run `./add-server.sh <port>` , replacing `<port>` with a port above 1024 such as 9737 that isn't being used by another service. 9736 is used by the first CrewLink-Server instance.

## How to get your IP on a VPS

* Run `curl ifconfig.me` . This might require curl to be installed.