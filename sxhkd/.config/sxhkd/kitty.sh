#!/bin/sh

SOCK=$(fd kitty --base-directory /tmp -d 1)
KITTY=$(xdotool search --class kitty)

[ -n "$KITTY" ] && \
  ([ -e "/tmp/$SOCK" ] && \
    (kitty @ --to "unix:/tmp/$SOCK" launch --type=tab && \
    bspc node $KITTY -f)) \
  || kitty --single-instance --start-as maximized
