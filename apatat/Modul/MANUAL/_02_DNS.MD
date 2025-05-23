# DNS

### Порядок действий

Установим Роль

```sh
apt install bind9
```

Настройка прямой и обратной зоны DNS

- Настроим переадресацию ДНС запросов

<img src="src\img\_02_DNS\2.png" width="700px"></img>

В `forwarders` указываем следующие айпи:  
        1. ip-адресс сервера  
        2. DNS который будет указан на доске (Скорее всего : 10.0.20.2)

Добавляем параметр `listen-on` и указываем в нем подсеть которую будем прослушывать, в данном случае ту в которой находимся

- Cоздадим зону DNS

Добавьте информацию о зоне в конфигурацию
```sh
sudo nano /etc/bind/named.conf.local
```
- Затем добавьте следующие строки

Далее идут команды в которых нужно прописывать `СВОИ ДАННЫЕ`

<img src="src\img\_02_DNS\3.png" width="700px"></img>

```sh
# Прямая зона
zone "trashex.com" {
        type master;
        file "/etc/bind/treshex.com";
};
# Обратная зона
zone "68.168.192.in-addr.arpa" {
        type master;
        file "/etc/bind/db.68.168.192";
};
```
`trashex.com` меняется на название вашей придуманной доменной зоны  
`68.168.192` меняется на перевернутый адресс вашей подсети без последнего актета (Например если адресс 192.168.68.0 - то будет 68.168.192)

### Выполните перезапуск службы

```sh
systemctl reload bind9
```

- Конфигурационный файл зоны

Создайте файл зоны из шаблона и откройте его.

```sh
sudo cp /etc/bind/db.local /etc/bind/trashex.com
sudo nano /etc/bind/trashex.com
```

Замените `localhost` в записи SOA и NS полным доменным именем вашего сервера с указанием « . » в конце.

<img src="src\img\_02_DNS\4.png"></img>

Так же добавить прямую запись, например:

```sh
trashex IN      A       192.168.68.112
```

Данная запись нам показывает что если мы обратимся по записи `trashex` то сервер будет обращатся к адрессу `192.168.68.112`

Аналогично для обратной зоны:

Создайте файл зоны из шаблона и откройте его.

```sh
sudo cp /etc/bind/db.0/etc/bind/db.68.168.192
sudo nano /etc/bind/db.68.168.192
```

<img src="src\img\_02_DNS\5.png"></img>

Так же добавим обратную запись, например:

```sh
112     IN      PTR     marishka.trashex.com.
```

Данная запись нам показывает что если мы обратимся по ip в нашей подсети с адресом `112` то сервер будет возвращать доменное имя `marishka.trashex.com`

Перезапустите rndc

```sh
sudo rndc reload
```