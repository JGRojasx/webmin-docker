#!/bin/bash

/etc/init.d/webmin start
PID=$(< /var/webmin/miniserv.pid)
tail --pid=$PID -f /var/webmin/miniserv.error
