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

# Turn error handling on so that any errors terminate the script
set -e

USAGE="Usage: ./install.sh <hostname> <localuser>"

if [ -z "$1" ]; then
    echo "You need to specify the hostname of your machine.\n$USAGE"
    exit 1
fi

if [ -z "$2" ]; then
    echo "You need to supply a name for the local user.\n$USAGE"
    exit 2
fi

# TODO: Initial installation

# TODO: Configuring the new system

# TODO: Install all the things

# TODO: Clean up and final changes for the new system

umount /mnt     # Unmount the filesystem
reboot          # Restart the system
