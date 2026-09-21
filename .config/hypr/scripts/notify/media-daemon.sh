#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# notify/media-daemon.sh — Now Playing Track-Change Notification
# ─────────────────────────────────────────────────────────────────────────────
# Purpose : Runs as a systemd user service. Listens for MPRIS player events
#           via playerctl --follow and fires a notification whenever the
#           currently playing track changes.
#
# Managed : systemctl --user {start|stop|status} media-notify.service
# ─────────────────────────────────────────────────────────────────────────────
set -uo pipefail
source "$(dirname "$0")/lib.sh"

# ── Helpers ───────────────────────────────────────────────────────────────────

# Extracts the album art path from MPRIS metadata, if available.
get_art_path() {
    local raw
    raw=$(playerctl metadata mpris:artUrl 2>/dev/null || true)
    # Strip "file://" prefix so notify-send can use the path directly
    echo "${raw/#file:\/\//}"
}

# Fires the track notification with graceful metadata fallbacks.
fire_track_notification() {
    local title="$1"
    local artist="$2"
    local player="$3"
    local art_path icon body

    art_path=$(get_art_path)
    icon="audio-x-generic"
    [[ -f "$art_path" ]] && icon="$art_path"

    body="$artist"
    [[ -n "$player" ]] && body="${body}  ·  ${player}"

    notify_alert "$icon" "🎵  $title" "$body" "low" "3000" "$NOTIFY_TAG_MEDIA"
}

# ── Main: Event Loop ──────────────────────────────────────────────────────────
# playerctl --follow emits a line on every MPRIS metadata change.
# We use a custom format separator "|||" to safely split fields.
last_title=""

playerctl --follow --format "{{title}}|||{{artist}}|||{{playerName}}" metadata 2>/dev/null \
    | while IFS= read -r line; do
        title=$(echo "$line"  | awk -F'[|][|][|]' '{print $1}')
        artist=$(echo "$line" | awk -F'[|][|][|]' '{print $2}')
        player=$(echo "$line" | awk -F'[|][|][|]' '{print $3}')

        # Only notify on actual track change, not metadata refreshes
        if [[ -n "$title" && "$title" != "$last_title" ]]; then
            fire_track_notification "$title" "$artist" "$player"
            last_title="$title"
        fi
    done
