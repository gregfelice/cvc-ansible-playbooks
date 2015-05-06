#!/bin/bash

#verify the args
if [ $# -ne 2 ]
then
  echo "Usage:   $0 FQDN location_to_save"
  echo "Example: $0 www.example.com /home/ansible/certs/"
  exit 1
fi

FULL_NAME=$1
CERT_DIR=$2
#ORGANIZATION="Cablevision Systems Corporation"
ORGANIZATION="Cabelvision Systems Corporation"     #mispelled on purpose for API test. defined in our VICE DEV account at Verisign like this.
LOCALITY="Bethpage"
STATE="New York"
COUNTRY="US"
OU="Enterprise IT"

#Get the date for the file format
TODAY=`date +%m-%d-%Y_%H%M`

#step 1 - generate private key
/usr/bin/openssl genrsa -out $CERT_DIR/$FULL_NAME-$TODAY.key 2048 &>/dev/null

#step 2 - generate the CSR
/usr/bin/openssl req -new -subj "/CN=$FULL_NAME/O=$ORGANIZATION/OU=$OU/C=$COUNTRY/ST=$STATE/L=$LOCALITY" -key $CERT_DIR/$FULL_NAME-$TODAY.key -out $CERT_DIR/$FULL_NAME-$TODAY.csr &>/dev/null
