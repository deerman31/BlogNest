#!/bin/bash

# 削除するIPアドレスとドメイン名
IP_ADDRESS="127.0.0.1"
DOMAIN_NAME="ykusano.42.fr"

# /etc/hostsからエントリを削除
sudo sed -i "/$IP_ADDRESS $DOMAIN_NAME/d" /etc/hosts