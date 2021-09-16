ARG PHP_VERSION

FROM php:${PHP_VERSION}-fpm-alpine

WORKDIR /app

# Get latest Composer and set composer bin into path
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apk update && \
    # Install node and git
    apk add --no-cache nodejs npm git && \
    npm i -g yarn && \ 
    # its necessary to build nova cards
    apk add --no-cache libpng-dev bash g++ make zlib-dev \
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
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    # INSTALL EXTENCIONS
    docker-php-ext-install zip \
    bcmath \
    mysqli \
    pdo_mysql \
    exif \
    gd \
    intl && \
    sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" && \
    sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd
