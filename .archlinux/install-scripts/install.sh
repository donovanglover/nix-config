#!/bin/sh

set -e

echo -n "Enter the size (in GiB) to give the primary partition: "
read DISTSIZE

echo -n "Enter a hostname for this machine: "
read HOSTNAME

echo -n "Enter a username for the local account with sudo rights: "
read USERNAME

env DISTSIZE="$DISTSIZE" ./001-preinstall
env HOSTNAME="$HOSTNAME" ./003-configure
env USERNAME="$USERNAME" ./004-postinstall
