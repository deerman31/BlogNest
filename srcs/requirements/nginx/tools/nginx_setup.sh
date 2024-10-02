#!/bin/sh

# openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
# -keyout ${KEY} \
# -out ${OUT} \
# -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCATION}/O=${ORGANIZATION}/OU=${UNIT}/CN=${DOMAIN_NAME}/UID=${USER_NAME}"

cat > /etc/nginx/sites-available/default <<EOF
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name ${DOMAIN_NAME};

    # SSL Configuration
    ssl_certificate ${OUT};
    ssl_certificate_key ${KEY};

    # SSLプロトコルの指定: TLSv1.2とTLSv1.3を使用するように設定しています。
    ssl_protocols TLSv1.2 TLSv1.3;

    root /var/www/html/wordpress;
    index index.php;

    # Logging settings
    access_log /var/log/nginx/wordpress.access.log;
    error_log /var/log/nginx/wordpress.error.log;

    # This directive serves files that exist without running scripts.
    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    # Redirect server error pages to the static page /50x.html
    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }

    # Pass PHP scripts to the PHP-FPM service named "wordpress" listening on port 9000
    location ~ ^/.+\.php(/|$) {
        try_files \$uri =404;
        fastcgi_pass wordpress:9000;
        fastcgi_index index.php;
        include fastcgi.conf;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
EOF

nginx -g "daemon off;"
