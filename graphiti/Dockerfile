# Dockerized Graphiti service, running under Supervisord
# (docker.io: morriz/graphiti)
#
# Adapted from: https://github.com/nickstenning/dockerfiles/tree/master/graphiti
#
# VERSION 0.0.1

FROM ubuntu:12.04

MAINTAINER Maurice Faber "morriz@idiotz.nl"

run	echo 'deb http://us.archive.ubuntu.com/ubuntu/ precise universe' >> /etc/apt/sources.list
run	apt-get -y update

# Install Git and Ruby
RUN	apt-get -y install ruby1.9.1 ruby1.9.1-dev git supervisor redis-server build-essential libcurl4-openssl-dev
RUN	gem install bundler

# Install Graphiti
RUN	git clone https://github.com/paperlesspost/graphiti.git /usr/local/src/graphiti
RUN	cd /usr/local/src/graphiti && bundle install --deployment --without 'test development'

# Install OpenSSH
RUN apt-get -y install openssh-server
RUN mkdir /var/run/sshd
RUN /usr/sbin/sshd
RUN sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd
RUN /bin/echo -e "LANG=\"en_US.UTF-8\"" > /etc/default/local

# set root password
RUN echo "root:root" | chpasswd

# Add startup stuff
ADD	/config /usr/local/src/graphiti/config
ADD /etc/supervisor/conf.d/graphiti.conf /etc/supervisor/conf.d/
ADD /etc/supervisor/conf.d/redis.conf /etc/supervisor/conf.d/
ADD /etc/supervisor/conf.d/sshd.conf /etc/supervisor/conf.d/
ADD /root/start/graphiti.sh /root/start/
RUN chmod u+x /root/start/*

EXPOSE 22 6379 8080

CMD	["/usr/bin/supervisord", "-n"]
