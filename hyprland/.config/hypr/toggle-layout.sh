#!/bin/sh

if [[ "$(hyprctl -j getoption general:layout | jq -r '.str')" == "master" ]]; then
  hyprctl keyword general:layout "dwindle"
else
  hyprctl keyword general:layout "master"
fi
