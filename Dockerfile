FROM node:6.12-wheezy

LABEL version="1.0"
LABEL description="Docker Image For Andela Microsoft Screening Test"
LABEL maintainer "Goodness Kayode <gtkbrain@gmail.com>"

RUN mkdir -p /usr/src/user-manager
WORKDIR /usr/src/user-manager

COPY ["package.json", "./"]

ENV NODE_ENV production

RUN npm install

RUN cd /usr/src/user-manager && npm run

COPY . .

EXPOSE 1337

