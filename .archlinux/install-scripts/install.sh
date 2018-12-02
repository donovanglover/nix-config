#!/bin/sh

set -e

echo -n "Enter a hostname for this machine: "
read HOSTNAME

echo -n "Enter a username for the local account with sudo rights: "
read USERNAME

env HOSTNAME="$HOSTNAME" ./003-configure
env USERNAME="$USERNAME" ./004-postinstall
