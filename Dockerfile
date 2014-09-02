FROM ubuntu:latest
MAINTAINER B00stfr3ak

RUN apt-get update
RUN apt-get -y upgrade
RUN DEBIAN_FRONtEND=noninteractive sudo apt-get -y install \
build-essential libreadline-dev libssl-dev libpq5 libpq-dev \
libreadline5 libsqlite3-dev libpcap-dev openjdk-7-jre \
subversion git-core autoconf postgresql pgadmin3 curl \
zlib1g-dev libxml2-dev libxslt1-dev vncviewer libyaml-dev \
ruby1.9.3 ruby-dev
RUN gem install wirble sqlite3 bundler

RUN useradd dev
RUN mkdir /home/dev && chown -R dev: /home/dev
WORKDIR /home/dev
ENV HOME /home/dev

RUN mkdir /home/dev/development
ADD script.sh /home/dev/development/
RUN chmod +x /home/dev/development/script.sh
RUN /home/dev/development/script.sh
ADD database.yml /opt/metasploit-framework/config/

ADD startup.sh /home/dev/
RUN chmod +x /home/dev/startup.sh

USER postgres

RUN /etc/init.d/postgresql start && \
    psql --command "CREATE USER msf WITH PASSWORD 'msf';" && \
    createdb -O  msf msf

USER root

CMD bash -c '/home/dev/startup.sh';'bash'
