#!/bin/sh
#
# Fix bar showing above fullscreen programs
xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" $(xdo id -n tint2)
