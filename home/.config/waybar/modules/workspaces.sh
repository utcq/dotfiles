#!/usr/bin/env bash

# Script is deprecated, use https://github.com/Alexays/Waybar/wiki/Module:-Niri#workspaces

case "$1" in
    focus-workspace)
        niri msg action "$@" && pkill -SIGRTMIN+8 waybar
        ;;
    up)
        niri msg action focus-workspace-up && pkill -SIGRTMIN+8 waybar
        ;;
    down)
        niri msg action focus-workspace-down && pkill -SIGRTMIN+8 waybar
        ;;
    *)
        glyphs=""
        workspace_str=" "
        for ws in $(niri msg -j workspaces | jq ".[] | select(.output == \"$1\") | .is_active"); do
            workspace_str="$workspace_str$(if "$ws"; then
                echo "<big><span color='#1793d1'>${glyphs:0:1}</span></big>"
            else echo "<small>${glyphs:1:1}</small>"; fi)  "
        done
        name=$(niri msg -j workspaces | jq -r ".[] | select(.output == \"$1\" and .is_active == true) | .name")
        echo -e "{\"text\":\"${workspace_str}\", \"tooltip\":\"Active workspace name: ${name}\"}"
        ;;
esac
