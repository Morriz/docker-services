#!/bin/sh

# fail when we don't know where to report to
[ -z "$COLLECTD_HOST" ] && exit 1
[ -z "$COLLECTD_PORT" ] && COLLECTD_PORT="25826"
sed -i "s/{COLLECTD_HOST}/$COLLECTD_HOST/g" /etc/collectd/collectd.conf
sed -i "s/{COLLECTD_PORT}/$COLLECTD_PORT/g" /etc/collectd/collectd.conf

collectd -C /etc/collectd/collectd.conf -f