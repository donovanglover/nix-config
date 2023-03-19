#!/bin/sh
# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

SCREENSHOT_DPI=$(xrdb -query | grep Xft.dpi | cut -f 2)
SCREENSHOT_SCALE=$(($SCREENSHOT_DPI / 96))

DATETIME=`date +%F_%H%M%S`
shotgun ~/$DATETIME.png
notify-send -t 2000 "Screenshot saved as" "$DATETIME.png"
