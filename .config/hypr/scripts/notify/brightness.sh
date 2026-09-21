#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# notify/brightness.sh — Brightness OSD Notification
# ─────────────────────────────────────────────────────────────────────────────
# Purpose : Adjust screen brightness AND show an in-place OSD notification.
# Usage   : brightness.sh <up|down>
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail
source "$(dirname "$0")/lib.sh"

# ── Input Validation ──────────────────────────────────────────────────────────
ACTION="${1:-}"
if [[ ! "$ACTION" =~ ^(up|down)$ ]]; then
    echo "Usage: $(basename "$0") <up|down>" >&2
    exit 1
fi

# ── Apply Brightness Change ───────────────────────────────────────────────────
case "$ACTION" in
    up)   brightnessctl -e4 -n2 set 5%+ ;;
    down) brightnessctl -e4 -n2 set 5%- ;;
esac

# ── Read Current State ────────────────────────────────────────────────────────
current=$(brightnessctl get)
maximum=$(brightnessctl max)
pct=$(( current * 100 / maximum ))

# ── Select Icon Based on Level ────────────────────────────────────────────────
if   (( pct <= 20 )); then icon="display-brightness-low-symbolic"
elif (( pct <= 70 )); then icon="display-brightness-medium-symbolic"
else                       icon="display-brightness-high-symbolic"
fi

notify_osd "$icon" "🔆  Yorqinlik" "$pct"
