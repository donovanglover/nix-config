#!/bin/sh

set -e

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

env DISTSIZE="$DISTSIZE" ./001-preinstall
env HOSTNAME="$HOSTNAME" ./003-configure
env USERNAME="$USERNAME" ./004-postinstall
