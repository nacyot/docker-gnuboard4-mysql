#/bin/bash

# start mysql 
/usr/bin/mysqld_safe &
sleep 3
echo "CREATE USER 'gnuboard'@'localhost' IDENTIFIED BY 'gnub0ard';" | mysql
echo "CREATE DATABASE gnuboard;" | mysql
echo "GRANT ALL PRIVILEGES ON gnuboard.* TO 'gnuboard'@'localhost' WITH GRANT OPTION;" | mysql

# start apache2
/usr/sbin/apache2 -D FOREGROUND
