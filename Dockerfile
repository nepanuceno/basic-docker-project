FROM php:8.4-fpm

ARG user=paulo
ARG uid=1000

# RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories
# RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories

# installing required extensions
# RUN apk update && \
#     apk add bash build-base gcc wget git autoconf libmcrypt-dev libzip-dev zip \
#     g++ make openssl-dev \
#     php81-openssl


RUN apt-get update && apt-get install -y \
    git \
    curl \
    libmcrypt-dev \
    libssl-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    openssl

# RUN pecl install mcrypt-1.0.7 && \
#     docker-php-ext-enable mcrypt

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# RUN pecl install xdebug
# RUN docker-php-ext-enable xdebug

# Configure Xdebug
# RUN echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.mode=develop,coverage,debug,gcstats,profile,trace" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.log=/var/www/html/xdebug/xdebug.log" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.discover_client_host=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.client_port=9000" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "error_reporting=E_ALL" >> /usr/local/etc/php/conf.d/error_reporting.ini

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# RUN useradd -G www-data, root -u $uid -d /home/$user $user
# RUN mkdir -p /home/$user/.composer && \
#     chmod -R $user:$user /home/$user

WORKDIR /var/www
