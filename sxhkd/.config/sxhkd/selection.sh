#!/bin/sh -e

DATETIME=`date +%F_%H%M%S`

if [[ "$1" == "clipboard" ]]; then
  shotgun $(hacksaw -f "-i %i -g %g") - | xclip -t 'image/png' -selection clipboard
else
  shotgun $(hacksaw -f "-i %i -g %g") ~/$DATETIME.png
fi
