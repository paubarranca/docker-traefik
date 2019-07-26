FROM php:7.0-apache

WORKDIR /var/www/html
COPY ./web/. .

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data

CMD ["apachectl", "-D", "FOREGROUND"]

EXPOSE 80
