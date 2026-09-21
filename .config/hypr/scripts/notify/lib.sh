#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# notify/lib.sh — Shared Notification Utility Library
# ─────────────────────────────────────────────────────────────────────────────
# Purpose : DRY foundation for all Hyprland system notifications.
# Usage   : source "$(dirname "$0")/lib.sh"
# Author  : Farrukh · Hyprland Pro Setup
# ─────────────────────────────────────────────────────────────────────────────

# ── Constants ─────────────────────────────────────────────────────────────────
# SwayNC synchronous hint: replaces the previous notification with the same tag
# instead of stacking them. Perfect for OSD-style feedback (volume, brightness).
readonly NOTIFY_TAG_OSD="x-canonical-private-synchronous"
readonly NOTIFY_TAG_BATTERY="hypr-battery"
readonly NOTIFY_TAG_MEDIA="hypr-media"

# ── Helpers ───────────────────────────────────────────────────────────────────

# make_bar <percent>
# Renders a 10-segment Unicode progress bar.
# Example: make_bar 70  →  "███████░░░"
make_bar() {
    local pct="$1"
    local bar="" i
    for ((i = 0; i < 10; i++)); do
        (( i < pct / 10 )) && bar+="█" || bar+="░"
    done
    echo "$bar"
}

# ── Notification Dispatchers ──────────────────────────────────────────────────

# notify_osd <icon> <title> <percent>
# OSD-style: updates the same notification in-place (no stacking).
# Uses both a Unicode bar and SwayNC's native progress hint.
notify_osd() {
    local icon="$1" title="$2" pct="$3"
    notify-send "$title" "$(make_bar "$pct")  ${pct}%" \
        --icon="$icon"                                  \
        --urgency=low                                   \
        --expire-time=2000                              \
        --hint="string:${NOTIFY_TAG_OSD}:hypr-osd"     \
        --hint="int:value:${pct}"
}

# notify_alert <icon> <title> <body> <urgency> <timeout_ms> <tag>
# General-purpose alert with explicit urgency and de-duplication tag.
notify_alert() {
    local icon="$1" title="$2" body="$3"
    local urgency="${4:-normal}" timeout="${5:-5000}" tag="${6:-hypr-alert}"
    notify-send "$title" "$body"                            \
        --icon="$icon"                                      \
        --urgency="$urgency"                                \
        --expire-time="$timeout"                            \
        --hint="string:${NOTIFY_TAG_OSD}:${tag}"
}
