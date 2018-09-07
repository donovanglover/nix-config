# Easily change the resolution to 4k
# Note: Also changes DPI, but not for the programs you already have open.
# TODO: Change this script to support fish
function 4k
    # Get the display type (VGA-1, etc.)
    local display=$(xrandr | grep -Eo ".{0,20} connected" | awk '{print $1}')

    # Get the default mode name for 4k
    local mode=$(cvt 3840 2160 | grep "Modeline" | awk '{print $2}')

    # If the 4k mode hasn't been added yet
    if not (xrandr | grep -q 3840x2160)

        # Create the new mode with cvt settings
        xrandr --newmode $(cvt 3840 2160 | grep -o '"3840x2160.*')

        # Add the new mode to the display with xrandr
        xrandr --addmode ${display} ${mode}
    end

    xrandr --output ${display} --mode ${mode}       # Change the resolution to 4k
    sed -i '/Xft.dpi/c\Xft.dpi: 180' ~/.Xresources  # Change the dpi line to 180
    xrdb ~/.Xresources                              # Reload .Xresources
end
