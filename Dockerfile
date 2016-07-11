FROM nginx

COPY ./public /web
COPY nginx/nginx.conf /etc/nginx/nginx.conf
