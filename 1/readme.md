# 1 билет
DNS:
```bash
# Сначала поменять зону, ипы, статика и прочее говно
cd dns-docker && docker compose up -d
```

Пример статики в нетплане ссаном для пидарасов:
```yml
network:
  version: 2
  ethernets:
    ens33:
      dhcp4: false
      addresses:
      - 192.168.198.152/24
      routes:
      - to: default
        via: 192.168.198.2
      nameservers:
        addresses: [8.8.8.8]
```

DHCP:
```bash
# 1. Поменять ИПы в dhcpd.conf на свои
# 2. Поменять интерфейс в docker-compose.yml на свой основной 
cd dhcp-docker && docker compose up -d
```