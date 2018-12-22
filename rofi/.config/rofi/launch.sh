#!/bin/sh
# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2018 Donovan Glover

# This script will find the X server DPI and apply the necessary
# settings to make Rofi, X, GNOME, and KDE applications have the
# proper scaling, with no intervention from the user necessary.

# Note that XDG_CURRENT_DESKTOP is required for KDE/Qt applications to
# have the proper theming in non-Plasma environments. In contrast, GNOME
# respects its theming even when XDG_CURRENT_DESKTOP is not set to it
# (through settings.ini).

# Note that the xcursor size is specified with:
#
#   1. The X server resource database (xrdb), of which cursor size is
#      only applied BEFORE your window manager starts
#   2. The xsetroot command, which affects the cursor shown on the root
#      window (your desktop)
#   3. The XCURSOR_SIZE environment variable, which affects the current
#      program
#
# There are a few things to take away from this:
#
#   1. The root window (desktop) cursor size MUST be changed with xsetroot
#   2. KDE applications will honor XCURSOR_SIZE but NOT xsetroot
#   3. GTK applications will honor xsetroot but NOT XCURSOR_SIZE
#
# Additionally,
#
#   4. SOME X applications require XCURSOR_SIZE to be set and will NOT
#      honor xsetroot
#   5. SOME X applications require xsetroot to be set and will NOT
#      honor XCURSOR_SIZE
#
# So for a consistent variable cursor DPI environment, one has to set BOTH
# xsetroot and XCURSOR_SIZE
#
# Note that existing windows will NOT have their X cursor size changed
# if they don't depend on xsetroot. Because of this, and because of the
# fact that active windows will not handle DPI changes anyway, you should
# probably have no GUIs running when switching DPI.

ROFI_DPI=$(xrdb -query | grep Xft.dpi | cut -f 2)
ROFI_SCALE=$(expr $ROFI_DPI / 96)
ROFI_DPI_SCALE=$(awk "BEGIN { print "1/$ROFI_SCALE" }")

CURSOR_THEME=${XCURSOR_THEME:-breeze_cursors}
CURSOR_SIZE=$((16 * $ROFI_SCALE))

xsetroot -xcf "/usr/share/icons/$CURSOR_THEME/cursors/left_ptr" "$CURSOR_SIZE"

env \
  XDG_CURRENT_DESKTOP="KDE" \
  QT_AUTO_SCREEN_SCALE_FACTOR="0" \
  QT_FONT_DPI="$ROFI_DPI" \
  QT_SCREEN_SCALE_FACTORS="VGA-1=$ROFI_SCALE;" \
  GDK_SCALE="$ROFI_SCALE" \
  GDK_DPI_SCALE="$ROFI_DPI_SCALE" \
  XCURSOR_SIZE="$CURSOR_SIZE" \
  rofi \
    -show drun \
    -dpi "$ROFI_DPI"
