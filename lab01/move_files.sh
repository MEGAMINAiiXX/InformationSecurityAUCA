#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
    printf 'Usage: %s SOURCE_DIR DESTINATION_DIR\n' "$0" >&2
    exit 2
fi

source_dir=$1
destination_dir=$2

if [[ ! -d $source_dir || ! -d $destination_dir ]]; then
    printf 'Both source and destination must be existing directories.\n' >&2
    exit 2
fi

source_dir=$(cd -- "$source_dir" && pwd -P)
destination_dir=$(cd -- "$destination_dir" && pwd -P)

if [[ $source_dir == "$destination_dir" ]]; then
    printf 'Source and destination must be different directories.\n' >&2
    exit 2
fi

while IFS= read -r -d '' file; do
    destination_file="$destination_dir/${file##*/}"

    if [[ -e $destination_file || -L $destination_file ]]; then
        printf 'Skipping existing destination: %s\n' "$destination_file"
        continue
    fi

    mv -- "$file" "$destination_dir/"
done < <(find "$source_dir" -mindepth 1 -maxdepth 1 -type f -print0)

printf 'Moved non-conflicting regular files from %s to %s.\n' \
    "$source_dir" "$destination_dir"
