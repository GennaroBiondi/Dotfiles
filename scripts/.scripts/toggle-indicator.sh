#!/usr/bin/env sh

STATE_FILE=/tmp/indicator.enabled

if [ -f "$STATE_FILE" ]; then
    rm -f "$STATE_FILE"
else
    touch "$STATE_FILE"
fi

pkill -SIGRTMIN+1 waybar
