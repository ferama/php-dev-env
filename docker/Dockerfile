FROM php:7.4-apache
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        unzip \
        zlib1g-dev \
        libzip-dev \
        libpng-dev \
        libxml2-dev \
        libmagickwand-dev \
        wget \
        git 

RUN pecl install \
    imagick

RUN docker-php-ext-enable imagick

RUN docker-php-ext-install \
    zip \
    gd \
    mysqli \
    pdo \
    pdo_mysql \
    soap
RUN docker-php-ext-install intl gmp

RUN a2enmod rewrite

RUN sed -ri -e 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/g' /etc/apache2/sites-available/000-default.conf
RUN sed -ri -e 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf

ENV APACHE_DOCUMENT_ROOT /var/www/html
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

ADD setup-composer.sh /
RUN cd / && ./setup-composer.sh && rm /setup-composer.sh
# RUN mkdir /tmp/home
# ENV HOME /tmp/home
EXPOSE 8080
VOLUME [ "/var/www/html" ]