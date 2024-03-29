# Development Notes

## Current Sprint Goals

On 6 boxes from EIT Arch lab, all centos, demonstrate the following

* HA Proxy as load balancer
* JBoss as app server in cluster of 2 (work on single first)
* Bind in EIT lab as DNS
* Self signed SSL deployed to ?
* All wrapped with orchestration (see lamp / haproxy example)

Work the following issues in parallel with above, report on progress 

* vSphere guest provisionin g
* F5 load balancers
* Verisign API based CA signed SSL certs

# Getting off the ground

## Set up your ansible master & target machine

* Get a development box
* Get personal account on it
* Get the root password for that box
* Git clone the ansible-playbooks repo from stash
* Set up your inventory file ($PROJECT_HOME/stage), adding the machine you are on to the [new] and [base] section
* SSH into the box you are currently on to populate the known_hosts file
* Run $PROJECT_HOME/go.sh
* Accept all defaults for the ssh-keygen steps
* Enter root password when prompted
* Start developing your role within the $PROJECT_HOMES/roles directory

# Machine Inventory

## EIT Arch Lab

| Owner | Hostname                  | IP             |
|-------|---------------------------|----------------|
| GREG 	| cvldarch01-10v.cscdev.com | 172.16.107.71  |
| GREG 	| cvldarch02.cscdev.com     | 172.16.107.69  |
| ERIC 	| cvldarch01-11v.cscdev.com | 172.16.107.90  |
| ERIC 	| cvldarch05.cscdev.com     | 172.16.107.91  |
| NAVEEN| cvldarch01-12v.cscdev.com | 172.16.107.124 |
| NAVEEN| cvldarch01-13v.cscdev.com | 172.16.107.125 |

## vSphere Pre-Provisioned Hosts
* root password before change: @nsib1e

| Owner | Hostname                  | IP             |
|-------|---------------------------|----------------|
| NAVEEN| cvldans1.cscdev.com       |172.16.107.103  |
| NAVEEN| cvldans2.cscdev.com       |172.16.107.104  |
| GREG  | cvldans3.cscdev.com       |172.16.107.105  |
| GREG  | cvldans4.cscdev.com       |172.16.107.106  |
| ERIC  | cvldans5.cscdev.com       |172.16.107.107  |
| ERIC  | cvldans6.cscdev.com       |172.16.107.108  |
|       | cvldans7.cscdev.com       |172.16.107.109  |
|       | cvldans8.cscdev.com       |172.16.107.110  |

## vSphere Console Access
* username: ansibleadmin@ndcvc.com
* password: Ans1ble@dm1n
* This account has been configure to see the Devcl2-Vol01-Ansible-7045-0396 data store.
* You will be able to use the following range of IPs: 172.16.110.44 – 172.16.110.54
* We are also in the process of obtaining an additional 10 IPs on the 172.16.111 VLAN.

## IP ranges
```
INC0248074 bp 4/6/2015              172        16           111        100
INC0248074 bp 4/6/2015              172        16           111        101
INC0248074 bp 4/6/2015              172        16           111        102
INC0248074 bp 4/6/2015              172        16           111        103
INC0248074 bp 4/6/2015              172        16           111        104
INC0248074 bp 4/6/2015              172        16           111        105
INC0248074 bp 4/6/2015              172        16           111        106
INC0248074 bp 4/6/2015              172        16           111        107
INC0248074 bp 4/6/2015              172        16           111        108
INC0248074 bp 4/6/2015              172        16           111        109

INC0248074 BP 4/3/2015              172        16           110        44
INC0248074 BP 4/3/2015              172        16           110        45
INC0248074 BP 4/3/2015              172        16           110        46
INC0248074 BP 4/3/2015              172        16           110        47
INC0248074 BP 4/3/2015              172        16           110        48
INC0248074 BP 4/3/2015              172        16           110        49
INC0248074 BP 4/3/2015              172        16           110        50
INC0248074 BP 4/3/2015              172        16           110        51
INC0248074 BP 4/3/2015              172        16           110        52
INC0248074 BP 4/3/2015              172        16           110        53
INC0248074 BP 4/3/2015              172        16           110        54
```

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

### Working on cluster concept - thinking of a group of machines as a configuration unit
* https://gist.github.com/anonymous/5e1f88c5acc0dc699093

# Development Notes

## Getting things working on RHEL6
* Needed to disable selinux
* sshd_config has an allowgroups directive sshlogin... disabled to get working
* some changes to install_master, yum repos are behaving slightly differently than centos
* CVC RHEL boxes ship with ksh as default shell, change?
* not sure procedure to add user to box, and what sudoer groups make sense (aside from the admin sudo group we create), instead running as root until fix
* changed visudo validation to fully qualified path
