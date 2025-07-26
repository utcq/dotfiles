#!/bin/env bash

set -euo pipefail

case "${1:-}" in
    btreload)
        # Fix bluetooth repairing loudspeaker
        if bluetoothctl show | grep 'Powered: yes' -q; then
            bluetoothctl power off &>/dev/null &&
                sleep 1 &&
                bluetoothctl power on &>/dev/null
        fi
        ;;
esac
