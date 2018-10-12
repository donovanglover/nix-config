#!/bin/sh

# End the script if an error occurs.
set -e

# Change the working directory to a cache directory.
mkdir -p "$HOME/.cache/feh"
cd "$HOME/.cache/feh"

# If $1 is not defined, raise an error.
if [ -z "$1" ]; then
  echo 'error: No color specified.'
  echo 'usage: ./path/to/tile.sh <color> where color is hexadecimal'
  exit 1
fi

# If $1 contains something other than 0-9 and A-F, raise an error.
if [[ -n "${1//[0-9A-F]/}" ]]; then
  echo 'error: Invalid color specified. Colors must use 0-9 and A-F only.'
  echo '       Colors should not use a-f since file names are case sensitive.'
  exit 1
fi

# If $1 is not exactly six characters long, raise an error.
if ! [ "${#1}" -eq 6 ]; then
  echo 'error: Invalid color specified. Colors must be of length 6.'
  echo '       This is for the convert function, and is used to help'
  echo '       prevent duplicate colors.'
  exit 1
fi

# If the color doesn't exist yet, make it.
if ! test -e "$1.png"; then
  echo 'status: Color file does not exist yet. Making it...'
  convert -size 1x1 "xc:#$1" "$1.png"
fi

# Finally, set the specified color as the background.
echo 'status: Setting the desktop background as the specified color...'
feh --no-fehbg --bg-tile "$1.png"

# We're done here.
echo 'status: Successfully changed the background to the color specified!'
