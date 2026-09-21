#!/usr/bin/env bash
# Secure lock: wipe clipboard history before engaging lock screen
cliphist wipe 2>/dev/null
loginctl lock-session
