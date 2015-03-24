#!/bin/bash

/usr/bin/firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp -m tcp --dport 22 -m recent --update --seconds 180 --hitcount 3 --rttl --name SSH --rsource -m comment --comment "SSH Brute-force protection" -j LOG --log-prefix "SSH_brute_force " 

/usr/bin/firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 1 -p tcp -m tcp --dport 22 -m recent --update --seconds 180 --hitcount 3 --rttl --name SSH --rsource -m comment --comment "SSH Brute-force protection" -j DROP

/usr/bin/firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 2 -p tcp -m tcp --dport 22 -m state --state NEW -m recent --set --name SSH --rsource -m comment --comment "SSH Brute-force protection" -j ACCEPT

