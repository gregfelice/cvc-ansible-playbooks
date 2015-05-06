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
-You must have a CSR already prepared.  This is your Certificate Signing Request which contains all your cert metadata.
-Your Verisign/Symantec account must be enabled for VICE 2.0 web services. Contact Symantec Customer Service to request it.
-The Verisign API requires certificate based authentication.  You will recieve this cert when your account is enabled for VICE 2.0.  The cert must be in x509 format. They probably will give it to you in PFX format.
-Example on how to convert a PFX format cert to x509 format: openssl pkcs12 -in SSLWEBSERVICES.pfx -out verisign_ssl_client_cert_api.pem -nodes

**To run this script:**

1. Edit settings.ini to customize it to your settings.
2. Run it: ./verisign_purchase_ssl_certificate.py -c www.example.com.csr -p "DuckvillePlatapuss" -t "Server" -s "Apache" -y 1 -f ./www.example.com.crt -g "Eric" -l "McAlvin" -e "my_email_address@yahoo.com" -d


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
