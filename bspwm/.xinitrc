# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

# Source the .Xresources file
xrdb -merge ~/.Xresources

# Source the files in the xinitrc.d directory
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Start the window manager
exec bspwm

# vim:ft=sh
