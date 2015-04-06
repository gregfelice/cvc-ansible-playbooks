#!/bin/bash
#The keys are just setup to be able to update the apps.cscdev.com domain hosted on DNS_SERVER below.
#This script supports only BIND with 'allow-update' directive on the domains defined in named.conf.  

BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
KEYFILE=$BASE_DIR/Kapps.cscdev.com.+157+00396.private
DNS_SERVER="cvldarch01-11v.cscdev.com"
TTL="300"

if whoami | egrep -vq ^root$
then
  echo "This script must be run as root. Exiting."
  exit 1
fi

if [ "$#" -ne 2 ]
then
  echo "Usage: $0 fully_qualified_hostname IP_address"
  exit 2
fi

if [ ! -f $KEYFILE ]
then
  echo "BIND TSIG keyfile $KEYFILE is not found.  Exiting"
  exit 3
fi

FQDN=$1
IP_ADDR=$2

#FWD ENTRY (A RECORD)
echo "server $DNS_SERVER
prereq nxdomain $FQDN.
update add $FQDN. $TTL IN A $IP_ADDR
send
" | /usr/bin/nsupdate -k $KEYFILE
RC=$?

#REVERSE ENTRY (PTR RECORD) only if A Record was successful
if [ "$RC" -ne 0 ]
then
  exit $RC
else
  #Reverse the IP Address so it is in IN.ADDR.ARPA format.
  PTR_ADDR_ARRAY=(${IP_ADDR//./ })
  PTR_ADDR=${PTR_ADDR_ARRAY[3]}.${PTR_ADDR_ARRAY[2]}.${PTR_ADDR_ARRAY[1]}.${PTR_ADDR_ARRAY[0]}.in-addr.arpa
  echo "server $DNS_SERVER
  prereq nxdomain $PTR_ADDR
  update add $PTR_ADDR $TTL PTR $FQDN.
  send
  " | /usr/bin/nsupdate -k $KEYFILE
fi
