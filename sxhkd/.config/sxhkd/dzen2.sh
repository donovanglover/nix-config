#!/bin/sh
# Display brief desktop name notification at the center of the screen.
#
# Based on u/xircon's solution here:
# https://old.reddit.com/r/bspwm/comments/lhvtw7/osd_notifications_on_changing_desktop/

# Kill any old instances of dzen2 to prevent overlapping of notifications
pkill -x dzen2

# Display Variables:
hgt=128 # font size
wid=$((hgt*2)) # e.g. 3.5 times the height, will display the words 'Three' &  'Seven' correctly.
time=1
font="-*-Noto Sans CJK JP-bold-r-*-*-"$hgt"-*-*-*-*-*-*-*"

# Screen Resolution calculations:
full_res=$(cut -d " " -f 1  <<< $(xrandr | grep '*' | xargs)) # xargs removes leading spaces
res_wid="${full_res%%x*}" # Left of 'x' in 1600x900
res_hgt="${full_res##*x}"  # Right of 'x'

# Do some calculations for x & y coordinates:
x=$((a=res_wid-wid, xx=a/2))
y=$((b=res_hgt-hgt-2, yy=b/2))

Deskname=$(bspc query -D -d focused --names)

# Display desktop number in the center of the screen:
echo "$Deskname" | dzen2 -bg "#000000" -w $wid -x $x -y $y -p $time -fn "$font"
