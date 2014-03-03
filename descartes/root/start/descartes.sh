#!/bin/sh

# fail when we don't know where to get data from
[ -z "$GRAPHITE_HOST" ] && exit 1
[ -z "$GRAPHITE_PORT" ] && GRAPHITE_PORT=8080

CONF=/usr/local/src/graphiti/config/settings.yml
sed -i "s/{GRAPHITE_HOST}/$GRAPHITE_HOST/g" $CONF
sed -i "s/{GRAPHITE_PORT}/$GRAPHITE_PORT/g" $CONF

cd /usr/local/src/descartes
foreman start
