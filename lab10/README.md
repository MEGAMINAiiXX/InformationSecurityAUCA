# Lab 10 — Configuring NGINX

## Цель

Изучить `proxy_pass`, настроив локальный NGINX reverse proxy для безвредного API-ответа.

## Зависимости

В Ubuntu/WSL установите NGINX при необходимости: `sudo apt update && sudo apt install nginx`. Для самого API достаточно Python 3.

## Запуск в двух терминалах Ubuntu

Из этого каталога запустите backend:

```bash
python3 api.py
```

В другом терминале из того же каталога проверьте конфигурацию и запустите NGINX:

```bash
mkdir -p logs/{client_body,proxy,fastcgi,uwsgi,scgi}
nginx -t -p "$PWD/" -c nginx.conf
nginx -p "$PWD/" -c nginx.conf -g 'daemon off;'
```

В третьем терминале проверьте проксирование:

```bash
curl -i http://127.0.0.1:8080/api/health
```

Ожидается JSON `{"status": "ok"}`. Остановите NGINX и API через `Ctrl-C` в их терминалах. Сервис слушает только loopback-интерфейс и не принимает внешние запросы.

`api.py` предоставляет только демонстрационный GET endpoint; конфигурация не принимает логины, пароли или платёжные данные.

Для автоматической проверки маршрута proxy → API запустите `./test_proxy.sh`. Тест использует только loopback и останавливает запущенные им процессы по завершении.
