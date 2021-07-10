#!/bin/bash

#bringup cellular, tested with Sierra Wireless M.2 modems which only support raw-ip
set -e
ifconfig wwan0 down
echo Y > /sys/class/net/wwan0/qmi/raw_ip
ifconfig wwan0 up
RET=$(qmicli -d /dev/cdc-wdm0 --device-open-net="net-raw-ip|net-no-qos-header" --wds-start-network="apn='${APN}',ip-type=4" --client-no-release-cid)
#save the network handle and CID
NETWORK_HANDLE=$(echo $RET | cut -f2 -d\' | xargs)
CID=$(echo $RET | cut -f5 -d: | xargs)
udhcpc -i wwan0 -q -T 20
set +e
