# Lab 1 — Comprehending UNIX terminal commands

## Цель

Создать два каталога, **переместить** обычные файлы из одного в другой командой `mv`, проверить результат и изучить `tar`.

## Выполнение

Если уже выполняли упражнение раньше, сначала удалите только его тестовый каталог: `rm -r work`.

Повторите базовые команды в тестовой папке. Для учебного файла достаточно ограниченных прав `700`; не выдавайте всем пользователям права `777`:

```bash
mkdir -p work/my_dir work/another_dir
touch work/my_dir/my_file.txt
chmod 700 work/my_dir/my_file.txt
cat work/my_dir/my_file.txt
ls -l work/my_dir
mv work/my_dir/my_file.txt work/another_dir/
ls -l work/another_dir
```

Для оставшихся примеров создайте отдельные каталоги:

```bash
chmod +x move_files.sh
mkdir -p work/source work/destination
printf 'First example\n' > work/source/first.txt
printf 'Second example\n' > work/source/second.txt
./move_files.sh work/source work/destination
```

Скрипт перемещает обычные файлы только из верхнего уровня каталога-источника, включая скрытые файлы; существующие одноимённые файлы назначения не перезаписываются.

Проверьте результат:

```bash
find work/source work/destination -maxdepth 1 -type f -print
```

Создайте архив и просмотрите его:

```bash
tar -czf work/destination.tar.gz -C work/destination .
tar -tzf work/destination.tar.gz
tar --help
```

`mv` перемещает, `cp` копирует, `tar -c` создаёт архив, `tar -t` перечисляет его содержимое, `tar -x` извлекает.

Для безопасного знакомства с `curl`:

```bash
curl --help
curl -I https://example.com
```

## Проверка и очистка

Убедитесь, что в `work/source` больше нет файлов, а в архиве присутствуют файлы назначения. Удалите только тестовую папку: `rm -r work`.
