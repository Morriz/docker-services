#!/bin/sh

# we will want to do service discovery at some point
[ -z "$GRAPHITE_HOST" ] && GRAPHITE_HOST=localhost
[ -z "$GRAPHITE_PORT" ] && GRAPHITE_PORT=8080

CONF=/usr/local/src/graphiti/config/settings.yml
sed -i "s/{GRAPHITE_HOST}/$GRAPHITE_HOST/g" $CONF
sed -i "s/{GRAPHITE_PORT}/$GRAPHITE_PORT/g" $CONF

cd /usr/local/src/graphiti
/usr/local/bin/bundle exec unicorn -c config/unicorn.rb -E production