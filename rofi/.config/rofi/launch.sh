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

ROFI_DPI=$(xrdb -query | grep Xft.dpi | cut -f 2)
ROFI_SCALE=$(expr $ROFI_DPI / 96)
ROFI_DPI_SCALE=$(awk "BEGIN { print "1/$ROFI_SCALE" }")

env \
  XDG_CURRENT_DESKTOP="KDE" \
  QT_AUTO_SCREEN_SCALE_FACTOR="0" \
  QT_FONT_DPI="$ROFI_DPI" \
  QT_SCREEN_SCALE_FACTORS="VGA-1=$ROFI_SCALE;" \
  GDK_SCALE="$ROFI_SCALE" \
  GDK_DPI_SCALE="$ROFI_DPI_SCALE" \
  rofi \
    -show drun \
    -dpi "$ROFI_DPI"
