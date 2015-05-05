#!/usr/bin/env python
#mess around with the Verisign SSL API

##example to use cert based auth:
#import requests
#cert_file_path = "cert.pem"
#key_file_path = "key.pem"
#
#url = "https://example.com/resource"
#params = {"param_1": "value_1", "param_2": "value_2"}
#cert = (cert_file_path, key_file_path)
#r = requests.get(url, params=params, cert=cert, verify=False)

import requests
#Disable the warning for InsecurePlatformWarning when doing REST calls
requests.packages.urllib3.disable_warnings()

csr = open('wwwapps.cscdev.com-05-05-2015_1514.csr', 'rb')
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
  'signatureAlgorithm' 'sha256WithRSAEncryption',
  'csr': csr.read()
}



verisign_ssl_cert = r'verisign_ssl_client_cert_api.pem'
session = requests.Session()
session.cert = (verisign_ssl_cert, verisign_ssl_cert)
r = session.post(rest_enroll_url, headers=rest_headers, data=rest_payload)

print r.content
session.close()
csr.close()
