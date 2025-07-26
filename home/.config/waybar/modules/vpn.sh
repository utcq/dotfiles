#!/bin/env bash

set -euo pipefail

case "${1:-}" in
    stat)
        RX=$(ip --json stats show dev wg0 group link | jq '.[0].stats64.rx.bytes')
        TX=$(ip --json stats show dev wg0 group link | jq '.[0].stats64.tx.bytes')
        printf "rx: %.2f tx: %.2f" $((RX / 1024 / 1024)) $((TX / 1024 / 1024))
        ;;
    [a-z0-9]*)
        pkexec systemctl "$([ -d /proc/sys/net/ipv4/conf/"$1" ] && echo "stop" || echo "start")" wg-quick@"$1"
        ;;
esac
