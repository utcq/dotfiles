#!/bin/env bash

set -euo pipefail

if [[ "${1:-}" == "wipe" ]]; then
    cliphist wipe
    notify-send "Clipboard history" "has been wiped"
else
    mapfile -t indexes < <(cliphist list | grep -Eo "^[0-9]+")
    index=$(cliphist list | cut -d"	" -f2 | fuzzel -f "monospace:size=9" --dmenu -w 35 -a bottom-right --index 2>/dev/null)
    if [[ -n "$index" ]]; then
        cliphist list | grep "^${indexes[$index]}" | cliphist decode | wl-copy -n
    fi
fi
