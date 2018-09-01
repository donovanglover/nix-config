# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

# Source the .Xresources and .xmodmap files
xrdb -merge ~/.Xresources
xmodmap ~/.xmodmap

# Source the files in the xinitrc.d directory
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Never blank the screen (disable power saving)
xset s off -dpms

# Start compton
compton -b

# Set the desktop background
feh --no-fehbg --bg-fill ~/.config/feh/back.png

# Start the window manager
exec bspwm

# vim:ft=zsh
