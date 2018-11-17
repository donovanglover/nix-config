#!/bin/sh
# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2018 Donovan Glover

c='kitty'         # Class
i='dropdown'      # Instance
x='kitty --name'  # Executable

# Note: This solution will not work with termite since it registers two ids.
# See https://github.com/thestinger/termite/issues/634 for more information.

id=$(xdo id -n $i)

bspc rule -r $c:$i
bspc rule -a $c:$i sticky=on state=floating rectangle=3400x1200+220+200

([ -z "$id" ]) && ($x $i) ||
  ([[ $(xprop -id "$id" | awk '/window state: / {print $3}') == 'Withdrawn' ]] &&
    xdo show -n $i || xdo hide -n $i)
