#!/usr/bin/env bash

# Check if current workspace has windows
active_workspace=$(hyprctl activeworkspace -j)
workspace_id=$(echo "$active_workspace" | jq '.id')
windows_count=$(echo "$active_workspace" | jq '.windows')

if [ "$windows_count" -gt 0 ]; then
    # We are on a workspace with windows. Save it and go to an empty one.
    echo "$workspace_id" > /tmp/last_workspace
    hyprctl dispatch 'hl.dsp.focus({ workspace = "empty" })'
else
    # We are on an empty workspace.
    if [ -f /tmp/last_workspace ]; then
        last_ws=$(cat /tmp/last_workspace)
        hyprctl dispatch "hl.dsp.focus({ workspace = $last_ws })"
        rm /tmp/last_workspace
    else
        # Fallback to previous if no file exists
        hyprctl dispatch 'hl.dsp.focus({ workspace = "previous" })'
    fi
fi
