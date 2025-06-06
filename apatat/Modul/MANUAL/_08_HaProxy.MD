# HaProxy

### Порядок действий

Непосредственно перед установкой обновим данные репозитория, для этого введём в терминале:

```sh
apt update
```

Перейдем непосредственно к установке HaProxy на Ubuntu. Отправим в терминал команду:

```sh
sudo apt install haproxy -y
```

> Также нужно установить Nginx для проверки

После выполнения всех настроек и загрузки haproxy можно перейти к настройке

Сделайте копию конфигурационного файла haproxy:

```sh
sudo cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.backup
```

---
Откройте конфигурационный файл

```sh
sudo nano /etc/haproxy/haproxy.cfg
```

Все команды дописываем в конце файла

Для начала укажем, что HAProxy будет принимать все входящие подключения на 8080 порт, а так же сервер по умолчанию:

```sh
frontend website
       bind :8080
       default_backend main
```

В качестве бэкенд-серверов у нас будем мы сами, с установленным nginx

```sh
backend main
       server main1 <Ваш Айпи Адресс>:80
```

Сохраним конфиг и перезапустим HAProxy:

```sh
sudo systemctl restart haproxy
```

# HaProxy в докер

С Proxy сложнее чем с обычным web сервером

Для начала необходимо создать виртуальнию сеть для контейнеров

```sh
docker network create cluster
```

После этого запускаем контейнер `Nginx` в этой подсети

```sh
sudo docker run -p 80:80 -d --net cluster --name nginx nginx
```

После этого смотрим какой айпи имеет конйтенер в нашей виртуальной сети:

```sh
docker inspect nginx
```

<img src="src\img\_08_HaProxy\1.png" width="700px"></img>

> Запоминаем

Теперь нужно установить haproxy на основную машину и настроить конфигурационный файл так же как было показанно выше

Единственное что нужно заменить это ip-адрес в блоке `backend` на ip nginx контейнера - в нашем случае 172.18.0.2

После настройки необходимо выключить haproxy на основной машине:

```sh
systemctl stop haproxy
```

Остается только запустить контейнер с HaPropxy и перенести туда наши настройки

```sh
sudo docker run -p 8080:8080 --net cluster --name haproxy -v /etc/haproxy:/usr/local/etc/haproxy:ro haproxy
```

> Если вылазят ошибки которые не дают запустить контейнер, вам необходимо удалить строки в конфигурационном файле на которые ругается служба при запуске