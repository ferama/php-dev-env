FROM php:7.4-apache
RUN apt update \
    && apt install -y \
        unzip \
        zlib1g-dev \
        libzip-dev \
        libpng-dev

RUN a2enmod rewrite
RUN docker-php-ext-install zip gd
RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN sed -ri -e 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/g' /etc/apache2/sites-available/000-default.conf
RUN sed -ri -e 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf

ENV APACHE_DOCUMENT_ROOT /var/www/html
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

ENV HOME /var/www/html
EXPOSE 8080
VOLUME [ "/var/www/html" ]