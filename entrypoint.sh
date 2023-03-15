#!/bin/bash

# replace SS_PASSWORD, SS_METHOD  and KCP_PORT in supervisord.conf with env variable
sed -i "s/SS_PASSWORD/$SS_PASSWORD/g" /etc/supervisor/conf.d/supervisord.conf
sed -i "s/SS_METHOD/$SS_METHOD/g" /etc/supervisor/conf.d/supervisord.conf
sed -i "s/KCP_PORT/$KCP_PORT/g" /etc/supervisor/conf.d/supervisord.conf

# start supervisord
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
