#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# notify/volume.sh — Volume OSD Notification
# ─────────────────────────────────────────────────────────────────────────────
# Purpose : Change system volume AND show an OSD notification in one atomic
#           script, keeping keybinds.lua clean (single exec per bind).
# Usage   : volume.sh <up|down|mute>
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail
source "$(dirname "$0")/lib.sh"

# ── Input Validation ──────────────────────────────────────────────────────────
ACTION="${1:-}"
if [[ ! "$ACTION" =~ ^(up|down|mute)$ ]]; then
    echo "Usage: $(basename "$0") <up|down|mute>" >&2
    exit 1
fi

# ── Apply Volume Change ───────────────────────────────────────────────────────
case "$ACTION" in
    up)   wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ ;;
    down) wpctl set-volume       @DEFAULT_AUDIO_SINK@ 5%-  ;;
    mute) wpctl set-mute         @DEFAULT_AUDIO_SINK@ toggle ;;
esac

# ── Read Current State ────────────────────────────────────────────────────────
raw_output=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
is_muted=$(echo "$raw_output" | grep -c "MUTED" || true)
vol=$(echo "$raw_output" | awk '{printf "%.0f", $2 * 100}')

# ── Select Icon Based on Level ────────────────────────────────────────────────
if (( is_muted )); then
    notify_osd "audio-volume-muted" "🔇  Mute" 0
else
    if   (( vol <= 30 )); then icon="audio-volume-low"
    elif (( vol <= 70 )); then icon="audio-volume-medium"
    else                       icon="audio-volume-high"
    fi
    notify_osd "$icon" "🔊  Ovoz" "$vol"
fi
