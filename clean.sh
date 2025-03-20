#!/bin/bash

CONFIG_DIR=".config"

REMOVE_ITEMS=(
    # Caches & Logs
    ".cache"
    ".logs"

    # System & Session Data
    "pulse"
    "yay"
    "dconf"
    "session"
    "systemd"

    # Applications with user/session-specific data
    "Code"
    "Element"
    "qBittorrent"
    "qutebrowser"
    "vesktop"

    # GNOME/KDE/Desktop Environment Settings (Auto-Generated)
    "gnome-session"
    "gnome-shell"
    "gtk-3.0"
    "gtk-4.0"
    "gtkrc"
    "gtkrc-2.0"

    # Remove **ALL** Plasma/KDE configs (since you don't use it)
    "plasma-*"
    "kactivitymanagerd-*"
    "kde.org"
    "kdedefaults"
    "kded5rc"
    "kwinrc"
    "ksmserverrc"
    "ktimezonedrc"
    "plasmashellrc"
    "powermanagementprofilesrc"
    "plasma-localerc"
    "plasma-org.kde.plasma.desktop-appletsrc"
    "dolphinrc"

    # Other Auto-Generated Settings & Configs
    "baloofilerc"
    "fastfetch"
    "neofetch"
    "glib-2.0"
    "kitty"
    "mousepad"
    "mpv"
    "ncspot"
    "rizin"
    "rofi"
    "Thunar"
    "Trolltech.conf"
    "QtProject.conf"
    "unity3d"
    "swappy"
    "spotify"
    "sqlitebrowser"
    "wireshark"

    # PulseAudio settings
    "pavucontrol.ini"

    # Miscellaneous
    "mimeapps.list"
    "user-dirs.dirs"
    "user-dirs.locale"

    "old_nvim"
    "nextjs-nodejs"
    "create-next-app-nodejs"

    "nautilus"

    "kactivitymanagerd-statsrc"
    "kactivitymanagerdrc"
    "kcminputrc"
    "kconf_updaterc"
    "kdeglobals"
    "kglobalshortcutsrc"

    "deepin"
    "beekeeper-studio"
    "epiphany"
    "evolution"
    "github-copilot"
    "go"
    "goa-1.0"
    "heroic"
    "qt5ct"
    "qt6ct"
    "ibus"
    "xfce4"
    "btop"
)

for item in "${REMOVE_ITEMS[@]}"; do
    TARGET="$CONFIG_DIR/$item"
    if [ -e "$TARGET" ]; then
        echo "Removing $TARGET..."
        rm -rf "$TARGET"
    fi
done

echo "Cleanup complete."

