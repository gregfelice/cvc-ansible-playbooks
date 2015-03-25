#!/bin/bash

# install epel
sudo yum install -q -y epel-release

# install ansible 1.8
sudo yum install -q -y ansible

# install sshpass
sudo yum install -q -y sshpass

# ok - permission denied on the ansible folders. need to get access to them... thnking... 

# generate ansible keypair
if sudo [ -f ~ansible/.ssh/id_rsa ] 
then
    echo "keypair already exists for ansible, doing nothing."
else
    echo "creating keypair for ansible."
    sudo -u ansible -s /usr/bin/ssh-keygen -q -t rsa -C ansible@cablevision.com  -f /tmp/id_rsa
    sudo mv /tmp/id_rsa ~ansible/.ssh
    sudo mv /tmp/id_rsa.pub ~ansible/.ssh
fi

# generate keypair for me, which will be added to the authorized_keys for ansible account
if [ -f ~/.ssh/id_rsa ] 
then
    echo "keypair already exists for `whoami`, doing nothing."
else
    echo "creating keypair for `whoami`"
    myemail="`whoami`@cablevision.com"
    ssh-keygen -t rsa -C $myemail
fi


