#!/bin/bash

sed -i -e "s/%AUTH_PASSWORD%/${AUTH_PASSWORD}/" /var/lib/bitlbee/etc/bitlbee.conf
sed -i -e "s/%OPER_PASSWORD%/${OPER_PASSWORD}/" /var/lib/bitlbee/etc/bitlbee.conf

exec bitlbee -n
