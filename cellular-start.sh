#!/bin/bash
ENV_LOCATION=/var/run/cellular
TMP_FILE=/tmp/cellular.$$

#bringup cellular, tested with Sierra Wireless M.2 modems which only support raw-ip
#set raw-ip mode, needed by sierra wireless modems tested with
ifconfig wwan0 down
echo Y > /sys/class/net/wwan0/qmi/raw_ip
ifconfig wwan0 up
#try to start the network
qmicli -d /dev/cdc-wdm0 --device-open-net="net-raw-ip|net-no-qos-header" --wds-start-network="apn='${APN}',ip-type=4" --client-no-release-cid > $TMP_FILE
if [ -f $TMP_FILE ]; then
   if ! grep -q "Network started" $TMP_FILE ; then
	echo "Network not started, exiting..."
	exit 1
   fi
else
   echo "Error starting cellular, exiting..."
   exit 1
fi

#if we got this far, then the network started
#make environment file
touch /var/run/cellular/cellular.env
echo "Start success, response:"
cat /tmp/cellular.$$

NETWORK_HANDLE=$(cat /tmp/cellular.$$ | cut -f2 -d\' |  head -2 | tail -1 | xargs)
CID=$(cat /tmp/cellular.$$ | tail -1 | cut -f2 -d: | xargs)
echo "NETWORK HANDLE is $NETWORK_HANDLE"
echo "CID is $CID"
#save these values to a .env file so they can be retrieved at shutdown
echo "NETWORK_HANDLE=${NETWORK_HANDLE}" >> ${ENV_LOCATION}/cellular.env && \
echo "CID=${CID}" >> ${ENV_LOCATION}/cellular.env
#ask for dhcp address
if ! udhcpc -i wwan0 -n -q -t 3 -T 3 ; then exit 1 ; fi
#cleanup temp files
rm /tmp/cellular.$$

