#!/bin/sh

# fail when we don't know where to send to
[ -z "$LOGSTASH_HOST" ] && exit 1
[ -z "$LOGSTASH_PORT" ] && LOGSTASH_PORT="514"

echo "*.* @@$LOGSTASH_HOST:$LOGSTASH_PORT" >> /etc/rsyslog.d/50-default.conf

/usr/sbin/rsyslogd -n -c5