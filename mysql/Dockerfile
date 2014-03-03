# Dockerized MySQL service, running under Supervisord
# (docker.io: morriz/mysql)
#
# expects:
#   -e COLLECTD_HOST={HOST}
#
# VERSION 0.0.1

FROM morriz/service

MAINTAINER Maurice Faber "morriz@idiotz.nl"

# Install MySQL
RUN echo mysql-server mysql-server/root_password password root | debconf-set-selections
RUN echo mysql-server mysql-server/root_password_again password root | debconf-set-selections
RUN apt-get -y install mysql-server

# add some stuff to play nicely with docker
ADD /etc/mysql/conf.d/docker.cnf /etc/mysql/conf.d/

# Add startup stuff
ADD /etc/supervisor/conf.d/mysql.conf /etc/supervisor/conf.d/

EXPOSE 22 3306

VOLUME ["/var/lib/mysql"]

CMD ["/usr/bin/supervisord", "-n"]