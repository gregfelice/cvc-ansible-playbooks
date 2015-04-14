#!/bin/bash

#verify the args
if [ $# -ne 3 ]
then
  echo "Usage:   $0 FQDN ShortName Certificate_Validity_Length_Years"
  echo "Example: $0 mywebapp.cablevision.com mywebapp 1"
  exit 1
fi

FULL_NAME=$1
SHORT_NAME=$2
VALID_YEARS=$3
VALID_DAYS=$(($VALID_YEARS*365))
ORGANIZATION="Cablevision Systems Corporation"
LOCALITY="Bethpage"
STATE="New York"
COUNTRY="US"
OU="Enterprise IT"

#Get the date for the file format
TODAY=`date +%m-%d-%Y_%H%M`

#step 1 - generate private key
/usr/bin/openssl genrsa -out $FULL_NAME-$TODAY.key

#step 2 - generate the CSR
/usr/bin/openssl req -new -subj "/CN=$FULL_NAME/O=$ORGANIZATION/OU=$OU/C=$COUNTRY/ST=$STATE/L=$LOCALITY/subjectAltName=$SHORT_NAME" -key $FULL_NAME-$TODAY.key -out $FULL_NAME-$TODAY.csr

#step 3 - generate the self signed cert from the CSR. This can be replaced with Verisign API later.
/usr/bin/openssl x509 -req -days $VALID_DAYS -in $FULL_NAME-$TODAY.csr -signkey $FULL_NAME-$TODAY.key -out $FULL_NAME-$TODAY.crt

#step 4 - put both the key and the cert in the same pem file
/bin/cat $FULL_NAME-$TODAY.key $FULL_NAME-$TODAY.crt > $FULL_NAME-$TODAY.pem
