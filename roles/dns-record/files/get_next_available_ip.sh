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

#echo IP_ADDR,IN_DNS,PINGABLE,AVAILABLE
for LAST_OCTET in `seq $START_LAST_OCTET $END_LAST_OCTET`
do
  #To be available, it MUST not be pingable AND must NOT be in DNS (PTR record is the only thing we can check).
  if host $SUBNET.$LAST_OCTET &>/dev/null		#Check to see if IP is in DNS
  then
    IN_DNS=YES
    AVAIL=NO
    PINGABLE=N/A
  elif ping -c2 -w2 $SUBNET.$LAST_OCTET &>/dev/null	#Check if its pingable
  then
    PINGABLE=YES
    IN_DNS=NO
    AVAIL=NO
  else
    PINGABLE=NO
    IN_DNS=NO
    AVAIL=YES
  fi
  #Exit once you find an available IP. Print the IP that is avail.
  if [ "$AVAIL" == "YES" ]
  then
    echo $SUBNET.$LAST_OCTET
    exit 0
  fi
  #echo $SUBNET.$LAST_OCTET,$IN_DNS,$PINGABLE,$AVAIL
done
