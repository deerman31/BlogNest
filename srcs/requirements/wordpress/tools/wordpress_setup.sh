#!/bin/sh

# WordPressのインストールディレクトリを変数にセット
WP_DIR="/var/www/html/wordpress"

# WordPressディレクトリの存在確認
if [ -d "$WP_DIR" ]; then
    echo "WordPress directory exists."
else
    # WordPressディレクトリの作成
    mkdir -p "$WP_DIR"

    # データベースの準備ができるまで待機
    # sleep 10

    # wp-cliのインストール
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    php wp-cli.phar --info
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    # WordPressのダウンロードと設定
    cd "$WP_DIR"
    wp core download --path="$WP_DIR" --allow-root
    wp config create --path="$WP_DIR" --dbhost="$DB_HOST" --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_USER_PASSWORD" --allow-root
    wp core install --path="$WP_DIR" --url="$DOMAIN_NAME" --title="$TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_MAIL" --skip-email --allow-root
    wp user create "$WP_USER" "$WP_USER_MAIL" --path="$WP_DIR" --user_pass="$WP_USER_PASSWORD" --role=author --allow-root
fi

# php-fpmの起動
/usr/sbin/php-fpm7.4 -F
