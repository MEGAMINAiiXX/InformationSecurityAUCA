# Lab 5 — User management in Linux

## Цель

Изучить локальные учётные записи и группы: `getent`, `id`, `groupadd`, `useradd`, `usermod` и `userdel`.

## Исследование

```bash
chmod +x inspect_users.sh
./inspect_users.sh
getent passwd
getent group
id
```

Для необязательного упражнения создайте отдельную группу и тестового системного пользователя в своей Ubuntu/WSL:

```bash
sudo groupadd lab_students
sudo useradd --create-home --shell /bin/bash --groups lab_students lab_user
id lab_user
getent group lab_students
```

Не используйте существующую учётную запись. Удалите только созданные для упражнения записи:

```bash
sudo userdel --remove lab_user
sudo groupdel lab_students
```

Создание и удаление пользователей меняет систему; команды приведены для самостоятельного выполнения и не запускаются автоматически. Не публикуйте содержимое `/etc/shadow`.
