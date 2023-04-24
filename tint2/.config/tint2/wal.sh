#!/bin/sh

# Symlink tint2 config
ln -sf ~/.cache/wal/tint2rc ~/.config/tint2/tint2rc

# Restart tint2 with the new color scheme
killall -SIGUSR1 tint2

# Fix bar showing above fullscreen programs
~/.config/tint2/fullscreen.sh
