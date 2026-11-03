#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "$(dirname -- "$0")" && pwd -P)
runtime=$(mktemp -d "${TMPDIR:-/tmp}/lab10-proxy.XXXXXX")
api_pid=
nginx_pid=

cleanup() {
    if [[ -n $nginx_pid ]] && kill -0 "$nginx_pid" 2>/dev/null; then
        kill -QUIT "$nginx_pid"
        for _ in 1 2 3 4 5; do
            kill -0 "$nginx_pid" 2>/dev/null || break
            sleep 1
        done
        if kill -0 "$nginx_pid" 2>/dev/null; then
            kill "$nginx_pid"
        fi
        wait "$nginx_pid" 2>/dev/null || true
    fi
    if [[ -n $api_pid ]] && kill -0 "$api_pid" 2>/dev/null; then
        kill "$api_pid"
        wait "$api_pid" 2>/dev/null || true
    fi
    rm -rf -- "$runtime"
}
trap cleanup EXIT

mkdir -p "$root/logs"/{client_body,proxy,fastcgi,uwsgi,scgi}
nginx -t -p "$root/" -c nginx.conf

python3 "$root/api.py" >"$runtime/api.log" 2>&1 &
api_pid=$!
nginx -p "$root/" -c nginx.conf -g 'daemon off;' >"$runtime/nginx.log" 2>&1 &
nginx_pid=$!

for _ in 1 2 3 4 5; do
    if curl --max-time 2 -fsS -o "$runtime/response.json" \
        http://127.0.0.1:8080/api/health 2>/dev/null; then
        if grep -Fqx '{"status": "ok"}' "$runtime/response.json"; then
            printf 'NGINX reverse-proxy integration: OK\n'
            exit 0
        fi
    fi
    sleep 1
done

printf 'Proxy test did not receive the expected API response.\n' >&2
printf 'API log:\n' >&2
cat "$runtime/api.log" >&2
printf 'NGINX log:\n' >&2
cat "$runtime/nginx.log" >&2
exit 1
