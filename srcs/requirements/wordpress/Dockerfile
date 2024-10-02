FROM debian:11

# wordPressと連携するためのPHPといくつかの拡張機能、mysqlとの連携に必要なphp-mysqli、CURL、GDライブラリなどをインストール。
RUN apt-get update -y && \
apt-get install -y unzip php curl \
wget redis php-redis php-mysqli php-fpm \
php-cgi php-curl php-gd php-mbstring php-xml \
php-xmlrpc php-soap php-intl php-zip default-mysql-client && \
apt-get clean && rm -rf /var/lib/apt/lists/* && \
mkdir /run/php

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/wordpress_setup.sh /bin/wordpress_setup.sh

RUN chmod +x /bin/wordpress_setup.sh

EXPOSE 9000 

ENTRYPOINT ["wordpress_setup.sh" ]