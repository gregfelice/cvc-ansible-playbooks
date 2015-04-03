This document explains how to update DNS entries (both FWD and PTR) on a BIND name server on the fly, programmatically.  BIND doesn't offer a true API, so you must do this
via dynamic DNS updates using the nsupdate utility, while communicating in a secure fashion using TSIG keys. 

1.) Generate a TSIG Key for your client to communicate to BIND with.
command used to generate TSIG key:
dnssec-keygen -r /dev/urandom -a HMAC-MD5 -b 512 -n HOST apps.cscdev.com
NOTE: that the key name MUST be the same in named.conf (above it is apps.cscdev.com).  MUST MATCH!


If you are going to manually update zone files in BIND where the zone is also recieving dynamic updates; you must freeze/thaw the zone file.

to update a zone file manually: 
1.) rndc freeze apps.cscdev.com  (this merges the zone journal file with the zone file)
2.) vi the zone file, make changes
3.) rndc thaw apps.cscdev.com  (this also performs the rndc reload of the zone).



COMMAND USED TO PERFORM UPDATE:
nsupdate -k Kapps.cscdev.com.+157+00396.private -v nsupdate.txt
CONTENTS OF nsupdate.txt:
debug
server cvldarch01-11v.cscdev.com
zone apps.cscdev.com.
update add test.apps.cscdev.com. 300 IN A 172.16.107.91
show
send 


COMMAND USED TO PERFORM PTR RECORD UPDATE:
nsupdate -k Kapps.cscdev.com.+157+00396.private -v nsupdate_PTR.txt
CONTENTS OF nsupdate_PTR.txt:
server cvldarch01-11v.cscdev.com
update add 10.107.16.172.in-addr.arpa 300 ptr cvldarch01-11v.cscdev.com. 
show
send 
