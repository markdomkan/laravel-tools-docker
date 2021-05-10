FROM php:8.0-fpm-alpine

WORKDIR /app

# Get latest Composer and set composer bin into path
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install node and git
RUN apk add --no-cache nodejs npm git && \
    npm i -g yarn && \ 
    # its necessary to build nova cards
    apk add --no-cache libpng-dev bash gcc make musl-dev && \
    # INSTALL PHP EXTENCIONS
    # dependences for extencions
    apk add --no-cache \
    # dependences for zip
    libzip-dev \
    # dependences for xml
    libxml2-dev \
    # dependences for intl
    icu-dev && \
    # CONFIGURE
    docker-php-ext-configure intl && \
    # INSTALL EXTENCIONS
    docker-php-ext-install zip \
    bcmath \
    mysqli \
    pdo_mysql \
    exif \
    intl