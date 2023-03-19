#!/bin/sh

SOCK=$(fd kitty --base-directory /tmp -d 1)
KITTY=$(xdotool search --class kitty)

[ -e "/tmp/opacity-of-terminal" ] || echo 0.9 > /tmp/opacity-of-terminal

[ "$1" == "up" ] && \
  NEXT=$(fish -N -c "math (cat /tmp/opacity-of-terminal) + 0.02") ||
  NEXT=$(fish -N -c "math (cat /tmp/opacity-of-terminal) - 0.02")

[ "$1" == "up" ] && [ "$(cat /tmp/opacity-of-terminal)" == "1" ] && NEXT=1
[ "$1" == "down" ] && [ "$(cat /tmp/opacity-of-terminal)" == "0" ] && NEXT=0

echo "$NEXT" > /tmp/opacity-of-terminal

[ "$1" == "up" ] && \
  notify-send -t 1000 "kitty" "Increased opacity to $NEXT" ||
  notify-send -t 1000 "kitty" "Decreased opacity to $NEXT"

[ -n "$KITTY" ] && \
  ([ -e "/tmp/$SOCK" ] && \
    (kitty @ --to "unix:/tmp/$SOCK" set-background-opacity "$NEXT"))
