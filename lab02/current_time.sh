#!/usr/bin/env bash
set -euo pipefail

now=$(date +%H:%M)
end_minutes=$((17 * 60))
current_hour=$(date +%-H)
current_minute=$(date +%-M)
current_minutes=$((current_hour * 60 + current_minute))

if (( current_minutes >= end_minutes )); then
    printf 'Current time: %s. The work day has ended.\n' "$now"
else
    remaining=$((end_minutes - current_minutes))
    printf 'Current time: %s. Work day ends after %d hours and %d minutes.\n' \
        "$now" "$((remaining / 60))" "$((remaining % 60))"
fi
