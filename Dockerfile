FROM nginx

COPY ./public /var/www/web
COPY nginx/nginx.conf /etc/nginx/nginx.conf
