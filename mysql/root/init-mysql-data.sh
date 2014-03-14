#!/bin/sh
#
# Run this script as root to setup a clean mysql database environment
chown -R mysql:mysql /var/lib/mysql
mysql_install_db
service mysql start
mysqladmin -u root password 'root'
// allow root access from outside as well
echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql -u root -proot -hlocalhost

