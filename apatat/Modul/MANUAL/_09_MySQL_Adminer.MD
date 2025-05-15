# MySQL + Adminer

### Порядок действий

Для начала необходимо создать виртуальнию сеть для контейнеров

```sh
docker network create cluster
```

Запустить в этой сети контейнер с базой данных

```sh
docker run --rm -d -v mysql:/var/lib/mysql -v mysql_config:/etc/mysql --name mysql --net cluster -e MYSQL_ROOT_PASSWORD=password mysql
```

Либо так если нет необходимости сохранять данные занесенные в БД

```sh
docker run --rm -d --name mysql --net cluster -e MYSQL_ROOT_PASSWORD=password mysql
```

`MYSQL_ROOT_PASSWORD` - задает пароль для рут пользователя (В данном примере `password`)

После этого смотрим какой айпи имеет конйтенер в нашей виртуальной сети:

```sh
docker inspect mysql
```

Запускаем Adminer в этой же сети

```sh
docker run -d -p 8080:8080 --net cluster --name adminer adminer
```

Заходим в браузер и проверяем

> Для этого вводим <ip-адрес-серевера>:8080