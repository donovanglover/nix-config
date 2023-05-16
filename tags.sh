#!/bin/sh
# Tag-like script that moves windows from X workspace to the current workspace

# Get IDs of windows on the other workspace
ids="$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == "$1") | .address")"

# Move those windows to the current workspace
for id in $ids; do
  hyprctl dispatch movetoworkspacesilent "$(hyprctl activeworkspace -j | jq -r '.id')",address:"$id"
  hyprctl dispatch focuswindow address:"$id"
done
