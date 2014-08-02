FROM node
MAINTAINER Dmitriy Nesteryuk "nesterukd@gmail.com"

RUN bash -c '\
  echo "# Installing Hubot" ;\
  npm install -g hubot coffee-script ;\
  mkdir /hubot && cd /hubot ;\
  hubot --create . ;\
  chmod 755 bin/hubot ;\
  bin/hubot -h ;\
  \
  echo "# Cleaning up" ;\
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /setup /build ;\
  \
  npm install ;\
'
# END RUN

# ADD src/redis.sh /etc/service/redis/run
ADD src/external-scripts.json /hubot/external-scripts.json
ADD src/package.json /hubot/package.json

VOLUME ["/hubot"]

WORKDIR /hubot

ENTRYPOINT "bin/hubot"
CMD "-a gtalk-gluck"