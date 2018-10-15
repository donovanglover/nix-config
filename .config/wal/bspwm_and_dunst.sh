#!/bin/sh

# Source the colors from wal
source "${HOME}/.cache/wal/colors.sh"

# Set the border colors if bspwm is running
if [ -n "$(wmctrl -m | grep 'bspwm')" ]; then
  bspc config normal_border_color   "$color1"
  bspc config active_border_color   "$color2"
  bspc config focused_border_color  "$color15"
  bspc config presel_feedback_color "$color1"
fi

# Restart dunst with the new color scheme, only if
# we're not using Plasma
if ! [ "$DESKTOP_SESSION" == "Plasma" ]; then
  pkill dunst
  dunst -conf "${HOME}/.cache/wal/dunstrc"
fi
