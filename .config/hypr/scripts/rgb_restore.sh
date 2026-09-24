#!/bin/bash
# Wait for the compositor and key services (like waybar) to be fully loaded
until pgrep -x waybar > /dev/null; do
    sleep 0.5
done
# Small delay to ensure waybar has settled if rgb-panel interacts with it or the display
sleep 0.5
~/.local/bin/rgb-panel --restore
