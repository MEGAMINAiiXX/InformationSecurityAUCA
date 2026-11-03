#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "$(dirname -- "$0")" && pwd -P)
cd "$root"

for script in validate.sh lab01/*.sh lab02/*.sh lab05/*.sh lab06/*.sh lab09/*.sh lab10/*.sh; do
    bash -n "$script"
done
printf 'Shell syntax: OK\n'

python3 - <<'PY'
from pathlib import Path

sources = [
    Path("lab03/toy_shell.py"),
    Path("lab04/analyze_message.py"),
    Path("lab07/write_timestamp.py"),
    Path("lab10/api.py"),
    Path("lab12/password_policy.py"),
    Path("lab12/login_defense.py"),
]
for source in sources:
    compile(source.read_text(encoding="utf-8"), str(source), "exec")
print("Python syntax: OK")
PY

python3 -m unittest discover -s lab03 -p 'test_*.py' -v
python3 -m unittest discover -s lab04 -p 'test_*.py' -v
python3 -m unittest discover -s lab12 -p 'test_*.py' -v

tmp=$(mktemp -d "${TMPDIR:-/tmp}/information-security-labs.XXXXXX")
trap 'rm -rf -- "$tmp"' EXIT

mkdir "$tmp/source" "$tmp/destination"
printf 'visible\n' > "$tmp/source/visible.txt"
printf 'hidden\n' > "$tmp/source/.hidden"
printf 'preserve\n' > "$tmp/destination/visible.txt"
lab01/move_files.sh "$tmp/source" "$tmp/destination"
[[ -f $tmp/source/visible.txt && ! -e $tmp/source/.hidden ]]
[[ $(<"$tmp/destination/visible.txt") == preserve ]]
[[ -f $tmp/destination/.hidden ]]
tar -czf "$tmp/archive.tar.gz" -C "$tmp/destination" .
tar -tzf "$tmp/archive.tar.gz" | grep -q 'visible.txt'
tar -tzf "$tmp/archive.tar.gz" | grep -q '.hidden'
printf 'Lab 1 move and tar: OK\n'

[[ $(lab02/count_word.sh lab02/sample.txt Linux) == 2 ]]
[[ $(lab02/count_word.sh lab02/sample.txt absent) == 0 ]]
lab02/greet.sh >/dev/null
lab02/current_time.sh >/dev/null
lab02/system_info.sh >/dev/null
mkdir "$tmp/empty-files"
touch "$tmp/empty-files/empty.txt"
printf 'keep\n' > "$tmp/empty-files/keep.txt"
lab02/delete_empty_files.sh "$tmp/empty-files" >/dev/null
[[ ! -e $tmp/empty-files/empty.txt && -f $tmp/empty-files/keep.txt ]]
printf 'Lab 2 scripts: OK\n'

lab05/inspect_users.sh >/dev/null
lab06/permission_demo.sh >/dev/null
python3 lab07/write_timestamp.py "$tmp/cron.log"
[[ $(wc -l < "$tmp/cron.log") -eq 1 ]]
python3 lab04/analyze_message.py lab04/examples/messages.json >/dev/null
printf 'Labs 4-7 exercises: OK\n'

if command -v nginx >/dev/null 2>&1; then
    mkdir -p lab10/logs/{client_body,proxy,fastcgi,uwsgi,scgi}
    nginx -t -p "$root/lab10/" -c nginx.conf
    bash lab10/test_proxy.sh
    printf 'Lab 10 NGINX configuration: OK\n'
else
    printf 'Skipping Lab 10 NGINX check: nginx is not installed.\n'
fi

if command -v make >/dev/null 2>&1 && command -v cc >/dev/null 2>&1; then
    make -C lab11 clean all
    lab11/build/linecount lab11/README.md
    make -C lab11 clean
    printf 'Lab 11 source build: OK\n'
else
    printf 'Skipping Lab 11 build: make and a C compiler are required.\n'
fi

printf 'All available lab checks passed.\n'
