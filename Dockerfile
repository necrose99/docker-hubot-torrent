# MAINTAINER Dmitriy Nesteryuk "nesterukd@gmail.com" 
# to do /dev-haskell/cabal-install https://github.com/neurogeek/g-npm
# ENV DEBIAN_FRONTEND noninteractive rather use Sabayon/Gentoo  https://github.com/wking/dockerfile/
ENV HUBOT_DOWNLOAD_DIR /hubot_data
FROM sabayon/gentoo-stage3-base-amd64
FROM ${NAMESPACE}/gentoo-syslog:${TAG}
MAINTAINER ${MAINTAINER}
#VOLUME ["${PORTAGE}:/usr/portage:ro", "${PORTAGE}/distfiles:/usr/portage/distfiles:rw"]
RUN echo 'USE="${USE} npm"' >> /etc/portage/make.conf
RUN emerge -v net-libs/nodejs
RUN eselect news read new
FROM ${NAMESPACE}/gentoo-node:${TAG}
MAINTAINER ${MAINTAINER}
#VOLUME ["${PORTAGE}:/usr/portage:ro", "${PORTAGE}/distfiles:/usr/portage/distfiles:rw"]
RUN emerge -v dev-vcs/git
RUN eselect news read new
RUN npm install -g hubot coffee-script
RUN hubot --create hubot
RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "redis": "0.8.4",/' hubot/package.json
RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "hubot-irc": "0.2.1",/' hubot/package.json

RUN sed -i 's/\]$/,\n "github-commit-link.coffee"]/' hubot/hubot-scripts.json
RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\1  "githubot": "0.4.x",/' hubot/package.json

RUN sed -i 's/\]$/,\n "github-commits.coffee"]/' hubot/hubot-scripts.json
RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "url": "",/' hubot/package.json
RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "querystring": "",/' hubot/package.json
RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "gitio2": "2.0.0",/' hubot/package.json

RUN sed -i 's/\]$/,\n "github-issue-link.coffee"]/' hubot/hubot-scripts.json
#RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "githubot": "0.4.x",/' hubot/package.json

RUN sed -i 's/\]$/,\n "github-issues.coffee"]/' hubot/hubot-scripts.json
RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "underscore": "1.3.3",/' hubot/package.json
RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "underscore.string": "2.1.1",/' hubot/package.json
#RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "githubot": "0.4.x",/' hubot/package.json

RUN sed -i 's/\]$/,\n "github-pull-request-notifier.coffee"]/' hubot/hubot-scripts.json
#RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "url": "",/' hubot/package.json
#RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "querystring": "",/' hubot/package.json

RUN sed -i 's/\]$/,\n "logger.coffee"]/' hubot/hubot-scripts.json
#RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "redis": ">=0.7.2",/' hubot/package.json
RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "moment": ">=1.7.0",/' hubot/package.json
RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "connect": ">=2.4.5",/' hubot/package.json
RUN sed -i 's/\([[:space:]]*\)\("dependencies": {\)/\1\2\n\1  "connect_router": "*",/' hubot/package.json

RUN cd hubot && npm install
RUN git clone git://github.com/jenrzzz/hubot-logger.git && cp hubot-logger/logger.coffee hubot/node_modules/hubot-scripts/src/scripts/

CMD cd hubot && REDIS_URL="${REDIS_PORT}" LOG_REDIS_URL="${REDIS_PORT}" PORT=80 exec bin/hubot --name "${HUBOT_IRC_NICK:-hubot}" -a irc
EXPOSE 80
EXPOSE 8000


RUN apt-get update

RUN apt-get -y install transmission-daemon
RUN apt-get -y install redis-server
RUN apt-get -y install nodejs npm
RUN apt-get -y install git-core build-essential supervisor


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

VOLUME /hubot_data

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
