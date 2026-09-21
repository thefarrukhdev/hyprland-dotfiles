#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# notify/battery-daemon.sh — Battery Level Monitor
# ─────────────────────────────────────────────────────────────────────────────
# Purpose : Runs as a systemd user service. Watches the battery level and
#           fires urgent notifications at configurable discharge thresholds.
#           Resets automatically when the charger is connected.
#
# Managed : systemctl --user {start|stop|status} battery-notify.service
# ─────────────────────────────────────────────────────────────────────────────
set -uo pipefail
source "$(dirname "$0")/lib.sh"

# ── Configuration ─────────────────────────────────────────────────────────────
readonly BATTERY_DEVICE="/org/freedesktop/UPower/devices/battery_BAT1"
readonly POLL_INTERVAL_SEC=60

# Alert thresholds (in %). Must be sorted descending.
declare -ra THRESHOLDS=(20 10 5)

# ── State ─────────────────────────────────────────────────────────────────────
last_notified_threshold=100   # Tracks which threshold we last notified about

# ── Helpers ───────────────────────────────────────────────────────────────────

get_battery_percent() {
    upower -i "$BATTERY_DEVICE" 2>/dev/null \
        | awk '/percentage/ { gsub(/%/, "", $2); print int($2) }'
}

get_battery_state() {
    upower -i "$BATTERY_DEVICE" 2>/dev/null \
        | awk '/state/ { print $2 }'
}

fire_alert() {
    local pct="$1"
    if   (( pct <= 5  )); then
        notify_alert "battery-caution" \
            "🔴  Batareya KRITIK: ${pct}%" \
            "Darhol zaryadga ulang! Kompyuter o'chib ketishi mumkin." \
            "critical" 0 "$NOTIFY_TAG_BATTERY"
    elif (( pct <= 10 )); then
        notify_alert "battery-low" \
            "🟠  Batareya kam: ${pct}%" \
            "Tez orada zaryadga ulang!" \
            "critical" 8000 "$NOTIFY_TAG_BATTERY"
    else
        notify_alert "battery-caution" \
            "🟡  Batareya: ${pct}%" \
            "Zaryadga ulashni o'ylang." \
            "normal" 5000 "$NOTIFY_TAG_BATTERY"
    fi
}

# ── Main Loop ─────────────────────────────────────────────────────────────────
while true; do
    pct=$(get_battery_percent)
    state=$(get_battery_state)

    if [[ -z "$pct" || -z "$state" ]]; then
        sleep "$POLL_INTERVAL_SEC"
        continue
    fi

    # Reset state when charger is plugged in
    if [[ "$state" == "charging" || "$state" == "fully-charged" ]]; then
        last_notified_threshold=100
        sleep "$POLL_INTERVAL_SEC"
        continue
    fi

    # Fire the first applicable threshold not yet notified
    if [[ "$state" == "discharging" ]]; then
        for threshold in "${THRESHOLDS[@]}"; do
            if (( pct <= threshold && last_notified_threshold > threshold )); then
                fire_alert "$pct"
                last_notified_threshold="$threshold"
                break
            fi
        done
    fi

    sleep "$POLL_INTERVAL_SEC"
done
