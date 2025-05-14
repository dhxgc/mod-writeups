# 3 билет

---

### 1 вопрос:
Установить `vsftpd`:
```bash
apt install vsftpd
cp -r /etc/vsftpd.conf{,.bak} && grep -P "^[^#]" /etc/vsftpd.conf.bak > /etc/vsftpd.conf
```

`/etc/vsftpd.conf`:
```conf
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=066
dirmessage_enable=NO
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO

chroot_local_user=YES
allow_writeable_chroot=YES
pam_service_name=vsftpd
```

---

### 2 вопрос:

Установить Zabbix:
```bash
cd docker/zabbix && docker compose pull
docker compose up -d
```

---

### 3 вопрос:
