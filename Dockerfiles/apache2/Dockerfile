FROM php:7.0-apache

WORKDIR /var/www/html
COPY ./web/. .

RUN a2enmod rewrite

CMD ["apachectl", "-D", "FOREGROUND"]

EXPOSE 80
