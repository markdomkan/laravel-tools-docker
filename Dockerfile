ARG PHP_VERSION

FROM node:14-alpine AS node

FROM php:${PHP_VERSION}-fpm-alpine

WORKDIR /app

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=node /opt /opt

# Get latest Composer and set composer bin into path
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apk update && \
    # Install openssh and git
    apk add --no-cache git openssh && \
    # its necessary to build nova cards
    apk add --no-cache libpng-dev bash g++ make zlib-dev python2 \
    # INSTALL PHP EXTENCIONS
    # dependences for extencions:
    # dependences for zip
    libzip-dev \
    # dependences for xml
    libxml2-dev \
    # dependences for intl
    icu-dev \
    #dependences for gd
    freetype-dev libjpeg-turbo-dev  && \
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
    intl && \ 
    sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
    sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd
