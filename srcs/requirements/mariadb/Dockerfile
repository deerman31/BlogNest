FROM debian:11

RUN apt-get update -y && \
# --no-install-recommends --no-install-suggests で最小限の構成でmariadbをinstall
apt-get install -y --no-install-recommends \
--no-install-suggests mariadb-server && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/mariadb_setup.sh /bin/mariadb_setup.sh

RUN chmod +x /bin/mariadb_setup.sh

ENTRYPOINT ["mariadb_setup.sh"]
