# 1 билет
1. DNS и DHCP
```bash
# Сначала поменять зону, ипы, статика и прочее говно
cd dns-docker && docker compose up -d
```

```bash
# 1. Поменять ИПы в dhcpd.conf на свои
# 2. Поменять интерфейс в docker-compose.yml на свой основной 
cd dhcp-docker && docker compose up -d
```