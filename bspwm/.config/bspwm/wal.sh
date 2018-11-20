#!/bin/sh

# Source the colors from wal
source ~/.cache/wal/colors.sh

# Set the border colors
bspc config normal_border_color   "$color8"
bspc config active_border_color   "$color2"
bspc config focused_border_color  "$color7"
bspc config presel_feedback_color "$color7"
