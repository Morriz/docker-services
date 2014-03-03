#!/bin/bash

# override default manager user/pass if wanted
[ -z "$DEPLOY_USER" ] && DEPLOY_USER="deploy"
[ -z "$DEPLOY_PASS" ] && DEPLOY_PASS="deploy"

sed -i "/\/tomcat-users/s#.*#<role rolename=\"manager\"/>\n<role rolename=\"manager-gui\"/>\n<role rolename=\"manager-status\"/>\n<role rolename=\"manager-script\"/>\n<user username=\"$DEPLOY_USER\" password=\"$DEPLOY_PASS\" roles=\"manager,manager-gui,manager-status,manager-script\"/>\n</tomcat-users>#" /etc/tomcat7/tomcat-users.xml

service tomcat7 start