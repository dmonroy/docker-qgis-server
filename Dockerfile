FROM ubuntu:16.04
MAINTAINER Darwin Monroy <contact@darwinmonroy.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y \
    apache2 \
    libapache2-mod-fcgid \
    qgis-server \
  && a2enmod fcgid \
  && a2enconf serve-cgi-bin  \
  && chown -R www-data:www-data /var/www

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock
ENV APACHE_PID_FILE /var/run/apache2.pid
ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
