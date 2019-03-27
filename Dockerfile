FROM php:7.1-apache
MAINTAINER Alexander Postol <grief.north at gmail dot com>

# internal variables
ENV HTML_DIR /var/www/html
ENV FULL_BUILDS_DIR $HTML_DIR/builds/full

# set the working directory
WORKDIR $HTML_DIR

# install ssl cert 
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ssl-cert-snakeoil.key -out /etc/ssl/certs/ssl-cert-snakeoil.pem -subj "/C=RU/ST=Penzenskaya/L=Penza/O=Security/OU=Development/CN=example.com"

# enable mod_rewrite
RUN a2enmod rewrite
RUN a2ensite default-ssl
RUN a2enmod ssl

# install the PHP extensions we need
RUN apt-get update \
        && buildDeps=" \
                zlib1g-dev \
        " \
        && apt-get install -y git $buildDeps --no-install-recommends \
        && rm -r /var/lib/apt/lists/* \
        \
        && docker-php-ext-install zip \
        \
        && pecl install apcu \
        && docker-php-ext-enable apcu \
        \
        && docker-php-source delete \
        && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps

# set recommended settings for APCu
# see http://php.net/manual/en/apcu.configuration.php
RUN { \
    echo 'apc.ttl=7200'; \
  } > /usr/local/etc/php/conf.d/opcache-recommended.ini

# install latest version of composer
ADD https://getcomposer.org/composer.phar /usr/local/bin/composer
RUN chmod 0755 /usr/local/bin/composer

# add all the project files
COPY . $HTML_DIR

# enable indexing for Apache
RUN sed -i "1s;^;Options +Indexes\n\n;" .htaccess

# install dependencies
RUN composer install --no-plugins --no-scripts

# fix permissions
RUN chmod -R 0775 /var/www/html \
    && chown -R www-data:www-data /var/www/html

# create volumes
VOLUME $FULL_BUILDS_DIR

EXPOSE 80
EXPOSE 443