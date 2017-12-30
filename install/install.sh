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

# NOTE: The following assumptions are made:
#
# 1. You use the US keyboard layout. (A default in Arch Linux)
# 2. Your timezone is Eastern Time. (You can easily change this in the script)
# 3. You have secure boot disabled (Secure boot may prevent the computer from booting free software)
#
# Installation instructions:
# 
# ```
# wget https://raw.githubusercontent.com/GloverDonovan/new-start/master/install.sh
# chmod +x install.sh
# ./install.sh <HOSTNAME> <LOCALUSER>
# ```
#
# Note that the default password for your new account is the same as your username. Upon reboot, the X server should automatically start at login. Then:
#
# 1. Change the root password with `passwd`
# 2. Change the local account password with `passwd <username>`
#
# That's it! You're now ready to use your shiny new system!

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
timedatectl set-ntp true                                # Attempt to sync with the network time

parted /dev/sda mklabel msdos                           # Create a DOS partition table
parted /dev/sda mkpart primary ext4 1MiB 14GiB          # Create the root partition
parted /dev/sda set 1 boot on                           # Enable boot from the root partition
parted /dev/sda mkpart primary linux-swap 14GiB 100%    # Create the swap partition

mkfs -t ext4 /dev/sda1 && mount /dev/sda1 /mnt          # Make the filesystem and mount it
mkswap /dev/sda2 && swapon /dev/sda2                    # Make the swap partition and enable it

pacstrap /mnt base base-devel                           # Install Arch on the new filesystem
genfstab -U /mnt > /mnt/etc/fstab                       # Mount the filesystem automatically on boot

# TODO: Configuring the new system
./install/system.sh

# Configure the hostname
echo "$1" > /mnt/etc/hostname
echo "127.0.1.1 $1.localdomain $1" >> /mnt/etc/hosts

# Generate locales for en_US.UTF-8
arch-chroot /mnt locale-gen

arch-chroot /mnt pacman -S grub --noconfirm # Download grub
arch-chroot /mnt grub-install /dev/sda  # Install it to the root partition

arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg                        # Make the configuration file for grub

arch-chroot /mnt mkinitcpio -p linux               # Save our hardware information

# Edit system configuration files directly
arch-chroot /mnt sed -i '/Color/s/^#//g' /etc/pacman.conf   # Uncomment the Color line in /etc/pacman.conf (enables colors when using pacman and pacaur)

arch-chroot /mnt pacman -S zsh grml-zsh-config zsh-syntax-highlighting --noconfirm # Install zsh and sane defaults that make zsh much more pleasant to work with
arch-chroot /mnt chsh -s /bin/zsh # Change the root shell to it

# ============= We're done configuring, now install our stuff =============
arch-chroot /mnt pacman -S vim git tree wget httpie unzip diff-so-fancy ntp --noconfirm # Install de-facto software useful in various instances
arch-chroot /mnt pacman -S openvpn openssh --noconfirm # Install openvpn for VPN and openssh for SSH access

# Create a local user account
arch-chroot /mnt useradd -m -g users -G wheel -s /bin/zsh $2

# Testing here. Make sure that the output above is correct.
read -rsp $'Press enter to continue...\n'


# TODO: Install all the things
./install/packages.sh

# TODO: Clean up and final changes for the new system

# Install all the vim plugins
# TODO: Download vim-plug before this so :PlugInstall works

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Make the undo dir so we can undo with the regular vim
mkdir ~/.vim/undo

# TODO: Ensure that this works during the install process
vim +PlugInstall +qall

# This is a placeholder of the structure needed to install crystal-ctags
# TODO: Ensure this works during installation
cd some_directory
git clone https://github.com/SuperPaintman/crystal-ctags
cd crystal-ctags
sudo make install # TODO: Is sudo required here?
cd ../..
rm some_directory

# Move all the dotfiles and other config files to the right place

# =================== Give that account a password so it's possible to login to it with a password ===================
# Follow the same principle of using permission scope here

echo "echo $2:$2 | chpasswd" > $TEMP/chpasswd.sh

arch-chroot /mnt chmod +x $LTEMP/chpasswd.sh
arch-chroot /mnt $LTEMP/chpasswd.sh

# Install ruby gems that you commonly use in development
arch-chroot /mnt gem install jekyll maid

# ======= Clean up and reboot

rm -rfv $TEMP                     # Remove the temp directory

# Delete the NOASSPWD line we added earlier and replace it with a more reasonable one for daily use (password prompt)
head -n -1 /mnt/etc/sudoers > /mnt/etc/sudoers.tmp
mv /mnt/etc/sudoers.tmp /mnt/etc/sudoers
echo "%wheel ALL=(ALL) ALL" >> /mnt/etc/sudoers                 # Give the wheel group permission to use the sudo and su commands

umount /mnt     # Unmount the filesystem
reboot          # Restart the system
