#!/bin/bash

#bringup cellular, tested with Sierra Wireless M.2 modems which only support raw-ip
#todo, make APN an parameter in /etc/systemd/cellular.conf


ifconfig wwan0 down
echo Y > /sys/class/net/wwan0/qmi/raw_ip
ifconfig wwan0 up
qmicli -d /dev/cdc-wdm0 --device-open-net="net-raw-ip|net-no-qos-header" --wds-start-network="apn='${APN}',ip-type=4" --client-no-release-cid 
udhcpc -i wwan0 -q -T 20

