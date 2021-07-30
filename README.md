# Cellular Service for H31

On the Nano with Jetpack 4.5.1, the sierra wireless EM7511 upgraded to firmware release 15 (ATT) https://source.sierrawireless.com/resources/airprime/minicard/75xx/airprime-em_mc75xx-approved-fw-packages/#sthash.dzHcyzOQ.dpbs, network manager and modem manager handle the connection.
```
sudo apt update
sudo apt install modemmanager
```
add the connection via network manager
```
sudo nmcli connection add type gsm ifname cdc-wdm0 con-name 'attcell' apn 'Broadband' connection.autoconnect yes
```
reboot the system  
Once the network comes up, you should get a wwan0 interface

```mmcli --list-modems```
General details and status of them modem (included signal strength) can be listed with "--modem" option, e.g.
```mmcli --modem=0```

Useful reference: https://techship.com/faq/using-networkmanager-and-modemmanager-in-linux-to-automatically-establish-and-maintain-a-connection/

#### Warning: below is depracated on the Jetson boards at least, do not use due to intermitted connectivity issues. Use networkmanager and modemmanager as detailed above. TBD with the Pi. 

## Dependencies

* `libqmi-utils` 
* `udhcpc`    
These will be installed automatically during a `make install` assuming you have an internet connection  


## Installation

To perform an initial install, establish an internet connection and clone the repository.
You will issue the following commands:
```
cd $HOME
git clone https://github.com/horiz31/cellular.git
```

provide your credentials, then continue:
```
make -C $HOME/cellular install
```

This will pull in the necessary dependencies, install the sierra wireless drivers, provision the system and start the cellular service  

To make future changes in the provisioning:
```
make -C $HOME/cellular provision
```

This will enter into an interactive session to help you setup your APN


## Files

 * `Makefile` - installation automation
 * `README.md` - this file
 * `provision.sh` - script to support creating and changing the config file
 * `cellular.service` - service file
 * `cellular-start.sh` - script ran by the service to start the cellular
 * `cellular-stop.sh` - script ran by the service to stop the cellular

## General architecture and notes

A cellular.service file is saved to /etc/systemd/system and enabled for auto start on boot. This service file pulls in config data from /etc/systemd/cellular.conf (see below). When the service is started, it runs cellular-start.sh which configures the cellular modem and uses udhcpc to obtain an ip address and set up the route. The Network handle and CID are save to a /var/run/cellular.env file, because those variables are needed when/if the service is shutdown to properly bring down the modem. The cellular-stop.sh script shuts down the cellular service and the wwan0 interface.

On the RPi, the default dhcp client (dhcpcd) does not seems to support raw-ip mode for dhcp, so during `make install` dhcpcd is disabled. If you need a dhcp client on the system, the implications of removing the default raspian dhcp client are unknown. I expect that in most installs we will be using static IP addresses anyway, but if not some more work is needed. On the working system, network-manager is present, so it is possible that network manager is handling dhcp. If on a future build the LAN does not get DHCP (and it is needed), consider adding network-manager.

Networkmanager does seem compatible with this setup, however by default an install of networkmanger includes modemmanager (on the rpi packages anyway) and modemmanager tries to use the same QMI tools we are using to set up the modem causes access conflicts. So we must make sure that modemmanager is not on the system. The make install attempts to remove modemmanager if it is found. 

It is unknown why Modemmanager doesn't work out of the box with the sierra wireless modems. I suspect it is because they only support raw-ip mode rather than 802.3. The modemmanager you get with the raspian package manager are pretty old (1.10.x) and it may be possible to build a newer version for the pi. It would be interesting to try the same modem on a Ubuntu build with more up to date packages and see what happens. At this point, I'm not sure what (if any) benefits we'd get from modemmanager but we may uncover something in the future and want to revist this.

The `cellular-start.sh` script shuts down the wwan0 interface, then configures it for raw-ip mode, then brings it back up. Then the modem is configured with apn and other settings using qmicli. Finally, udhcpc is used as a raw-ip compatible dhcp client to get an ip address and set the route.

The `cellular-stop.sh` brings down the network connection and the shuts down the wwan0 interface.

The APN (and any future settings we come up with) are saved in a cellular.conf file which will be created during the `make install` process and saved to /etc/systemd/cellular.conf. You can see these settings using `make see`.  You can change the settings using `make provision`.

if you have a wwan0 interface with an ip address, but no internet, you may need to add a default gateway. This should not normally be required, but I have had the situation arise in debug.  
```
sudo route add default gw 10.21.141.16 dev wwan0
``` 
(where the ip address is that of the cell card)

## Supported Platforms
These platforms are supported/tested:


 * Raspberry PI
   - [x] [Raspbian GNU/Linux 10 (buster)](https://www.raspberrypi.org/downloads/raspbian/)
* Jetson Nano
   - [x] [JetPack 4.5.1]


