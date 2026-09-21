#!/usr/bin/env bash
repo=$(checkupdates 2>/dev/null | grep -c '^')
aur=$(yay -Qua 2>/dev/null | grep -c '^')
total=$((repo + aur))
if [ "$total" -gt 0 ]; then
    echo "{\"text\": \"$total\", \"tooltip\": \"Official: $repo\nAUR: $aur\"}"
else
    echo "{\"text\": \"\", \"tooltip\": \"System up to date\"}"
fi
