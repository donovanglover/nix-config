#!/bin/sh

# End the script on any errors
set -e

# Change the working directory to this one
cd "$(dirname "$0")"

# Get administrative privileges
sudo -v

# Keep pinging sudo until this script finishes
# Source: https://gist.github.com/cowboy/3118588
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install dependencies
sudo -n dnf install -y make fedpkg

# Run make
make

# Revoke privileges
sudo -K
