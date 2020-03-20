FROM php:7.2.19-apache
# FROM php:7.4-apache
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        unzip \
        zlib1g-dev \
        libzip-dev \
        libicu-dev \
        libpng-dev \
        libxml2-dev \
        libmagickwand-dev \
        libgmp3-dev \
        wget \
        git 

RUN pecl install \
        imagick \
        #xdebug \
        # uuid \
        uopz 

RUN docker-php-ext-enable \
        imagick \
        #xdebug \
        # uuid \
        uopz

RUN docker-php-ext-configure intl

RUN docker-php-ext-install \
        zip \
        gd \
        mysqli \
        pdo \
        pdo_mysql \
        soap \
        intl \
        gmp \
        sockets

ADD setup-composer.sh /
RUN cd / && ./setup-composer.sh && rm /setup-composer.sh

RUN a2enmod rewrite
RUN set -ex \
       && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
       && sed -i 's/memory_limit = 128M/memory_limit = 2G/g' /usr/local/etc/php/php.ini

RUN sed -ri -e 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/g' /etc/apache2/sites-available/000-default.conf
RUN sed -ri -e 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf

ENV APACHE_DOCUMENT_ROOT /var/www/html
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

ENV HOME /var/www/html
EXPOSE 8080
VOLUME [ "/var/www/html" ]