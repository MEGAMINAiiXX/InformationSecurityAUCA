#!/usr/bin/env bash
set -euo pipefail

printf 'Current account:\n'
id
printf '\nKnown local users (name and login shell):\n'
getent passwd | awk -F: '{ printf "%-24s %s\n", $1, $7 }'
printf '\nKnown groups:\n'
getent group | cut -d: -f1
