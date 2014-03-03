# Docker base image for containerized services.
# (docker.io: morriz/service)
#
# VERSION 0.0.1

FROM stackbrew/ubuntu:13.10

MAINTAINER Maurice Faber "morriz@idiotz.nl"

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu saucy main universe" > /etc/apt/sources.list
RUN apt-get update && apt-get -y upgrade

# set root password
RUN echo "root:root" | chpasswd

RUN apt-get -y install supervisor openssh-server
RUN mkdir /var/run/sshd
RUN /usr/sbin/sshd
RUN sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd
RUN /bin/echo -e "LANG=\"en_US.UTF-8\"" > /etc/default/local

# Use some reporting/logging tools to report to master
RUN apt-get -y install collectd rsyslog
ADD /etc/collectd/collectd.conf /etc/collectd/

# Add additional packages
RUN apt-get -y install telnet rsync vim

# Add startup stuff
ADD /etc/supervisor/conf.d/collectd.conf /etc/supervisor/conf.d/
ADD /etc/supervisor/conf.d/docker.conf /etc/supervisor/conf.d/
ADD /etc/supervisor/conf.d/rsyslog.conf /etc/supervisor/conf.d/
ADD /etc/supervisor/conf.d/sshd.conf /etc/supervisor/conf.d/
ADD /root/start/collectd.sh /root/start/
ADD /root/start/rsyslog.sh /root/start/
RUN chmod -R u+x /root/start/*

EXPOSE 22

CMD ["/usr/bin/supervisord", "-n"]
