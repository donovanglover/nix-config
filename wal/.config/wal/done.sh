#!/bin/sh

# ===================
# ====== bspwm ======
# ===================

# Source the colors from wal
source "${HOME}/.cache/wal/colors.sh"

# Set the border colors
bspc config normal_border_color   "$color8"
bspc config active_border_color   "$color2"
bspc config focused_border_color  "$color7"
bspc config presel_feedback_color "$color7"

# Symlink dunst config
mkdir -p  "${HOME}/.config/dunst"
ln -sf    "${HOME}/.cache/wal/dunstrc"    "${HOME}/.config/dunst/dunstrc"

# Restart dunst with the new color scheme
pkill dunst
dunst &
