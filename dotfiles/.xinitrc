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

# Start compton
compton -b

# Set the desktop background
feh --no-fehbg --bg-fill ~/.config/feh/back.jpg

# ip link then dhcpcd to get an active internet connection
ip link
sudo dhcpcd

# Start the window manager
exec i3

# vim:ft=zsh
