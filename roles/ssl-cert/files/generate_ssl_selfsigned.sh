#!/bin/bash

#verify the args
if [ $# -ne 4 ]
then
  echo "Usage:   $0 FQDN ShortName Certificate_Validity_Length_Years location_to_save"
  echo "Example: $0 mywebapp.cablevision.com mywebapp 1 /home/ansible/certs/"
  exit 1
fi

FULL_NAME=$1
SHORT_NAME=$2
VALID_YEARS=$3
CERT_DIR=$4
VALID_DAYS=$(($VALID_YEARS*365))
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
/usr/bin/openssl req -new -subj "/CN=$FULL_NAME/O=$ORGANIZATION/OU=$OU/C=$COUNTRY/ST=$STATE/L=$LOCALITY/subjectAltName=$SHORT_NAME" -key $CERT_DIR/$FULL_NAME-$TODAY.key -out $CERT_DIR/$FULL_NAME-$TODAY.csr &>/dev/null

#step 3 - generate the self signed cert from the CSR. This can be replaced with Verisign API later.
/usr/bin/openssl x509 -req -days $VALID_DAYS -in $CERT_DIR/$FULL_NAME-$TODAY.csr -signkey $CERT_DIR/$FULL_NAME-$TODAY.key -out $CERT_DIR/$FULL_NAME-$TODAY.crt &>/dev/null

#step 4 - put both the key and the cert in the same pem file
/bin/cat $CERT_DIR/$FULL_NAME-$TODAY.key $CERT_DIR/$FULL_NAME-$TODAY.crt > $CERT_DIR/$FULL_NAME-$TODAY.pem

#step 5 - return the filename of the pem file via stdout
echo $CERT_DIR/$FULL_NAME-$TODAY.pem
