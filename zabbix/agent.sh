#!/bin/bash
# Под докер

wget https://repo.zabbix.com/zabbix/7.2/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.2+ubuntu22.04_all.deb
dpkg -i zabbix-release_latest_7.2+ubuntu22.04_all.deb
apt update 
apt install zabbix-agent2