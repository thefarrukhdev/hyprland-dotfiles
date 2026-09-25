#!/usr/bin/env bash

# Waybar yuklanishini maksimal 10 soniya kutish (Infinity Loop/Qotib qolishning oldini olish)
for i in {1..20}; do
    if pgrep -x waybar > /dev/null; then
        sleep 0.5
        ~/.local/bin/rgb-panel --restore
        exit 0
    fi
    sleep 0.5
done

# Agar Waybar umuman ishga tushmasa ham, baribir RGB ni tiklash
~/.local/bin/rgb-panel --restore
