# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

####################################################################
# Screen resolution functions (also changes DPI, but not for the
# programs and other software that you already have open)
####################################################################

# Easily change the resolution to 1080p
function 1080p() {
    xrandr --output VGA-1 --mode "1920x1080"        # Change the resolution
    sed -i '/Xft.dpi/c\Xft.dpi: 96' ~/.Xresources   # Change the dpi line to 96
    xrdb ~/.Xresources                              # Reload .Xresources
}

# Easily change the resolution to 4k
function 4k() {
    # Get the display type (VGA-1, etc.)
    local display=$(xrandr | grep -Eo ".{0,20} connected" | awk '{print $1}')

    # Get the default mode name for 4k
    local mode=$(cvt 3840 2160 | grep "Modeline" | awk '{print $2}')

    # If the 4k mode hasn't been added yet
    if [[ !(xrandr | grep -q 3840x2160) ]]; then

        # Create the new mode with cvt settings
        xrandr --newmode $(cvt 3840 2160 | grep -o '"3840x2160.*')

        # Add the new mode to the display with xrandr
        xrandr --addmode ${display} ${mode}

    fi

    xrandr --output ${display} --mode ${mode}       # Change the resolution to 4k
    sed -i '/Xft.dpi/c\Xft.dpi: 180' ~/.Xresources  # Change the dpi line to 180
    xrdb ~/.Xresources                              # Reload .Xresources
}

####################################################################
# Git functions
####################################################################

# Easily clone and cd into GitHub repositories
# Usage: hub username/repository [upstream]
function hub() {
    git clone ssh://git@github.com/$1.git
    cd $(basename "$1")
    if [[ $2 ]]; then
        git remote add upstream ssh://git@github.com/$2/$(basename "$1").git
    fi
}

# Do the same for GitLab
function lab() {
    git clone git@gitlab.com:$1.git
    cd $(basename "$1")
}

# Easily cd into the "home" directory of any repository you're working in
# This needs to be a function instead of an alias since it relies on `external calls`
function gh() {
    cd `git rev-parse --show-toplevel`
}

####################################################################
# Utility functions
####################################################################

# Take a screenshot after a certain amount of time
function ss() {
	(sleep $1 && shotgun) &
}

# Automatically open the readme in any repository
function readme() {
    local readme=`ls | rg README`
    if [[ $readme ]]; then
        nvim $readme
    else
        echo "No README found."
    fi
}
