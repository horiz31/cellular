# Cellular Service for H31, Network Manager Version

On the Nano with Jetpack 4.5.1, the sierra wireless EM7511 upgraded to firmware release 15 (ATT) https://source.sierrawireless.com/resources/airprime/minicard/75xx/airprime-em_mc75xx-approved-fw-packages/#sthash.dzHcyzOQ.dpbs, network manager and modem manager handle the connection.

To install, 
1. Clone the repo
2. ```make install```  This will install modemmanager if needed and the sierra wireless drivers

To view the current apn  
```make see```

network manager is used to create a connection profile called attcell. You can check this status of this connection with  
```sudo nmcli con show```

For general debugging and to make sure the modem is recognized:  
```mmcli --list-modems```
General details and status of them modem (including signal strength) can be listed with "--modem" option, e.g.  
```mmcli --modem=0```    

Useful reference: https://techship.com/faq/using-networkmanager-and-modemmanager-in-linux-to-automatically-establish-and-maintain-a-connection/


## Supported Platforms
These platforms are supported/tested:

 * Raspberry PI
   - [ ] [Raspbian GNU/Linux 10 (buster)](https://www.raspberrypi.org/downloads/raspbian/)
* Jetson Nano
   - [x] [JetPack 4.5.1]


