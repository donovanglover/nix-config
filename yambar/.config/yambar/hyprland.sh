#!/bin/bash

declare hypr_ws

while true; do
  hypr_ws=$(hyprctl workspaces -j | jq -r 'sort_by(.id)[] | .name' | sed -e "s/^special$/  特別/g" -e "s/^1:/  一/g" -e "s/^1$/  一/g" -e "s/^2/  二/g" -e "s/^3/  三/g" -e "s/^4/  四/g" -e "s/^5/  五/g" -e "s/^6/  六/g" -e "s/^7/  七/g" -e "s/^8/  八/g" -e "s/^9/  九/g" -e "s/^10/  十/g" | tr '\n' ' ')

  printf -- '%s\n' "hypr_ws|string|${hypr_ws}"
  printf -- '%s\n' ""

  sleep 0.1
done

unset hypr_ws
