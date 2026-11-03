#!/usr/bin/env bash
set -euo pipefail

directory=$(mktemp -d "${TMPDIR:-/tmp}/lab06-permissions.XXXXXX")
trap 'rm -rf -- "$directory"' EXIT

file="$directory/file.txt"
printf 'Temporary permission practice\n' > "$file"
printf 'Initial: '
stat -c '%A (%a) %U:%G' "$file"

chmod 640 "$file"
printf 'After chmod 640: '
stat -c '%A (%a) %U:%G' "$file"
printf 'Temporary file will be removed when this script exits.\n'
