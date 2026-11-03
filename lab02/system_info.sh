#!/usr/bin/env bash
set -euo pipefail

printf 'Hostname: %s\n' "$(hostname)"
printf 'Current user: %s\n' "$(whoami)"
printf 'Disk space:\n'
df -h .
