#!/usr/bin/env sh

STATE_FILE=/tmp/indicator.enabled

if [ -f "$STATE_FILE" ]; then
    echo '{"text": "●", "class": "enabled"}'
else
    echo '{"text": "", "class": "disabled"}'
fi
