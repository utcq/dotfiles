#!/usr/bin/env bash

# sudo pacman -S --needed iwd fuzzel
# sudo systemctl enable --now iwd

set -euo pipefail

device=$(iwctl device list | grep -Po "wl[^ ]+" | head -1) || {
    notify-send "Could not detect Wi-Fi device" "Please turn on a Wi-Fi adapter or start the iwd.service"
    exit 1
}

iwctl station "$device" scan &&
    notify-send "Scanning Wi-Fi networks..." "Please wait" &&
    sleep 5

mapfile -t SINKS < <(iwctl station "$device" get-networks | tail -n +5 | head -n -1 | sed -E 's/\x1b\[[0-9;]*m//g; s/\*.*/\*/; s/>   /*/; s/ +/ /g' | column -t)

network_selected=$(for SINK in "${SINKS[@]}"; do echo "$SINK"; done | fuzzel --dmenu -l "${#SINKS[@]}" 2>/dev/null | cut -d " " -f1)
[[ "${network_selected:0:1}" = "*" ]] && {
    notify-send "Already connected to ${network_selected:1}" "Nothing to do"
    exit 0
}

if iwctl known-networks list | grep -qF "${network_selected#\**}"; then
    credentials=$(echo -e "Use saved credentials\nEnter new passphrase\n" | fuzzel --dmenu --index -l2)
fi

[[ -z "${credentials:-}" || "$credentials" -eq 1 ]] && password=$(echo "Enter passphrase for $network_selected" | fuzzel --dmenu -l1 --password)

if iwctl ${password:+ --passphrase "$password"} station "$device" connect "$network_selected"; then
    notify-send "Connected to $network_selected"
else
    notify-send "Error connecting to $network_selected" "Check settings or passphrase"
fi
