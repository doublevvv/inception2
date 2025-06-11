# #!/bin/bash

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    mariadb_upgrade --user=mysql --datadir=/var/lib/mysql
    mysql_install_db
    service mariadb start
    mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}"
    mariadb -u root -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWD}';"
    mariadb -u root -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWD}';"
    mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWD}';"
    mariadb -u root -e "FLUSH PRIVILEGES;"
    mysqladmin -u root -p$MYSQL_ROOT_PASSWD shutdown
    service mariadb stop

fi

    exec mariadbd 