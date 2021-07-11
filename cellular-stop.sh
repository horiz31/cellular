#!/bin/bash
SUDO=$(test ${EUID} -ne 0 && which sudo)
ENV_LOCATION=/var/run/cellular
#shutdown cellular
#get the network handle and cid from file
if [ -f "${ENV_LOCATION}/cellular.env" ] ; then
   NETWORK_HANDLE=$($SUDO grep ^NETWORK_HANDLE ${ENV_LOCATION}/cellular.env 2>/dev/null | cut -f2 -d=)
   CID=$($SUDO grep ^CID ${ENV_LOCATION}/cellular.env 2>/dev/null | cut -f2 -d=)
   #release network
   echo "Shutting down cellular Network ${NETWORK_HANDLE} CID ${CID}..."  
   qmicli -d /dev/cdc-wdm0 --wds-stop-network=$NETWORK_HANDLE --client-cid=$CID
else
   echo "Envrionment file not found, not a graceful shutdown..."
fi

#take down the interface
ifconfig wwan0 down

