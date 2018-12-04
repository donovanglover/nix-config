#!/bin/sh

# Get the host width
HOST_WIDTH=$(bspc query -T -m | jq '.rectangle.width')

# Determine the DPI based on screen width
if [ "$HOST_WIDTH" -eq "1920" ]; then
  X_DPI=96
fi

if [ "$HOST_WIDTH" -eq "3840" ]; then
  X_DPI=192
fi

# Reposition the desktop background
~/.fehbg &

# If the DPI needs to be changed, change it
if [ "$X_DPI" ]; then
  echo "Xft.dpi:$X_DPI" | xrdb -merge
fi

# Reload polybar with the new width / DPI
~/.config/polybar/launch.sh main &
