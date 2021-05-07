# Container with all necessary to build and test laravel

This image contains a all necessary to build and test laravel framework.

Some of these libs are necessary for build laravel nova tools.

- **php**: 8.0
- **node**: 14.16 with **yarn**
- sh, bash
- some libs:
    - make
    - libpng-dev
    - gcc
    - musl-dev 
- php extensions:
    - intl 
    - zip
    - bcmath
    - mysqli
    - pdo_mysql
    - exif

- default user: **app** *(nonroot user)*
