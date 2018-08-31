#!/bin/sh
# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017 Donovan Glover

# Terminate any previous instances of polybar
killall -q polybar

# Wait until there are no more polybar instances running
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Start polybar
polybar secondary &
