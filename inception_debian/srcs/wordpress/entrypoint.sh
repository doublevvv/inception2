#! /bin/bash

mkdir -p /run/php

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

cd /var/www/html
chmod -R 755 /var/www/html

wp core download --allow-root 

wp config create \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_ROOT_PASSWD} \
        --dbhost=${WORDPRESS_DB_HOST} --allow-root 

wp core install \
        --url=${DOMAIN_NAME} \
        --title=${DOMAIN_NAME} \
        --admin_user=${ADMIN_USER} \
        --admin_password=${ADMIN_PASSWD} \
        --admin_email=${ADMIN_MAIL} \
        --path="/var/www/html" --allow-root 

wp user create ${ADMIN_USER} ${ADMIN_MAIL} \
    --user_pass=${ADMIN_PASSWD} \
    --role=author --allow-root

chown -R www-data:www-data /var/www/html

exec /usr/sbin/php-fpm7.4 --nodaemonize -F

