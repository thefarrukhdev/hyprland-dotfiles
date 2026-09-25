#!/usr/bin/env bash

# Toggle Rofi: agar ochiq bo'lsa, yopamiz.
if pgrep -x rofi >/dev/null; then
    pkill -x rofi
    exit 0
fi

# Tanlovni olish
CHOICE=$(cliphist list | rofi -dmenu -p "📋 Clipboard")

# Agar foydalanuvchi ESC bossa (bo'sh tanlov), klipbordni o'chirib yubormaslik uchun tekshiruv
if [[ -n "$CHOICE" ]]; then
    echo "$CHOICE" | cliphist decode | wl-copy
fi
