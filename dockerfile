#Install base OS Ubuntu

FROM ubuntu:18.04

MAINTAINER Mwanda 

ENV DEBIAN_FRONTEND noninteractive

# Install App et' Al

RUN apt-get update

RUN apt-get install -y software-properties-common && \
add-apt-repository ppa:ondrej/php && apt-get update

RUN apt-get install -y -f curl

RUN apt-get install -y --allow-unauthenticated php7.3 php7.3-mysql php7.3-cli php7.3-gd php7.3-curl

RUN a2enmod php7.3
RUN a2enmod rewrite

# Apache Env Variables

ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Expose apache

EXPOSE 80

# Update Default Site

ADD apache-config.conf etc/apache2/sites-enabled/000-default.conf
ADD .htaccess /var/www/html/
ADD home.php /var/www/html/

# Apache start up

CMD /usr/sbin/apache2ctl -D FOREGROUND

