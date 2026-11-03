#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 || ! -f $1 ]]; then
    printf 'Usage: %s FILE WORD\n' "$0" >&2
    exit 2
fi

if [[ -z $2 ]]; then
    printf 'WORD must not be empty.\n' >&2
    exit 2
fi

awk -v word="$2" '
{
    remaining = $0
    while ((position = index(remaining, word)) > 0) {
        count++
        remaining = substr(remaining, position + length(word))
    }
}
END { print count + 0 }
' "$1"
