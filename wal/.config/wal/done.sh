#!/bin/sh

if [ -e ~/.config/bspwm/wal.sh ]; then
  ~/.config/bspwm/wal.sh
fi

if [ -e ~/.cache/wal/kitty ]; then
  for kitty_window in `fd kitty /tmp`; do
    kitty @ --to unix:$kitty_window set-colors -c -a ~/.cache/wal/kitty
  done
fi

if [ -e ~/.config/dunst/wal.sh ]; then
  ~/.config/dunst/wal.sh
fi

if [ -e ~/.config/tint2/wal.sh ]; then
  ~/.config/tint2/wal.sh
fi
