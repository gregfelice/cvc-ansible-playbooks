#!/bin/bash

BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $BASE_DIR

if [ "$#" -ne 3 ]
then
  echo "Usage:   $0 START_IP_ADDR END_IP_ADDR FQDN_HOSTNAME"
  echo "Example: $0 172.16.107.10 172.16.107.250 cvldarch01-54v.cscdev.com"
  exit 1
fi

START_IP=$1
END_IP=$2
HOSTNAME=$3

IP_TO_USE=`./get_next_available_ip.sh $START_IP $END_IP`
if echo $IP_TO_USE |grep -q ERROR
then
  echo "ERROR: No free IPs available in that range."
  exit 1
fi

./dns_add.sh $HOSTNAME $IP_TO_USE
DNS_ADD_RC=`echo $?`

if [ "$DNS_ADD_RC" -eq 0 ]
then
  echo "$IP_TO_USE"
else
  echo "ERROR: DNS Add Return Code: $DNS_ADD_RC"
  exit $DNS_ADD_RC
fi
