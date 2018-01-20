# This is my personal install guide. It's what I use to install Arch.

$USERNAME = "hello"
$HOSTNAME = "world"

############ Part 0: Ensure you have the correct time

timedatectl set-ntp true

############ Part 1: Make the disk partitions

# Make a DOS partition table
parted /dev/sda mklabel msdos
# Create the primary partition
parted /dev/sda mkpart primary ext4 1MiB 14GiB
# Enable boot for the primary partition
parted /dev/sda set 1 boot on
# Create the swap partition
parted /dev/sda mkpart primary linux-swap 14GiB 100%

############ Part 2: Make the filesystem

# Make the filesystem ext4
mkfs -t ext4 /dev/sda1
# Mount the new filesystem
mount /dev/sda1 /mnt
# Make the swap file on the swap partition
mkswap /dev/sda2
# Enable it
swapon /dev/sda2

############ Part 3: Install the base system

# Install the base packages to the newly created filesystem
pacstrap /mnt base base-devel

# Mount the filesystem automatically on boot
genfstab -U /mnt > /mnt/etc/fstab

############ Part 4: Configure the new system

# Set the hostname in all the necessary places
echo "$HOSTNAME" > /mnt/etc/hostname
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /mnt/etc/hosts

# Set the language to English and use the en_US.UTF-8 locale
echo "LANG=en_US.UTF-8"  > /mnt/etc/locale.conf
echo "en_US.UTF-8 UTF-8" > /mnt/etc/locale.gen

# Explicitly set the keymap to US
echo "KEYMAP=us" > /mnt/etc/vconsole.conf

# Change the wait time from 90s to 10s, preventing the system from hanging at shutdown
SYSTEMD="/mnt/etc/systemd/system.conf"
echo "DefaultTimeoutStartSec=10s" >> $SYSTEMD
echo "DefaultTimeoutStopSec=10s"  >> $SYSTEMD

# Enable colors in pacman by uncommenting the Color line
PACMAN="/mnt/etc/pacman.conf"
sed -i '/Color/s/^#//g' $PACMAN

# Give the wheel group permission to use the sudo and su commands
echo "%wheel ALL=(ALL) ALL" >> /mnt/etc/sudoers

# Make the grub window bigger
sed -i '/GRUB_GFXMODE/c\GRUB_GFXMODE=1280x1024' /mnt/etc/default/grub

# (Important!) Font settings ============
FONTS="/etc/fonts"
# Disable embedded bitmaps for all fonts
ln -s $FONTS/conf.avail/70-no-bitmaps.conf $FONTS/conf.d
# Enable sub-pixel RGB rendering
ln -s $FONTS/conf.avail/10-sub-pixel-rgb.conf $FONTS/conf.d
# Enable the LCD filter (reduces color fringing)
ln -s $FONTS/conf.avail/11-lcdfilter-default.conf $FONTS/conf.d

############ Part 5: Run some final commands inside the system

# Generate the locale
arch-chroot /mnt locale-gen

# Install grub to the primary partition
arch-chroot /mnt grub-install /dev/sda

# Make the configuration file for grub
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# Save the hardware information
arch-chroot /mnt mkinitcpio -p linux

# Change the shell of root to fish
arch-chroot /mnt chsh -s /bin/fish

# Create a new user account
arch-chroot /mnt useradd -m -g users -G wheel -s /usr/bin/fish $USERNAME

# Add a password to the newly created user account
echo "echo $USERNAME:$USERNAME | chpasswd" > /mnt/root/chpasswd.sh
chmod +x /mnt/root/chpasswd.sh
arch-chroot /mnt /root/chpasswd.sh

############ Part 6: Clean up and reboot

# Unmount the filesystem
umount /mnt

# Reboot the system
reboot
