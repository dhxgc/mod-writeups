# 2 билет

---

## 1:
```bash
apt install samba -y
systemctl --now enable smbd
mkdir /public && chmod 777 -R /public
```

Дальше в `/etc/samba/smb.conf` добавить, после рестартнуть самбу:
```ini
[Public]
    path = /public
    read only = Yes
    guest ok = Yes
    browseable = yes
    writable = yes
    create mask = 0777
    directory mask = 0777
```

---

### 2:
Установить zabbix:
```bash
cd docker/zabbix && docker compose pull
docker compose up -d
```

Настройка zabbix:
```text

```

---


### 3:
```text


```