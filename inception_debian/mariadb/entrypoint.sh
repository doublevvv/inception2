# #!/bin/bash

# # if [ ! -f "/var/lib/myMYsql/$MYSQL_DATABASE"]; then
#     # mariadb_upgrade --user=mysql --datadir=/var/lib/mysql
#     mysql_install_db
#     mariadb start
#     mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}"
#     mariadb -u root -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWD}';"
#     mariadb -u root -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWD}';"
#     mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWD}';"
#     mariadb -u root -e "FLUSH PRIVILEGES;"
#     mysqladmin -u root -p $SQL_ROOT_PASSWORD shutdown
#     # mariadb stop

#     exec mariadbd 

 
 !/bin/bash

mysql_install_db
service mariadb start
mysql_secure_installation << EOF

n
n
n
y
n
y
y
EOF
# sed -i 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}"
mariadb -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWD}'"
mariadb -u root -e "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mariadb -u root -e "FLUSH PRIVILEGES;"
mysqladmin shutdown -u root 
mariadbd