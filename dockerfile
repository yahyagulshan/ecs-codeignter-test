FROM php:8.1-fpm-alpine

WORKDIR /var/www/html

# Install Nginx
RUN apt-get update \
    && apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/*

# Configure Nginx
RUN rm /etc/nginx/sites-available/default
ADD nginx/default.conf /etc/nginx/sites-available/default

# Install additional PHP extensions if needed
# For example, to enable pdo_mysql extension:
RUN docker-php-ext-install pdo_mysql

COPY --chown=www-data:www-data . .


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install --no-interaction

RUN mkdir -p /var/www/html/public
RUN ln -s /var/www/html/vendor/bin/phpunit /usr/bin/phpunit

EXPOSE 80


# Start PHP-FPM and Nginx
CMD service php8.1-fpm start && nginx -g 'daemon off;'