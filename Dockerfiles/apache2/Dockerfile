FROM php:7.0-apache

WORKDIR /var/www/html
COPY ./web/. .

RUN a2enmod rewrite

CMD service apache2 restart

EXPOSE 80
