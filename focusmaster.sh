#!/bin/sh

# Temporary make the animation a fade for effect
hyprctl keyword animation workspaces,1,12,default,fade

# Get the workspace ID of the current window
cw=`hyprctl activewindow -j`
oldWorkspaceID=`echo "$cw" | jq -r '.workspace.id'`
oldAddress=`echo "$cw" | jq -r '.address'`

# Get the number of windows on the workspace (0 = do nothing, 2 or more = swap)
numWindowsOnWorkspace=`hyprctl workspaces -j | jq -r ".[] | select(.id==$oldWorkspaceID) | .windows"`

if [[ "$numWindowsOnWorkspace" -gt 1 ]]; then
  # Focus the master window
  hyprctl dispatch layoutmsg focusmaster master

  # If the master window is the same, focus the last window
  nw=`hyprctl activewindow -j`
  newAddress=`echo "$nw" | jq -r '.address'`
  if [[ "$newAddress" == "$oldAddress" ]]; then
    hyprctl dispatch focuscurrentorlast

    # If the workspaces are not the same, revert & focus the first child instead
    newWorkspaceID=`hyprctl activewindow -j | jq -r '.workspace.id'`
    if [[ "$oldWorkspaceID" != "$newWorkspaceID" ]]; then
      # Only do so if we're not in the special workspace
      if [[ "$newWorkspaceID" != "-99" ]]; then
        hyprctl dispatch focuscurrentorlast
        hyprctl dispatch layoutmsg focusmaster
      fi
    fi
  fi
fi

sleep 0.1

# Use the default animation once more.
hyprctl keyword animation workspaces,1,6,default
