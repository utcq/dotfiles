#!/bin/env bash

set -euo pipefail

# Unmount and power off any user mounted drives.
mapfile -t ArrayDisks < <(lsblk -n -p -S -o PATH,TRAN | grep "usb" | cut -d " " -f1)

if [[ ${#ArrayDisks[@]} -gt 0 ]]; then
    mapfile -t ArrayNames < <(lsblk -n -S -P -o VENDOR,MODEL,TRAN | grep "usb" | sed 's/ *" MODEL="/ /' | grep -Po '(?<=VENDOR=")[^"]+')

    : "${tooltip:-}"
    for i in "${ArrayDisks[@]}"; do
        parts=$(mount | grep "$i" | grep -Po "(?<= on \/run\/media\/$(whoami))\/[^ ]+" |
            tr "/" " " | paste -sd, -) || true
        parts=${parts:- Not mounted}
        namedisk=$(lsblk -n -S -P -o PATH,VENDOR,MODEL,TRAN | grep -E "$i"".*usb" | sed 's/ *" MODEL="/ /' | grep -Po '(?<=VENDOR=")[^"]+')
        tooltip+="$namedisk:$parts\n"
    done
    tooltip=${tooltip%\\n}

    if [[ "${1:-}" == "unmount" ]]; then
        if [[ ${#ArrayDisks[@]} -gt 1 ]]; then
            sel=$(echo "$tooltip" | sed 's/\\n/#/g' |
                tr "#" "\n" | fuzzel -f "monospace:size=9" --dmenu -w 40 -a bottom-right --index -l${#ArrayDisks[@]})
            [[ -z "$sel" ]] && exit 0
        else
            sel=0
        fi

        mapfile -t ArrayParts < <(mount | grep "${ArrayDisks[$sel]}" |
            grep -Po ".*(?= on \/run\/media)")

        if [[ ${#ArrayParts[@]} -gt 0 ]]; then
            sync
            for part in "${ArrayParts[@]}"; do
                udisksctl unmount -b "$part" ||
                    {
                        notify-send "Failed to unmount partition $(mount | grep -Po "(?<=$part on \/run\/media\/$(whoami)\/)[^ ]+")!" \
                            "Please try again later"
                        exit 1
                    }
            done
        fi

        udisksctl power-off -b "${ArrayDisks[$sel]}" ||
            {
                notify-send "Failed to power-off disk $i!" \
                    "Please try again later"
                exit 1
            }

        pkill -SIGRTMIN+10 waybar
        notify-send "${ArrayNames[$sel]}" \
            "can be safely removed"
    else
        echo "{\"text\": \"\", \"class\": \"umount\", \"tooltip\": \"$tooltip\"}"
    fi
fi
