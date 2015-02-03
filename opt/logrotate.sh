#!/bin/bash

while true; do
  /usr/sbin/logrotate /etc/logrotate.conf
  sleep 3600
done
