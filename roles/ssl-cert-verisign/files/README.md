Verisign SSL Certificate Generation
====================================

     Enterprise IT Architecture
     Cablevision Systems Corporation, Inc. (c) 2015

     http://www.cablevision.com

     Author:         Eric J. McAlvin, emcalvin@cablevision.com
     Module:         verisign_ssl_api
     Description:    Purchase and download an SSL certificate from Verisign programmatically.

     This source code is for DEMONSTRATION PURPOSES ONLY.  It is provided as an illustration, implementing a specific  functionality, and is not a fully-tested, “hardened”  software artifact. It is NOT intended for production use. 


What supporting libraries are needed to run this?
-------------------------------------------------
See requirements.txt

How do I install the supporting libraries?
------------------------------------------
- Install Python Package Index (pip). If you don't already have it, you can get it via:
    1. wget https://bootstrap.pypa.io/get-pip.py
    2. sudo python get-pip.py
- Use pip to automatically install the supporting libraries:
    1. pip install -r requirements.txt

How do I run this script ?
--------------------------
* This script will use openssl to generate a private key and CSR.
* Your Verisign/Symantec account must be enabled for VICE 2.0 web services. Contact Symantec Customer Service to request it.
* Your Verisign/Symantec account must be set to AUTO-APPROVE SSL Certificates.  If it must be approved first, this code needs to be modified to just get the transactionId so you can get the cert later using that (and writing more code to do so).
* The Verisign API requires certificate based authentication.  You will recieve this cert when your account is enabled for VICE 2.0.  The cert must be in x509 format. They probably will give it to you in PFX format.
* Example on how to convert a PFX format cert to x509 format: openssl pkcs12 -in SSLWEBSERVICES.pfx -out verisign_ssl_client_cert_api.pem -nodes

**To run this script:**

1. Edit settings.ini to customize it to your settings.
2. Run it: ./verisign_purchase_ssl_certificate.py -k /tmp/www12.cscdev.com.key -c /tmp/www12.cscdev.com.csr -n www12.cscdev.com -o "Enterprise IT" -p "DuckvillePlatapuss" -t "Server" -s "Apache" -y 1 -f ./www.example.com.crt -g "Eric" -l "McAlvin" -e "my_email_address@yahoo.com" -d

Command Usage
-------------------------------------------------------------------------------
```
  -k KEY_FILE, --key-file=KEY_FILE                          Full location to save key file. REQUIRED.
  -c CSR_FILE, --csr-file=CSR_FILE                          Full location to save the CSR file. REQUIRED.
  -n FQDN, --fqdn=FQDN                                      FQDN for the SSL certificate. REQUIRED.
  -o OU, --ou=OU                                            OU / department requesting the certificate. REQUIRED
  -p CHALLENGE_PHRASE, --challenge-phrase=CHALLENGE_PHRASE  Certificate Challenge Phrase. REQUIRED.
  -t CERT_TYPE, --cert-type=CERT_TYPE                       Verisign Cert Product Type. See README.md for list. REQUIRED.
  -s SERVER_TYPE, --server-type=SERVER_TYPE                 Server Type. Determines certificate format such as x509. See README.md for list. REQUIRED.
  -y VALIDITY_PERIOD, --validity-period=VALIDITY_PERIOD     Length in years. 1, 2, or 3 only. REQUIRED.
  -a CERT_ALGORITHM, --algorithm=CERT_ALGORITHM             Certificate Signature Algorithm. Default specified in settings.ini. OPTIONAL
  -f CERT_FILE, --cert-output-file=CERT_FILE                File to save the certificate to. REQUIRED.
  -g FIRST_NAME, --first-name=FIRST_NAME                    First Name of requestor. REQUIRED.
  -l LAST_NAME, --last-name=LAST_NAME                       Last Name of requestor. REQUIRED.
  -e EMAIL, --email=EMAIL                                   Email address of the requestor. Use your team group email address. REQUIRED.
  -d, --debug                                               Enable debug output. OPTIONAL

```

What are the available options for -t (Certificate type) and -s (Server type) ?
-------------------------------------------------------------------------------
-t (Certificate type):

    Certificate product type                VICE 2.0 certProductType value (pass this in for -t)
    Standard Extended Validation SSL        HAServer
    Premium Extended Validation SSL         HAGlobalServer
    Standard SSL                            Server
    Premium SSL                             GlobalServer
    Standard Intranet SSL                   IntranetServer
    Premium Intranet SSL                    IntranetGlobalServer
    Private SSL                             PrivateServer
    Rapid SSL Enterprise                    GeotrustServer
    Private SSL                             PrivateServer

-s (Server type):

See the PDF document on page 20 for the full list.  Here is a shortened list: 

    Apache
    F5
    iPlanet
    Microsoft
    BEA WebLogic
    Netscape
    Red Hat

You probably only need to request it in Apache format which will be x509 (Base64 encoded cert) and then you can convert it using openssl tools.
