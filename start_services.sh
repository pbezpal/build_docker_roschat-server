#!/bin/bash

systemctl start mariadb
systemctl start turnserver
systemctl start kamailio
systemctl start rtpengine
systemctl start wlan
systemctl start roschat-db
systemctl start roschat-ms
systemctl start sshd
