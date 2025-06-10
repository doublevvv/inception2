#! /bin/bash

mkdir -p /run/php

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

cd /var/www/html

wp core download --allow-root --path=/var/www/html/wordpress

wp config create --allow-root \
        --dbname=${WORDPRESS_DB_NAME} \
        --dbuser=${WORDPRESS_DB_USER} \
        --dbpass=${WORDPRESS_DB_PASSWD} \
        --dbhost=${WORDPRESS_DB_HOST} \
        --dbprefix=wp_

wp core install --allow-root \
        --url=${DOMAIN_NAME} \
        --title=${DOMAIN_NAME} \
        --admin_user=${ADMIN_USER} \
        --admin_password=${ADMIN_PASSWD} \
        --admin_email=${ADMIN_MAIL}

chown -R www-data:www-data /var/www/html

exec /usr/sbin/php-fpm7.4 --nodaemonize -F

