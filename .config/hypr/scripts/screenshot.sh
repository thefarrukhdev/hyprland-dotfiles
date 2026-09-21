#!/usr/bin/env bash
mkdir -p "$HOME/Pictures/Screenshots"
FILE="$HOME/Pictures/Screenshots/screenshot_$(date +%Y%m%d_%H%M%S).png"
grim -g "$(slurp)" - | tee "$FILE" | wl-copy -t image/png
notify-send "Screenshot" "Saved to Pictures/Screenshots and copied to clipboard" -t 3000
