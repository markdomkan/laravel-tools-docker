FROM php:8.0-fpm-alpine

# Get latest Composer and set composer bin into path
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN echo "export PATH=$PATH:~/.composer/vendor/bin \r" >> ~/.bashrc && \
    # Install node and git
    apk add --no-cache nodejs npm git && \
    npm i -g yarn && \ 
    # its necessary to nova cards
    apk add --no-cache libpng-dev && \
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
    intl && \
    # Remove builder depencences
    apk del --no-cache autoconf make g++ && \
    #CONFIGS
    # Create App user
    adduser -u 1000 -G root -D app && \
    mkdir /app && \
    chown -R app /app

USER app

WORKDIR /app

