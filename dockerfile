# FROM php:8.1-fpm-alpine

# WORKDIR /var/www/html

# # Install Nginx
# #RUN  apt-get install -y nginx 

# # Configure Nginx
# #RUN rm /etc/nginx/sites-available/default
# #ADD nginx/default.conf /etc/nginx/sites-available/default

# # Install additional PHP extensions if needed
# # For example, to enable pdo_mysql extension:
# #RUN docker-php-ext-install pdo_mysql

# COPY --chown=www-data:www-data . .


# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# RUN composer install --no-interaction

# RUN mkdir -p /var/www/html/public
# RUN ln -s /var/www/html/vendor/bin/phpunit /usr/bin/phpunit


# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]


FROM php:8.2.4-apache

RUN apt-get update && \
    apt-get install -y \
        libicu-dev \
        libonig-dev \
        libzip-dev \
        unzip

RUN docker-php-ext-install \
    intl \
    mbstring \
    pdo \
    mysqli \
    pdo_mysql \
    zip

RUN a2enmod rewrite

COPY . /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY composer.* /var/www/html/

RUN composer install --no-autoloader

COPY . /var/www/html/

EXPOSE 80

CMD ["apache2-foreground"]