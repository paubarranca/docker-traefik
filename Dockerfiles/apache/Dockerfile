FROM php:7.0-apache

RUN a2enmod rewrite \
    && apt-get install build-essential libtool

CMD service apache2 start

EXPOSE 80
