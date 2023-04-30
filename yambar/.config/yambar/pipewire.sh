#!/bin/bash

declare pipewire

while true; do
  pw="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | choose 1)"
  muted="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | choose 2)"
  pw2="$(echo "$pw * 100 / 1" | bc)"
  if [[ "$muted" == "[MUTED]" ]]; then
    pipewire="  $pw2"
  else
    if [[ "$pw2" -gt 59 ]]; then
      pipewire="  $pw2"
    else
      if [[ "$pw2" -gt 0 ]]; then
        pipewire="  $pw2"
      else
        pipewire="  $pw2"
      fi
    fi
  fi

  printf -- '%s\n' "pipewire|string|${pipewire}%"
  printf -- '%s\n' ""

  sleep 0.1
done

unset pipewire
