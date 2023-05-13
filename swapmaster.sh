#!/bin/sh

# Temporary make the animation a fade for effect
hyprctl keyword animation workspaces,1,12,default,fade

# Get the workspace ID of the current window
cw=`hyprctl activewindow -j`
oldWorkspaceID=`echo "$cw" | jq -r '.workspace.id'`

# Get the number of windows on the workspace (0 = do nothing, 2 or more = swap)
numWindowsOnWorkspace=`hyprctl workspaces -j | jq -r ".[] | select(.id==$oldWorkspaceID) | .windows"`

# If there are no windows yet, function as a program launcher
if [[ $numWindowsOnWorkspace -eq 0 ]]; then
  kitty &
  hyprctl keyword animation workspaces,1,6,default,slidevert
  exit
fi

# Focus the master window
hyprctl dispatch layoutmsg focusmaster master

# Focus the last window
hyprctl dispatch focuscurrentorlast

# Get the workspace ID of the last window
newWorkspaceID=`hyprctl activewindow -j | jq -r '.workspace.id'`

# If the workspaces are the same, swap master with that last window.
if [[ "$oldWorkspaceID" == "$newWorkspaceID" ]]; then
  hyprctl dispatch layoutmsg swapwithmaster master
  oldFullscreen=`echo "$cw" | jq -r '.fullscreen'`
  oldFullscreenMode=`echo "$cw" | jq -r '.fullscreenMode'`
  if [[ "$oldFullscreen" == "true" ]]; then
    hyprctl dispatch fullscreen "$oldFullscreenMode"
  fi
else
  # Otherwise, don't do anything.
  hyprctl dispatch focuscurrentorlast
  oldFullscreen=`echo "$cw" | jq -r '.fullscreen'`
  oldFullscreenMode=`echo "$cw" | jq -r '.fullscreenMode'`
  if [[ "$oldFullscreen" == "true" ]]; then
    hyprctl dispatch fullscreen "$oldFullscreenMode"
  fi

  # If the new workspace is special, focus the last focused special window
  if [[ "$newWorkspaceID" == "-99" ]]; then
    hyprctl dispatch focuscurrentorlast
  fi

  # If there are more windows, swap
  if [[ $numWindowsOnWorkspace -gt 1 ]]; then
    hyprctl dispatch layoutmsg swapwithmaster
    hyprctl dispatch layoutmsg focusmaster master
  fi
fi

sleep 0.1

# Use the default animation once more.
hyprctl keyword animation workspaces,1,6,default,slidevert
