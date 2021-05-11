FROM php:7.3-fpm-alpine

WORKDIR /app

# Get latest Composer and set composer bin into path
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apk update && \
    # Install node and git
    apk add --no-cache nodejs npm git && \
    npm i -g yarn && \ 
    # its necessary to build nova cards
    apk add --no-cache libpng-dev bash gcc make musl-dev \
    # INSTALL PHP EXTENCIONS
    # dependences for extencions:
    # dependences for zip
    libzip-dev \
    # dependences for xml
    libxml2-dev \
    # dependences for intl
    icu-dev \
    #dependences for gd
    freetype-dev libjpeg-turbo-dev && \
    # CONFIGURE extencions
    docker-php-ext-configure intl && \
    docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg && \
    # INSTALL EXTENCIONS
    docker-php-ext-install zip \
    bcmath \
    mysqli \
    pdo_mysql \
    exif \
    gd \
    intl