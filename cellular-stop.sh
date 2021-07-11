#!/bin/bash
SUDO=$(test ${EUID} -ne 0 && which sudo)
ENV_LOCATION=/var/run/cellular
#shutdown cellular
set -e
#get the network handle and cid from file
NETWORK_HANDLE=$($SUDO grep ^NETWORK_HANDLE ${ENV_LOCATION}/cellular.env 2>/dev/null | cut -f2 -d=)
CID=$($SUDO grep ^CID ${ENV_LOCATION}/cellular.env 2>/dev/null | cut -f2 -d=)

echo "Shutting down cellular.."
echo "NETWORK_HANDLE is ${NETWORK_HANDLE}"
echo "CID is ${CID}"
#release network
qmicli -d /dev/cdc-wdm0 --wds-stop-network=$NETWORK_HANDLE --client-cid=$CID
#take down the interface
ifconfig wwan0 down
set +e
