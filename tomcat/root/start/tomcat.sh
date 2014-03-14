#!/bin/bash

# override default manager user/pass if wanted
[ -z "$DEPLOY_USER" ] && DEPLOY_USER="deploy"
[ -z "$DEPLOY_PASS" ] && DEPLOY_PASS="deploy"

sed -i "/\/tomcat-users/s#.*#<role rolename=\"manager\"/>\n<role rolename=\"manager-gui\"/>\n<role rolename=\"manager-status\"/>\n<role rolename=\"manager-script\"/>\n<user username=\"$DEPLOY_USER\" password=\"$DEPLOY_PASS\" roles=\"manager,manager-gui,manager-status,manager-script\"/>\n</tomcat-users>#" /etc/tomcat7/tomcat-users.xml

JAVA_OPTS="-Xmx128m $JAVA_OPTS"
cat << EOF > tomcat-start.sh
/usr/lib/jvm/default-java/bin/java \
  $JAVA_OPTS \
  -Djava.util.logging.config.file=/var/lib/tomcat7/conf/logging.properties \
  -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager \
  -Djava.awt.headless=true -XX:+UseConcMarkSweepGC \
  -Djava.endorsed.dirs=/usr/share/tomcat7/endorsed \
  -classpath /usr/share/tomcat7/bin/bootstrap.jar:/usr/share/tomcat7/bin/tomcat-juli.jar \
  -Dcatalina.base=/var/lib/tomcat7 \
  -Dcatalina.home=/usr/share/tomcat7 \
  -Djava.io.tmpdir=/tmp/tomcat7-tomcat7-tmp \
  org.apache.catalina.startup.Bootstrap start
EOF
chmod u+x tomcat-start.sh
./tomcat-start.sh