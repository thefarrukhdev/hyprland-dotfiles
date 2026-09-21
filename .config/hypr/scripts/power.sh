#!/usr/bin/env bash

case "$1" in
    lock)
        # We already have a secure lock script, use it
        ~/.config/hypr/scripts/lock.sh
        ;;
    exit)
        # Safely exit Hyprland
        hyprctl dispatch exit
        ;;
    suspend)
        # Optional: lock the screen before sleeping
        ~/.config/hypr/scripts/lock.sh &
        sleep 1
        systemctl suspend
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 {lock|exit|suspend|reboot|shutdown}"
        exit 1
        ;;
esac
