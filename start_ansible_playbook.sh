#!/bin/bash
yum -y install cryptopp turnserver sudo cyrus-sasl-plain nodejs mutt mc net-tools openssh-server openssh-clients
test ! -d /opt/rmps && mkdir /opt/rpms
mv /tmp/*.rpm /opt/rpms/
yum -y install /opt/rpms/*.rpm
ansible-playbook /opt/server_playbook.yml -c local -k -vvv
