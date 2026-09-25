#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/screenshot_$(date +%Y%m%d_%H%M%S).png"

# Slurp orqali koordinatalarni olish. Agar ESC bosilsa, skript shu joyda to'xtaydi (bo'sh fayl yaratilmaydi)
GEOM=$(slurp) || exit 1

# Rasmga olish va nusxalash
if grim -g "$GEOM" "$FILE"; then
    wl-copy -t image/png < "$FILE"
    notify-send "📸 Screenshot" "Rasm saqlandi va nusxalandi!" -i "$FILE" -t 3000
else
    notify-send "❌ Xatolik" "Rasmga olishda xatolik yuz berdi." -t 3000
fi
