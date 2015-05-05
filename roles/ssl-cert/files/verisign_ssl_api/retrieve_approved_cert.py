#!/usr/bin/env python
#mess around with the Verisign SSL API


import requests

#Disable the warning for InsecurePlatformWarning when doing REST calls
requests.packages.urllib3.disable_warnings()

rest_pickup_url = 'https://pilot-certmanager-webservices.websecurity.symantec.com/vswebservices/rest/services/pickup'

#rest_headers = {'Content-Type': 'application/x-www-form-urlencoded'}

rest_payload = {
  'transaction_id': '2c7b438dfaa078fe8e8b0518567ccf5c'
}

verisign_ssl_cert = r'verisign_ssl_client_cert_api.pem'
session = requests.Session()
session.cert = (verisign_ssl_cert, verisign_ssl_cert)
r = session.get(rest_pickup_url, params=rest_payload)
print r.status_code
print r.text

#TO-DO:  Parse the XML to get the cert output from r.text, and then save it to a file!
#TO-DO:  pass the transaction-id as a parameter to this script.

session.close()
