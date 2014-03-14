# Dockerized Tomcat 7 service, running under Supervisord
# (docker.io: morriz/tomcat)
#
# expects:
#   -e COLLECTD_HOST={HOST}
# optional:
#   -e DEPLOY_USER=... (default: deploy)
#   -e DEPLOY_PASS=... (default: deploy)
#   -e JAVA_OPTS="{JAVA_OPTS}"
# (example: "-Dcatalina.db.pass=somepass -Dcatalina.db.username=someuser -Dcatalina.db.url=jbc:mysql://1.2.3.4:5678/somedbname")
#
# VERSION 0.0.1

FROM morriz/service

MAINTAINER Maurice Faber "morriz@idiotz.nl"

# Install Tomcat
RUN apt-get install -y tomcat7 tomcat7-docs tomcat7-admin

# enable deployment

# copy startup scripts
RUN cp -r /usr/share/tomcat7/bin /var/lib/tomcat7

# Add startup stuff
ADD /etc/supervisor/conf.d/tomcat.conf /etc/supervisor/conf.d/
ADD /root/start/tomcat.sh /root/start/
RUN chmod u+x /root/start/tomcat.sh

EXPOSE 22 8080 8443 8998

VOLUME ["/var/lib/tomcat7/webapps"]

CMD ["/usr/bin/supervisord", "-n"]