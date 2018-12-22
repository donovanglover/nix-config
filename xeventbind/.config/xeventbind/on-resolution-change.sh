#!/bin/sh

# Get the host width
HOST_WIDTH=$(bspc query -T -m | jq '.rectangle.width')

CURSOR_THEME=${XCURSOR_THEME:-breeze_cursors}

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

  # Change the X cursor size as well
  # NOTE: For full effect, this needs to be used in combination with XCURSOR_SIZE.
  # NOTE: ($X_DPI / 6) here means that 4k will use cursor size 32, so it will appear
  #       about half the size of the 1080p cursor. If this is not what you want, use
  #       cursor size 64 instead.
  xsetroot -xcf "/usr/share/icons/$CURSOR_THEME/cursors/left_ptr" "$(($X_DPI / 6))"
fi

# Reload polybar with the new width / DPI
~/.config/polybar/launch.sh main &
