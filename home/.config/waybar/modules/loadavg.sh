#!/bin/env bash

# Script is deprecated, use https://github.com/Alexays/Waybar/wiki/Module:-Load

set -euo pipefail

IFS=" " read -r -a load < /proc/loadavg
ZPROCESSES=$(pgrep --runstates Z -a | sed -z 's/[<>]//g;s|\n|\\\\n|g;s|^|! \\\\n\\\\n|') || true
echo -e "{\"text\": \"${ZPROCESSES:0:2}${load[0]}\", \"tooltip\": \"${load[0]} ${load[1]} ${load[2]}\\\n$(uptime -p)${ZPROCESSES:2}\"}"
