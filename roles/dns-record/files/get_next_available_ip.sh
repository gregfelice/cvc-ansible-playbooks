#!/bin/bash
#Taking an IP range as an input, it checks via ping and DNS entries to see what the next availabe IP in the range is.
#Returns the IP

#Expect 2 IPs as arguments. Start/END IPs for the range.
if [ $# -ne 2 ]
then
  echo "Usage: $0 STARTING_IP_ADDRESS ENDING_IP_ADDRESS"
  exit 1
fi

START_IP=$1
END_IP=$2

#get last octet of start/end IPs
START_ADDRESS_ARRAY=(${START_IP//./ })
END_ADDRESS_ARRAY=(${END_IP//./ })
START_LAST_OCTET=${START_ADDRESS_ARRAY[3]}
END_LAST_OCTET=${END_ADDRESS_ARRAY[3]}
SUBNET=${START_ADDRESS_ARRAY[0]}.${START_ADDRESS_ARRAY[1]}.${START_ADDRESS_ARRAY[2]}

#echo $START_IP - $END_IP
#echo $START_LAST_OCTET - $END_LAST_OCTET
#echo $SUBNET

for LAST_OCTET in `seq $START_LAST_OCTET $END_LAST_OCTET`
do
  echo $LAST_OCTET
  #Do Something here
  #To be available, it MUST not be pingable AND must NOT be in DNS (PTR record is the only thing we can check).
  #Check DNS
  if host $SUBNET.$LAST_OCTET
  then
    echo "Host is in DNS"
    AVAIL=NO
  elseif ping -c3 -w3 $SUBNET.$LAST_OCTET
    AVAIL=NO
  else
    AVAIL=YES
  fi
  echo $SUBNET.$LAST_OCTET,$AVAIL
done
