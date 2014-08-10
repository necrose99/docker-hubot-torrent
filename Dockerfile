From ubuntu:trusty
MAINTAINER Dmitriy Nesteryuk "nesterukd@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get -y install transmission-daemon
RUN apt-get -y install redis-server
RUN apt-get -y install nodejs npm
RUN apt-get -y install git-core build-essential supervisor

RUN npm install -g hubot coffee-script
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN mkdir /hubot && cd /hubot && hubot --create .

# Supervisor
RUN install -d /etc/supervisor ; install -d /etc/supervisor/conf.d
ADD src/supervisord.conf /etc/supervisor/supervisord.conf

# Remove things for building modules
#RUN apt-get remove -y manpages manpages-dev g++ gcc cpp make python-software-properties #unattended-upgrades ucf

ADD src/external-scripts.json /hubot/external-scripts.json
ADD src/package.json /hubot/package.json
ADD src/run.sh /hubot/run.sh

RUN chmod a+x /hubot/run.sh

RUN cd /hubot && npm install

VOLUME ["/hubot"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]