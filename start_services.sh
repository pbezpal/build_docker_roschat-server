#!/bin/bash

systemctl start mariadb
systemctl start turnserver
systemctl start kamailio
systemctl start rtpengine
systemctl start wlan
systemctl start roschat-db
systemctl start roschat-ms
systemctl start snmpd
systemctl start roschat-snmp
systemctl start sshd
systemctl start kms
