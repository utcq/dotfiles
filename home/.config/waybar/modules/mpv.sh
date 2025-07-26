#!/bin/env bash

set -euo pipefail

mpv --profile=notebook "$(wl-paste | fuzzel --dmenu -l0 -w50 --prompt="Stream: $(wl-paste)")" >/dev/null
