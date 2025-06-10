#!/bin/bash

if [ ! -f "/var/lib/mysql/$MYSQL_DATABASE"]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    mariadb start
    mariad -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
    mariad -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mariad -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
    mariad -e "FLUSH PRIVILEGES;"
    # mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
    # exec mysqld_safe
    mariadb stop

    fi
    env
    exec mariadbd --datadir=/var/lib/mysql

 
 