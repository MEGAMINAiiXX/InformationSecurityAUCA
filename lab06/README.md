# Lab 6 — Permissions in Linux

## Цель

Проверить права чтения, записи и выполнения, изменить их через числовую нотацию `chmod`, а затем изучить владельца и группу через `chown` и `chgrp`.

## Безопасный эксперимент

```bash
chmod +x permission_demo.sh
./permission_demo.sh
mkdir -p permission-sandbox
printf 'Private practice file\n' > permission-sandbox/file.txt
ls -l permission-sandbox/file.txt
chmod 640 permission-sandbox/file.txt
stat -c '%A %a %U:%G %n' permission-sandbox/file.txt
```

Для изучения смены владельца выполните `sudo chown USER:GROUP permission-sandbox/file.txt`, подставив тестовую учётную запись и группу из Lab 5. Проверьте владельца через `stat`, затем удалите только `permission-sandbox`.

Не используйте `chmod 777` на системных файлах: это даёт всем локальным пользователям полный доступ.
