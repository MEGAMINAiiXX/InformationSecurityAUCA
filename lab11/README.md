# Lab 11 — Installing packages from source

## Цель

Собрать небольшую утилиту `linecount` из локального исходного кода и установить её в пользовательский каталог `~/.local/bin`, не меняя системные директории.

## Требования

Ubuntu/WSL, `gcc` и `make`. Если компилятор отсутствует: `sudo apt update && sudo apt install build-essential`.

## Сборка, установка и проверка

```bash
make
./build/linecount README.md
make install
export PATH="$HOME/.local/bin:$PATH"
linecount README.md
```

Утилита считает строки переданного файла. Изучите [`linecount.c`](./linecount.c) и правила сборки в [`Makefile`](./Makefile).

Удалить можно только установленный этой лабораторной бинарник: `make uninstall`. `PREFIX` можно переопределить, например `make install PREFIX="$HOME/.local"`.
