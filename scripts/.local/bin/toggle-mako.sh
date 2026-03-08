#!/usr/sbin/sh

if makoctl mode | grep -q dnd; then
    makoctl mode -r dnd
else
    makoctl mode -a dnd
fi
