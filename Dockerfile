FROM node:6.12-wheezy
FROM mongo:latest

LABEL version="1.0"
LABEL description="Docker Image For Andela Microsoft Screening Test"
LABEL maintainer "Goodness Kayode <gtkbrain@gmail.com>"

RUN mkdir -p /usr/src/user-manager
WORKDIR /usr/src/user-manager

RUN mkdir -p /data/db2 \
    && echo "dbpath = /data/db2" > /etc/mongodb.conf \
    && chown -R mongodb:mongodb /data/db2

COPY ["package.json", "./"]
COPY . /data/db2

ENV NODE_ENV production

RUN npm install

RUN cd /usr/src/user-manager && npm run


RUN mongod --fork --logpath /var/log/mongodb.log --dbpath /data/db2 --smallfiles \
    && CREATE_FILES=/data/db2/scripts/*-create.js \
    && for f in $CREATE_FILES; do mongo 127.0.0.1:27017 $f; done \
    && INSERT_FILES=/data/db2/scripts/*-insert.js \
    && for f in $INSERT_FILES; do mongo 127.0.0.1:27017 $f; done \
    && mongod --dbpath /data/db2 --shutdown \
    && chown -R mongodb /data/db2


VOLUME /data/db2

COPY . .

EXPOSE 1337

CMD ["mongod", "--config", "/etc/mongodb.conf", "--smallfiles"]

