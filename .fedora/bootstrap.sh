#!/bin/sh

# End the script on any errors
set -e

# Change the working directory to this one
cd "$(dirname "$0")"

# Install dependencies
sudo dnf install -y make fedpkg

# Run make
make
