#!/bin/sh

# MariaDBサービスを開始
service mariadb start

# MariaDBの初期設定
mariadb -v -u root <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_ROOT_PASSWORD');
FLUSH PRIVILEGES;
EOF

# MariaDBサービスを停止
service mariadb stop

# mysqldをフォアグラウンドで実行
#exec mysqld
mysqld_safe
