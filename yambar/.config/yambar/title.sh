#!/bin/bash

declare title

# LATER: Use hyprevents instead of while true
while true; do
  title="$(hyprctl activewindow -j | jq -r '.title')"

  if [[ "$title" == "null" ]]; then
    title="♫ $(mpc status | head -n 1)"
  fi

  printf -- '%s\n' "title|string|${title}"
  printf -- '%s\n' ""

  sleep 0.1
done

unset title
