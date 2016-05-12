FROM node:6

WORKDIR /var/www/web
ADD . /var/www/web

RUN npm install -g elm@0.17.0
