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

#########################################################################
# Language settings: used for localization, etc.
#########################################################################

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen      # Use the en_US.UTF-8 locale
echo "KEYMAP=us"         > /etc/vconsole.conf   # Explicitly set the keymap to US
echo "LANG=en_US.UTF-8"  > /etc/locale.conf     # Set the language to en_US.UTF-8

#########################################################################
# Systemd settings: changes how the core system works
#########################################################################

SYSTEMD="/etc/systemd/system.conf"

# Change the wait time from 90s to 10s, preventing the system from hanging at shutdown
echo "DefaultTimeoutStartSec=10s" >> $SYSTEMD
echo "DefaultTimeoutStopSec=10s" >> $SYSTEMD

#########################################################################
# Pacman settings: used by pacman and pacaur
#########################################################################

PACMAN="/etc/pacman.conf"

# Enable colors in pacman by uncommenting the Color line
sed -i '/Color/s/^#//g' $PACMAN

#########################################################################
# Global font settings: we have to soft link the settings we want here
#########################################################################

FONTS="/etc/fonts"

# Disable embedded bitmaps for all fonts
ln -s $FONTS/conf.avail/70-no-bitmaps.conf $FONTS/conf.d

# Enable sub-pixel RGB rendering
ln -s $FONTS/conf.avail/10-sub-pixel-rgb.conf $FONTS/conf.d

# Enable the LCD filter (reduces color fringing)
ln -s $FONTS/conf.avail/11-lcdfilter-default.conf $FONTS/conf.d 

#########################################################################
# Sudo settings: allows us to use su without prompting for a password
# Particularly useful when installing cower and pacaur, etc.
#########################################################################

# Note that this setting gets changed in the clean up stage of the build process
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
