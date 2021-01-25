FROM alpine:latest

MAINTAINER rasikmhetre@gmail.com

RUN apk update && apk add apache2 php7-apache2 php7-gd php7-mysqli php

COPY httpd.conf /etc/apache2/httpd.conf

COPY wordpress/ /var/www/localhost/htdocs/wordpress

COPY wp-config-sample.php /var/www/localhost/htdocs/wordpress/wp-config.php

COPY phpinfo.php /var/www/localhost/htdocs

RUN apk add --no-cache mariadb mariadb-client

VOLUME ["/var/www/localhost/htdocs", "/var/lib/mysql", "/var/log/apache2"]

RUN mkdir /script

COPY startup.sh /script/startup.sh

COPY start.sh /script/start.sh

COPY main.sh /script/main.sh

COPY my.cnf /etc/my.cnf.d/mariadb-server.cnf

ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_DATABASE wordpress
ENV MYSQL_USER wordpress
ENV MYSQL_PASSWORD wordpress

EXPOSE 3306 80
RUN chmod 755 -R /script
ENTRYPOINT ["/script/main.sh"]
