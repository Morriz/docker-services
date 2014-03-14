#!/bin/sh

# fail when we don't know where to send to
[ -z "$LOGSTASH_HOST" ] && exit 1
[ -z "$LOGSTASH_PORT" ] && LOGSTASH_PORT="514"
sed -i "s/{LOGSTASH_HOST}/$LOGSTASH_HOST/g" /etc/rsyslog.d/50-default.conf
sed -i "s/{LOGSTASH_PORT}/$LOGSTASH_PORT/g" /etc/rsyslog.d/50-default.conf

/usr/sbin/rsyslogd -n -c5