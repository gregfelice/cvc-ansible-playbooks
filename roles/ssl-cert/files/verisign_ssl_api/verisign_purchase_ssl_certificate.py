#!/usr/bin/env python

# Enterprise IT Architecture
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


import sys
import requests
from xml.dom import minidom
import settings
from optparse import OptionParser


def get_ssl_certificate(csr_file, challenge_phrase, cert_type, server_type, validity_period, cert_algorithm, first_name,
                        last_name, email, debug):
  """Connect to Verisign API.  Purchase certificate. Return the certificate object and transactionId string"""

  #Open csr_file as a file object
  csr = open(csr_file, 'rb')

  #Content-Type header is required by Verisign
  rest_headers = {'Content-Type': 'application/x-www-form-urlencoded'}

  #prepare the post payload
  rest_payload = {
    'challenge': challenge_phrase,
    'firstName': first_name,
    'lastName': last_name,
    'email': email,
    'certProductType': cert_type,
    'serverType': server_type,
    'validityPeriod': validity_period + 'Y',
    'signatureAlgorithm': cert_algorithm,
    'csr': csr.read()
  }

  #close the CSR file object
  csr.close()

  #Disable the warning for InsecurePlatformWarning when doing REST calls
  requests.packages.urllib3.disable_warnings()

  #Requests' Session object is used in order to authenticate with SSL Client Certificate.
  session = requests.Session()
  session.cert = (settings.VERISIGN_CLIENT_CERT_FILE, settings.VERISIGN_CLIENT_CERT_FILE)

  #Connect to Verisign API and execute the SSL certificate purchase.
  try:
    r = session.post(settings.VERISIGN_REST_ENROLL_URL, headers=rest_headers, data=rest_payload)
  except requests.RequestException, e:
    print "ERROR: REST call to Verisign failed due to the follow error:", e
    sys.exit(2)

  #Close the Requests session
  session.close()

  #Exit program if the REST response code is not OK (200)
  if not r.status_code == 200:
    print "ERROR: REST call to Verisign did not respond with response code of 200(OK). Details:", r.status_code
    sys.exit(3)

  #If Debug is enabled, print the whole response payload.
  if debug: print r.text

  #Parse the XML response to get the cert and transactionId
  verisign_response_xml = minidom.parseString(r.text)
  verisign_response_status_code = verisign_response_xml.getElementsByTagName("StatusCode")[0]
  verisign_response_message = verisign_response_xml.getElementsByTagName("Message")[0]
  response_status_code = verisign_response_status_code.firstChild.data
  response_message = verisign_response_message.firstChild.data

  if not response_status_code == "0x00":
    print "ERROR: Verisign API status code not 0x00. Details", response_status_code, response_message
    sys.exit(4)

  verisign_ssl_certificate = verisign_response_xml.getElementsByTagName("Certificate")[0]
  verisign_transaction_id = verisign_response_xml.getElementsByTagName("Transaction_ID")[0]
  ssl_certificate = verisign_ssl_certificate.firstChild.data
  transaction_id = verisign_transaction_id.firstChild.data


  return ssl_certificate, transaction_id


def create_ssl_cert_file(ssl_certificate_file_output, ssl_certificate):
  """Write the SSL certificate object to a file.  Function does not return anything"""

  try:
    cert_file = open(ssl_certificate_file_output, 'w', )
    cert_file.write(ssl_certificate)
  except IOError, e:
    print "ERROR: Unable to create certificate file due to the following:", e
    sys.exit(5)

  #close the file
  cert_file.close()


def main():
  #Setup program command line options
  usage = "usage: %prog [options] arg"
  parser = OptionParser(usage)
  parser.add_option("-c", "--csr-file", dest="csr_file", help="CSR file. REQUIRED.")
  parser.add_option("-p", "--challenge-phrase", dest="challenge_phrase", help="Certificate Challenge Phrase. REQUIRED.")
  parser.add_option("-t", "--cert-type", dest="cert_type",
                    help="Verisign Cert Product Type. See README.md for list. REQUIRED.")
  parser.add_option("-s", "--server-type", dest="server_type",
                    help="Server Type. Determines certificate format such as x509. See README.md for list. REQUIRED.")
  parser.add_option("-y", "--validity-period", dest="validity_period",
                    help="Length in years. 1, 2, or 3 only. REQUIRED.")
  parser.add_option("-a", "--algorithm", dest="cert_algorithm",
                    help="Certificate Signature Algorithm. Default specified in settings.ini. OPTIONAL",
                    default=settings.SSL_CERT_ALGORITHM_DEFAULT)
  parser.add_option("-f", "--cert-output-file", dest="cert_file", help="File to save the certificate to. REQUIRED.")
  parser.add_option("-g", "--first-name", dest="first_name", help="First Name of requestor. REQUIRED.")
  parser.add_option("-l", "--last-name", dest="last_name", help="Last Name of requestor. REQUIRED.")
  parser.add_option("-e", "--email", dest="email",
                    help="Email address of the requestor. Use your team group email address. REQUIRED.")
  parser.add_option("-d", "--debug", dest="debug", action="store_true", help="Enable debug output. OPTIONAL")
  (options, args) = parser.parse_args()

  #Check all the command line options
  if not options.csr_file or not options.challenge_phrase or not options.cert_type or not options.server_type or not options.validity_period or not options.cert_file or not options.first_name or not options.last_name or not options.email:
    parser.print_help()
    sys.exit(1)

  #Connect to Verisign, purchase cert.  Returns the cert and transactionID
  (ssl_certificate, transactionId) = get_ssl_certificate(csr_file=options.csr_file,
                                                         challenge_phrase=options.challenge_phrase,
                                                         cert_type=options.cert_type,
                                                         server_type=options.server_type,
                                                         validity_period=options.validity_period,
                                                         cert_algorithm=options.cert_algorithm,
                                                         first_name=options.first_name,
                                                         last_name=options.last_name,
                                                         email=options.email,
                                                         debug=options.debug)

  #Write the SSL certificate to a file
  create_ssl_cert_file(ssl_certificate_file_output=options.cert_file, ssl_certificate=ssl_certificate)

  #Print to stdout the location the SSL cert was saved, and the Verisign TransactionId
  print "SSL Certificate file written to: ", options.cert_file
  print "Verisign Transaction ID: ", transactionId


# Standard boilerplate to call the main() function.
if __name__ == '__main__':
  main()