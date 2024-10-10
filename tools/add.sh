#!/bin/bash

# 追加するIPアドレスとドメイン名
IP_ADDRESS="127.0.0.1"
DOMAIN_NAME="bill.42.fr"

# /etc/hostsにエントリが存在するか確認
if grep -q "$IP_ADDRESS $DOMAIN_NAME" /etc/hosts; then
    echo "$DOMAIN_NAME はすでに /etc/hosts に存在します。"
else
    # /etc/hostsにエントリを追加
    echo "$IP_ADDRESS $DOMAIN_NAME" | sudo tee -a /etc/hosts
fi

