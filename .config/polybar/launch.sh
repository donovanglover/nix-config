#!/bin/sh
# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

# Terminate any previous instances of polybar
killall -q polybar

bspc_config() {
  bspc config top_padding $1 &
  bspc config border_width $2 &
  bspc config window_gap $3 &
}

# If no bar was specified, we're done here.
if [ -z "$1" ]; then bspc_config 0 4 0; exit; fi

# Set defaults
POLYBAR_HEIGHT=80
HOST_WIDTH=$(bspc query -T -m | jq '.rectangle.width')

# Make the bar float
if [ "$1" == "float" ]; then
  POLYBAR_BORDER_SIZE=8     # Later set to bspwm's border_width
  POLYBAR_OFFSET_XY=30      # Later set to bspwm's window_gap
  POLYBAR_WIDTH=$(($HOST_WIDTH - $POLYBAR_OFFSET_XY * 2))
fi

# Set the bspwm variables
BSPWM_TOP_PADDING=$(($POLYBAR_HEIGHT + ${POLYBAR_OFFSET_XY:-0} + ${POLYBAR_BORDER_SIZE:-0} * 2))
BSPWM_BORDER_WIDTH=${POLYBAR_BORDER_SIZE:-8}
BSPWM_WINDOW_GAP=${POLYBAR_OFFSET_XY:-20}

bspc_config $BSPWM_TOP_PADDING $BSPWM_BORDER_WIDTH $BSPWM_WINDOW_GAP

# Make the polybar config
mkdir -p $HOME/.cache/polybar

cat >$HOME/.cache/polybar/config <<EOL
width                       = ${POLYBAR_WIDTH:-3840}
height                      = $POLYBAR_HEIGHT
offset-x                    = ${POLYBAR_OFFSET_XY:-0}
offset-y                    = ${POLYBAR_OFFSET_XY:-0}
border-size                 = ${POLYBAR_BORDER_SIZE:-0}
EOL

# Save the top_padding amount for use by other scripts
echo $BSPWM_TOP_PADDING > $HOME/.cache/polybar/bspwm_top_padding

# Wait until there are no more polybar instances running
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Start polybar
launch polybar main
