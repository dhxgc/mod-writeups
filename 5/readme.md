# 5 билет

---

### 1 вопрос:
Установить/Запустить:
```bash
# 1 Вариант:
python3 -m http.server

# 2 Вариант:
apt install nginx
mkdir /var/www/repo/ && echo "<h1>GOVNO</h1>" > /var/www/repo/index.html
cp site /etc/nginx/sites-available/ && ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/
systemctl restart nginx
```

---

### 2 вопрос:

---

### 3 вопрос:
```text
- Тип используемого оборудования.
- Качество каналов связи.
- Загруженность сети.
- Средства защиты (антивирус, фаерволлы).
- Обработка данных серверами.
- Географическая удаленность.
```