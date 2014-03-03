#!/bin/sh

# our metrics collector
docker run -d -p 25826:25826/udp -p 8081:8080 -p 22 lopter/collectd-graphite

# our log friends
docker run -d -p 9200:9200 -p 9300:9300 arcus/elasticsearch
docker run -d -e ES_HOST=192.168.65.2 -e ES_PORT=9300 -p 514:514 arcus/logstash
docker run -d -e ES_HOST=192.168.65.2 -e ES_PORT=9200 -p 80:80 arcus/kibana

# our own services
docker run -d -p 2222:22 -e COLLECTD_HOST=192.168.65.2 -e LOGSTASH_HOST=192.168.65.2 morriz/mysql
docker run -d -p 2223:22 -e COLLECTD_HOST=192.168.65.2 -e LOGSTASH_HOST=192.168.65.2 \
  -e JAVA_OPTS="-Dcatalina.db.pass=c@shngo -Dcatalina.db.username=casengo -Dcatalina.db.url=jbc:mysql://192.168.65.2:3306/casengo" \
  -p 8080:8080 -p 8443:8443 morriz/tomcat