#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 || ! -d $1 ]]; then
    printf 'Usage: %s EXISTING_DIRECTORY\n' "$0" >&2
    exit 2
fi

directory=$(cd -- "$1" && pwd -P)
find "$directory" -mindepth 1 -maxdepth 1 -type f -empty -print -delete
