

# Getting off the ground

## Set up your ansible master, test that you can configure the master using ansible

* Get a development box
* Get personal account on it
* Get the root password for that box
* Run $PROJECT_HOME/setup_master.sh
* Set up your inventory file ($PROJECT_HOME/stage), adding the machine you are on to the [new] section
* Run $PROJECT_HOME/apply_bootstrap_to_new
* Set up your inventory file ($PROJECT_HOME/stage), moving the machine that you are on to the [base] section
* Run $PROJECT_HOME/apply_base to stage
* Start developing your role within the $PROJECT_HOMES/roles directory

Ansible documentation is here: http://docs.ansible.com/

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


