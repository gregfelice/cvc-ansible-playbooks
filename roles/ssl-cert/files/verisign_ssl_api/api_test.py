#!/usr/bin/env python
#mess around with the Verisign SSL API

import requests
from xml.dom import minidom

#Disable the warning for InsecurePlatformWarning when doing REST calls
requests.packages.urllib3.disable_warnings()

csr = open('www4apps.cscdev.com-05-06-2015_1036.csr', 'rb')
rest_enroll_url = 'https://pilot-certmanager-webservices.websecurity.symantec.com/vswebservices/rest/services/enroll'

rest_headers = {'Content-Type': 'application/x-www-form-urlencoded'}

rest_payload = {
  'challenge': 'DuckvillePlatapuss',
  'firstName': 'Eric',
  'lastName': 'McAlvin',
  'email': 'emcalvin@cablevision.com',
  'certProductType': 'Server',
  'serverType': 'Apache',
  'validityPeriod': '1Y',
  'signatureAlgorithm': 'sha256WithRSAEncryption',
  'csr': csr.read()
}



verisign_ssl_client_cert = r'verisign_ssl_client_cert_api.pem'
session = requests.Session()
session.cert = (verisign_ssl_client_cert, verisign_ssl_client_cert)
r = session.post(rest_enroll_url, headers=rest_headers, data=rest_payload)
print r.status_code
print r.text

#parse the XML response to get the cert and transactionId
verisign_response_xml = minidom.parseString(r.text)
verisign_response_status_code = verisign_response_xml.getElementsByTagName("StatusCode")[0]
verisign_response_message = verisign_response_xml.getElementsByTagName("Message")[0]
verisign_response_certificate = verisign_response_xml.getElementsByTagName("Certificate")[0]
verisign_response_transactionId = verisign_response_xml.getElementsByTagName("Transaction_ID")

print verisign_response_certificate.firstChild.data

#write the cert out to a file
cert_file = open('www4apps.cscdev.com-05-06-2015_1036.crt', 'w')
cert_file.write(verisign_response_certificate.firstChild.data)

#close everything
cert_file.close()
session.close()
csr.close()

