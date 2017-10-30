##################################################################################
#
#    New Start: A modern Arch workflow built with an emphasis on functionality.
#    Copyright (C) 2017 Donovan Glover
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
##################################################################################

# Ensure that a <localuser> was given so we can use pacaur from it
if [ -z "$1" ]; then
    echo "You need to specify a local user to use."
    echo "Usage: aur.sh <localuser>"
    exit 1
fi

# Store the local user in a variable so we can use it inside get()
LOCALUSER=$1

# Handle installing packages from the AUR
function get() {
    su $LOCALUSER --session-command "pacaur -S $1 --noconfirm --noedit"
}

get i3-gaps         # Install i3-gaps, our window manager of choice
get shotgun         # Install shotgun, our screenshot utility of choice
get inox-bin        # Install inox, our chromium variant of choice
get waterfox-bin    # Install waterfox, our firefox variant of choice
get ttf-noto        # Install the noto fonts, used for extended language support
get polybar         # Install polybar, our panel system of choice
