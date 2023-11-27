FROM php:8.1-fpm-alpine

WORKDIR /var/www/html

COPY --chown=www-data:www-data . .

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install --no-interaction

RUN mkdir -p /var/www/html/public
RUN ln -s /var/www/html/vendor/bin/phpunit /usr/bin/phpunit

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]