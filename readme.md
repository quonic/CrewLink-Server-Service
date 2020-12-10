## About

This will help setup a CrewLink-Server as a service. <!--You can also add more services running on other ports.--> It will also auto update.

## Requirements

1. Debian or Ubuntu
2. Server that has a public IP address or the related ports are forwarded to it
  * You can set this up on a VPS service like Linode, AWS, Azure, or others.

## CrewLink-Server service setup

Login as root and run the following:
```
apt install git
[ ! -d "/opt" ] && mkdir /opt
git clone https://github.com/quonic/CrewLink-Server-SystemD-Service.git /opt/crewlink-scripts
cd /opt/crewlink-scripts && chmod +x *.sh
./setup.sh
```
Reboot to make sure that the update script will run

---

This will create the first CrewLink-Server instance running under a newly created user account `crewlink`. The `crewlink` user is a no password / service account that can't be logged in and doesn't have root access.

## How to get your IP on a VPS

* Run `curl ifconfig.me` . This might require curl to be installed.

<!-- Tested and this doesn't work. I will need to have it copy the crewlink-server folder into another folder and run it from there.
## Add another CrewLink-Server instance

Notes: This hasn't been tested, as I don't know if yarn will like running more than one instance from the same directory.

* `cd /opt/crewlink-scripts`
* Run `./add-server.sh <port>` , replacing `<port>` with a port above 1024 such as 9737 that isn't being used by another service. 9736 is used by the first CrewLink-Server instance.
-->