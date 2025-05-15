#!/bin/bash

sudo -s <<EOF

wget https://repo.zabbix.com/zabbix/7.2/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.2+ubuntu24.04_all.deb
dpkg -i zabbix-release_latest_7.2+ubuntu24.04_all.deb
apt update -y

apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent nginx php8.3-fpm

debconf-set-selections <<< "mariadb-server mariadb-server/root_password password zabbix"
debconf-set-selections <<< "mariadb-server mariadb-server/root_password_again password zabbix"
apt install -y mariadb-server

mysql -uroot -pzabbix <<MYSQL_SCRIPT
CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix';
GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
SET GLOBAL log_bin_trust_function_creators = 1;
MYSQL_SCRIPT

zcat /usr/share/zabbix/sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -pzabbix zabbix

mysql -uroot -pzabbix <<< "SET GLOBAL log_bin_trust_function_creators = 0;"

sed -i 's/^# DBPassword=.*/DBPassword=zabbix/' /etc/zabbix/zabbix_server.conf

sed -i 's/# listen 8080;/listen 80;/' /etc/zabbix/nginx.conf
sed -i 's/# server_name example.com;/server_name localhost;/' /etc/zabbix/nginx.conf
ln -s /etc/zabbix/nginx.conf /etc/nginx/sites-enabled/zabbix.conf
rm /etc/nginx/sites-enabled/default

sed -i 's/; date.timezone =/date.timezone = UTC/' /etc/php/8.3/fpm/php.ini

systemctl restart zabbix-server zabbix-agent nginx php8.3-fpm
systemctl enable zabbix-server zabbix-agent nginx php8.3-fpm

echo "Пароль везде - zabbix, в вебе дефолтные креды"

EOF