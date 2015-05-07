#     Enterprise IT Architecture
#     Cablevision Systems Corporation, Inc. (c) 2015
#
#     http://www.cablevision.com
#
#     Author:         Eric J. McAlvin, emcalvin@cablevision.com
#     Module:         verisign_ssl_api
#     Description:    Purchase and download an SSL certificate from Verisign programmatically.
#
#     This source code is for DEMONSTRATION PURPOSES ONLY.
#     It is provided as an illustration, implementing a specific
#     functionality, and is not a fully-tested, hardened
#     software artifact. It is NOT intended for production use.


#Seperates code from config
#Requires python-decouple https://pypi.python.org/pypi/python-decouple

from decouple import config

VERISIGN_CLIENT_CERT_FILE=config('VERISIGN_CLIENT_CERT_FILE', cast=str)
VERISIGN_REST_ENROLL_URL=config('VERISIGN_REST_ENROLL_URL', cast=str)
SSL_CERT_ALGORITHM_DEFAULT=config('SSL_CERT_ALGORITHM_DEFAULT', cast=str)
SSL_KEY_TYPE=config('SSL_KEY_TYPE', cast=str)
SSL_KEY_BITS=config('SSL_KEY_BITS', cast=str)
OPENSSL=config('OPENSSL', cast=str)
ORGANIZATION=config('ORGANIZATION', cast=str)
LOCALITY=config('LOCALITY', cast=str)
STATE=config('STATE', cast=str)
COUNTRY=config('COUNTRY', cast=str)
