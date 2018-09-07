# Easily change the resolution to 1080p
# Note: Also changes DPI, but not for the programs you already have open.
function 1080p
    xrandr --output VGA-1 --mode "1920x1080"        # Change the resolution
    sed -i '/Xft.dpi/c\Xft.dpi: 96' ~/.Xresources   # Change the dpi line to 96
    xrdb ~/.Xresources                              # Reload .Xresources
end
