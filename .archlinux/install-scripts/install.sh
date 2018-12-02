#!/bin/sh
# Simple Arch Linux install scripts, tailored to my use case.

# End the script on any errors
set -e

# Change the working directory to this one
cd "$(dirname "$0")"

# Prompt for the required information

echo -n "Enter the size (in GiB) to give the primary partition: "
read DISTSIZE

echo -n "Enter a hostname for this machine: "
read HOSTNAME

echo -n "Enter a username for the local account with sudo rights: "
read USERNAME

echo "-----------------------------------------------------"
echo "Arch Linux will be installed with the settings above."
echo "NOTE: You should not run this script if you do not"
echo "      understand what it does. Bad things may happen."
echo -n "Type YES to continue, or Ctrl+C to abort. "
read CONFIRM

if [ "$CONFIRM" != "YES" ]; then
  echo "YES was not given, exiting..."
  exit
fi

echo "====================================================="
echo "Running install scripts..."

# Run the install scripts
env DISTSIZE="$DISTSIZE" ./001-preinstall
                         ./002-install
env HOSTNAME="$HOSTNAME" ./003-configure
env USERNAME="$USERNAME" ./004-postinstall

echo "Enter a password for the root user..."
arch-chroot /mnt passwd

echo "Enter a password for $USERNAME..."
arch-chroot /mnt passwd "$USERNAME"

echo "====================================================="
echo "Done. Now reboot into Arch Linux!"
