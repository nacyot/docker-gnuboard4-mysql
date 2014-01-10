FROM ubuntu:12.04
MAINTAINER Daekwon Kim <propellerheaven@gmail.com>

# Run upgrades
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

# Install basic packages
RUN apt-get -qq -y install git curl build-essential

# Install Apache2
RUN apt-get -qq -y install apache2
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
RUN a2enmod rewrite 

# Install php
RUN apt-get -qq -y install php5
RUN apt-get -qq -y install libapache2-mod-php5 php5-mysql php5-gd

# Install Mysql
RUN apt-get -qq -y install mysql-server mysql-client libmysqlclient-dev
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Install Gnuboard4
RUN cd /tmp
RUN curl -o /tmp/gnu.tgz -L -O "http://sir.co.kr/bbs/download_direct.php?bo_table=g4_pds&wr_id=8869&no=0"
RUN tar xf /tmp/gnu.tgz
RUN mv gnuboard4 /var/www/gnuboard4
RUN chown -R www-data:www-data /var/www/gnuboard4
RUN chmod 777 /var/www/gnuboard4

EXPOSE 80
ADD boot.sh /srv/boot.sh
RUN chmod +x /srv/boot.sh
ADD remove_install_directory.php /var/www/gnuboard4/init.php

CMD ["/bin/bash", "/srv/boot.sh"]
