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

# Ensure that a <localuser> was given so we can run commands from it
if [ -z "$1" ]; then
    echo "You need to specify a local user to use."
    echo "Usage: yay.sh <localuser>"
    exit 1
fi

# Store the local user in a variable so we can use it inside of functions
LOCALUSER=$1

# Keep track of the temp directory we use to install the packages
TEMP="/home/$LOCALUSER/temp"

# Build and install packages manually
function build() {

    cd $TEMP # Move into the temp directory

    # Clone as the root user since the local user can't
    git clone https://aur.archlinux.org/$1.git 

    # Give the local user permission to use the new folder from git
    chmod -R a+rwX $1/

    cd $1/ # Move into the new folder

    # Explicitly tell makepkg where to store files
    export BUILDDIR="$TEMP/$1" 

    # Make the package as the local user since the root user can't
    su $LOCALUSER --session-command 'makepkg -si --noconfirm'
    
    # Finally install the package as root since the local user can't
    pacman -U $TEMP/$1/*.pkg.tar.xz --noconfirm

}

mkdir -v $TEMP  # Make the temp directory
build yay       # Install yay, our AUR helper of choice
rm -rfv $TEMP   # Clean up
