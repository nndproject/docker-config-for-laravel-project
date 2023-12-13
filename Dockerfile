# Use the official Alpine image as a base image
FROM alpine:3.14

RUN echo "UTC" > /etc/timezone

# Install necessary packages
RUN apk --update --no-cache add \
    nginx \
    php7 \
    php7-fpm \
    php7-mysqli \
    php7-json \
    php7-session \
    #mariadb \
    #mariadb-client \
    php7-mbstring \
    php7-common \
    php7-opcache \
    php7-gd \
    php7-curl \
    php7-ctype \
    php7-zlib \
    php7-iconv \
    php7-xml \
    php7-dom \
    php7-mcrypt \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-tokenizer \
    php7-xmlwriter \
    php7-xmlreader \
    php7-simplexml \
    php7-fileinfo \
    php7-bcmath \
    php7-xmlrpc \
    php7-intl \
    php7-ldap \
    php7-pear \
    php7-phar \
    php7-openssl \
    php7-memcached \
    php7-imagick\
    #php7-pecl-apcu \
    #php7-pecl-redis \
    #git \
    composer \
    supervisor 

# Create necessary directories
RUN mkdir -p /run/nginx

# Copy Nginx configuration
COPY docker-conf/nginx/nginx.conf /etc/nginx/nginx.conf

# Copy PHP configuration
COPY docker-conf/php/php.ini /etc/php7/php.ini

# Copy supervisor configuration
COPY docker-conf/supervisord.conf /etc/supervisord.conf

# Copy entrypoint script
COPY docker-conf/entrypoint.sh /entrypoint.sh

# Grant execution permission to entrypoint script
RUN chmod +x /entrypoint.sh

# Expose ports
EXPOSE 80

# Set the entrypoint command to start supervisor
CMD ["/entrypoint.sh"]