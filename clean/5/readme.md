
python3 -m http.server

apt install nginx
mkdir /var/www/repo/ && echo "<h1>test</h1>" > /var/www/repo/index.html
cp site /etc/nginx/sites-available/ && ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/
systemctl restart nginx

- Тип используемого оборудования.
- Качество каналов связи.
- Загруженность сети.
- Средства защиты (антивирус, фаерволлы).
- Обработка данных серверами.
- Географическая удаленность.
