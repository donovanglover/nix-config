#!/bin/sh
# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2018 Donovan Glover

DROPDOWN_DPI=$(xrdb -query | grep Xft.dpi | cut -f 2)
DROPDOWN_SCALE=$(($DROPDOWN_DPI / 96))

c='kitty'         # Class
i='dropdown'      # Instance
x='kitty --name'  # Executable

# Note: This solution will not work with termite since it registers two ids.
# See https://github.com/thestinger/termite/issues/634 for more information.

id=$(xdo id -n $i)
rectangle=$((1700 * $DROPDOWN_SCALE))x$((600 * $DROPDOWN_SCALE))
offset=+$((110 * $DROPDOWN_SCALE))+$((100 * $DROPDOWN_SCALE))

bspc rule -r $c:$i
bspc rule -a $c:$i sticky=on state=floating rectangle=$rectangle$offset

([ -z "$id" ]) && ($x $i) ||
  ([[ $(xprop -id "$id" | awk '/window state: / {print $3}') == 'Withdrawn' ]] &&
    xdo show -n $i || xdo hide -n $i)
