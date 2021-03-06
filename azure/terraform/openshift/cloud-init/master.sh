# Author: SAVITHRU LOKANATH
# Contact: SAVITHRU AT ICLOUD DOT COM
# Copyright (c) 2018 Juniper Networks, Inc. All rights reserved

#!/bin/sh

# Set SSH password, keyless SSH, stat hosts & install base packages

set -eux

sudo -u root bash << EOF
sed -i -e 's/#PermitRootLogin yes/PermitRootLogin yes/g' -e 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config 
service sshd restart
echo root:$1 | chpasswd
subscription-manager register --username $2 --password $3 --force
yum update -y
yum install wget git python-netaddr -y && wget -O /tmp/epel-release-latest-7.noarch.rpm https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && rpm -ivh /tmp/epel-release-latest-7.noarch.rpm
git clone https://github.com/savithruml/openshift-ansible -b contrail-openshift
