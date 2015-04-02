
# Quick Status
* We're working off of machines generously provided from the EIT Arch lab, can be used to keep us moving (thanks Frank)
* Waiting on additional machines from Scott's group, in progress, not a blocker
* Naveen is working with Joe to give us his official time on this project
* Still need to hear from Madan on his timeslice

# Current Machines
* GREG 	  Cvldarch01-10v.cscdev.com        172.16.107.71
* ERIC 	  Cvldarch01-11v.cscdev.com        172.16.107.90
* NAVEEN 	  Cvldarch01-12v.cscdev.com        172.16.107.124
* MADAN 	  Cvldarch01-13v.cscdev.com        172.16.107.125

# Getting off the ground

## Set up your ansible master & target machine

* Get a development box
* Get personal account on it
* Get the root password for that box
* git clone the ansible-playbooks repo from stash
* Set up your inventory file ($PROJECT_HOME/stage), adding the machine you are on to the [new] and [base] section
* Run $PROJECT_HOME/go.sh
  * Accept all defaults for the ssh-keygen steps
  * Enter root password when prompted
* Start developing your role within the $PROJECT_HOMES/roles directory

Ansible documentation is here: http://docs.ansible.com/


# Coding Standards
* Ansible is basically yaml. Emacs, VI, etc. all have yaml modes. They help.
* We indent yaml 2 spaces. No tabs.

# Other Notes

## Some Future Directions

### Provision from vSphere
* [Ansible vSphere guest module](http://docs.ansible.com/vsphere_guest_module.html)

### Automate SSL certificates
* [How do I securely deploy SSL keys with Ansible?](http://red-badger.com/blog/2014/02/28/deploying-ssl-keys-securely-with-ansible/)

### Automate DNS configs
* For internal DNS, TBD
* [For UltraDNS, a reasonable python REST library](http://docs.python-requests.org/en/latest/index.html)

### Tomcat cluster (2 nodes)
* [How do I iterate over a list of hosts in a group?](http://docs.ansible.com/faq.html)
* [How do I manage machines with group_vars?](https://gist.github.com/anonymous/5e1f88c5acc0dc699093)

### Automate F5 load balancer configs
* [A list of Ansible network modules](http://docs.ansible.com/list_of_network_modules.html)

### Invoke playbooks via web services
* TBD


