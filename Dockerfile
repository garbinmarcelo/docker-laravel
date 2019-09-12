FROM php:7.3.9-fpm-alpine3.10
RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www
RUN rm -rf /var/www/html

COPY . /var/www
RUN ln -s public html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install && \
        cp .env.example .env && \
        php artisan key:generate && \
        php artisan config:cache

EXPOSE 9000
ENTRYPOINT ["php-fpm"]
