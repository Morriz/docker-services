# Dockerized Descartes service, running under Supervisord
# (docker.io: morriz/descartes)
#
# TODO: move Redis and PostgresSQL to their own container
#
# VERSION 0.0.1

FROM morriz/service

MAINTAINER Maurice Faber "morriz@idiotz.nl"

# Install PostgreSQL
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update
RUN apt-get -y install postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Install Ruby
RUN	apt-get -y install curl # openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 1.9.2"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# Install Descartes
RUN apt-get -y install git-core
RUN	git clone https://github.com/obfuscurity/descartes.git /usr/local/src/descartes
ADD	/.env /usr/local/src/descartes/
RUN echo `which bundle`
RUN	cd /usr/local/src/descartes && bundle install
RUN createdb descartes
RUN bundle exec rake db:migrate:up

# Add startup stuff
ADD	/.env /usr/local/src/descartes/
ADD	/config /usr/local/src/descartes/config
ADD /etc/supervisor/conf.d/descartes.conf /etc/supervisor/conf.d/
ADD /etc/supervisor/conf.d/postgresql.conf /etc/supervisor/conf.d/
ADD /etc/supervisor/conf.d/redis.conf /etc/supervisor/conf.d/
ADD /etc/supervisor/conf.d/sshd.conf /etc/supervisor/conf.d/
ADD /root/start/descartes.sh /root/start/
ADD /root/start/postgresql.sh /root/start/
RUN chmod u+x /root/start/*

EXPOSE 22 5432 6379 8080

VOLUME ["/var/lib/postgresql"]

CMD	["/usr/bin/supervisord", "-n"]
