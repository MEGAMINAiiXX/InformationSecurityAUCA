# Lab 9 — Package management

## Цель

Изучить пакетный менеджер APT на примере пакета NGINX.

## Исследование

```bash
chmod +x inspect_package.sh
sudo apt update
apt-cache policy nginx
apt show nginx
sudo apt install nginx
nginx -v
dpkg-query -W nginx
apt-cache depends nginx
```

`apt update` обновляет индекс пакетов, но не обновляет установленные программы. `apt install` устанавливает выбранный пакет и зависимости. Удаление выполняйте только если пакет был установлен для этой лабораторной:

```bash
sudo apt remove nginx
```

Не запускайте `apt upgrade` без необходимости: он меняет множество пакетов системы.

Скрипт `inspect_package.sh` показывает сведения о пакете, но ничего не устанавливает и не удаляет.
