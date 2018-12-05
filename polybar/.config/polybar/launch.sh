#!/bin/sh
# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

POLYBAR_DPI=$(xrdb -query | grep Xft.dpi | cut -f 2)
POLYBAR_SCALE=$(($POLYBAR_DPI / 96))

# Terminate any previous instances of polybar
killall -q polybar

bspc_config() {
  bspc config top_padding $1 &
  bspc config border_width $2 &
  bspc config window_gap $3 &
}

# Set defaults
POLYBAR_HEIGHT=$((40 * $POLYBAR_SCALE))
HOST_WIDTH=$(bspc query -T -m | jq '.rectangle.width')

# Make the bar float
if [ "$1" == "float" ]; then
  POLYBAR_BORDER_SIZE=$((1 * $POLYBAR_SCALE))     # Later set to bspwm's border_width
  POLYBAR_OFFSET_XY=$((30 * $POLYBAR_SCALE))      # Later set to bspwm's window_gap
  POLYBAR_WIDTH=$(($HOST_WIDTH - $POLYBAR_OFFSET_XY * 2))
else
  POLYBAR_WIDTH=$HOST_WIDTH
fi

# Set the bspwm variables
BSPWM_TOP_PADDING=$(($POLYBAR_HEIGHT + ${POLYBAR_OFFSET_XY:-0} + ${POLYBAR_BORDER_SIZE:-0} * 2))
BSPWM_BORDER_WIDTH=${POLYBAR_BORDER_SIZE:-$((1 * $POLYBAR_SCALE))}
BSPWM_WINDOW_GAP=${POLYBAR_OFFSET_XY:-$((20 * $POLYBAR_SCALE))}

bspc_config $BSPWM_TOP_PADDING $BSPWM_BORDER_WIDTH $BSPWM_WINDOW_GAP

# Make the polybar config
mkdir -p $HOME/.cache/polybar

cat >$HOME/.cache/polybar/config <<EOL
width                       = $POLYBAR_WIDTH
height                      = $POLYBAR_HEIGHT
offset-x                    = ${POLYBAR_OFFSET_XY:-0}
offset-y                    = ${POLYBAR_OFFSET_XY:-0}
border-size                 = ${POLYBAR_BORDER_SIZE:-0}
dpi                         = $POLYBAR_DPI
EOL

# Save the top_padding amount for use by other scripts
echo $BSPWM_TOP_PADDING > $HOME/.cache/polybar/bspwm_top_padding

# Wait until there are no more polybar instances running
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Start polybar
polybar main &
