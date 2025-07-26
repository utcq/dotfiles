#!/bin/env bash

set -euo pipefail

if [[ -z "${1:-}" ]]; then
    important_packages="linux systemd"
    ignored_packages="$(grep IgnorePkg /etc/pacman.conf | sed 's/IgnorePkg =//;s/#.*//')"
    mapfile -t upds < <(/usr/bin/pacman -Qqu | grep -Ev "$(echo "$ignored_packages" | tr ' ' '|'))")
    att=""
    for imppkg in $important_packages; do
        for index in ${!upds[*]}; do
            if [[ "${upds[$index]}" =~ ^$imppkg ]]; then
                upds[index]="<big>${upds[$index]}</big>"
                att="! "
            fi
        done
    done
    [[ ${#upds[*]} -gt 0 ]] && echo "{\"text\": \"$att${#upds[*]}\", \"class\": \"updates\", \"tooltip\": \"${upds[*]}\"}"
elif [ "$1" == "getnews" ]; then
    # Required by block
    max=$(pacman -Qqu | wc -L) || true
    if [[ "$max" -gt 0 ]]; then
        echo -e '\033[0;34m:: \033[0m\033[1mRequired by: \033[0m'
        for pkg in $(pacman -Qqu); do
            printf "%*s:%s\n" "$max" "$pkg" "$(pacman -Qi "$pkg" | grep Req | sed -e 's/Required By     : //g')" | column -c80 -s: -t -W2
        done
    fi
    # Mirror block
    mirror=$(grep -m1 '^[^#]*Server.*=' /etc/pacman.d/mirrorlist | cut -d'/' -f3)
    echo -ne '\033[0;34m:: \033[0m\033[1mMirror:'
    echo -n " $mirror"
    echo -e '\033[0m'
    # Arch news block
    NEWS=$HOME/.cache/archlinux.news
    touch "$NEWS"
    rss_url="https://archlinux.org/feeds/news/"
    last_modified=$(curl -sIm3 "$rss_url" | grep -oP "^last-modified: \K[0-9A-Za-z,: ]+")
    if [[ -n "${last_modified:-}" ]] && ! grep -q "$last_modified" "$NEWS"; then
        latestnews=$(curl -sm3 "$rss_url" | grep -Eo "<lastBuildDate>.*</title>" | sed -e 's/<[^>]*>/ /g;s/+0000  /GMT /g')
        if [[ -n "$latestnews" ]]; then
            echo "$latestnews" >"$NEWS"
            echo -e '\033[0;34m:: \033[0m\033[1mLatest news...\033[0m'
            echo "   $latestnews"
        fi
    fi
    # Working with updates
    paru -Syu
    if [[ "$TERM_PROGRAM" != "kgx" ]]; then
        read -n 1 -s -r -p "Press any key to exit..."
    fi
fi
