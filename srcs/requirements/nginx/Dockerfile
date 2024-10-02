FROM debian:11

ARG COUNTRY
ARG STATE
ARG LOCATION
ARG ORGANIZATION
ARG UNIT
ARG DOMAIN_NAME
ARG USER_NAME
ARG KEY
ARG OUT

# apt-getをuptedeとupgradeする
RUN apt-get update -y && \
# nginxとopenssをインストールし、不要なファイル群を削除する
apt-get install -y nginx openssl && apt-get clean && \
rm -rf /var/lib/apt/lists/* && \
# SSL証明書のディレクトリを作成し、権限を設定する
mkdir -p /etc/nginx/ssl && chmod -R 755 /etc/nginx/ssl
# openssl req -x509 自己署名証明書を生成する
# -nodes: これにより、秘密鍵が暗号化されずに保存される
# -days 365: 証明書の有効期間を365日間と指定
# -newkey rsa:2048: 新しいRSA秘密鍵を2048ビットで生成します
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
# -keyout ${KEY}: 秘密鍵を保存するファイルパス
-keyout ${KEY} \
# -out ${OUT}: 証明書を保存するファイルパス
-out ${OUT} \
-subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCATION}/O=${ORGANIZATION}/OU=${UNIT}/CN=${DOMAIN_NAME}/UID=${USER_NAME}"

# 443Portを公開
EXPOSE 443

# nginxのをsetupするスクリプトをコピーし、権限を設定する
COPY ./tools/nginx_setup.sh /bin/
RUN chmod +x /bin/nginx_setup.sh

ENTRYPOINT ["nginx_setup.sh"]
