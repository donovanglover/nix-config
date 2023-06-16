#!/usr/bin/env bash

music_dir="$HOME/Music"
fallback_image="$HOME/a.jpg"

main () {
    find_cover 2>/dev/null
    send       2>/dev/null
}

find_cover () {
    ext="$(mpc --format %file% current | sed 's/^.*\.//')"
    if [ "$ext" != "flac" ]; then
        ffmpeg -y -i "$(mpc --format "$music_dir"/%file% | head -n 1)" \
        /tmp/cover.jpg && cover_path="/tmp/cover.jpg" && return
    else
        # ffmpeg doesn't work for flacs
        metaflac --export-picture-to=/tmp/cover.jpg \
        "$(mpc --format "$music_dir"/%file% current)" && cover_path="/tmp/cover.jpg" && return
    fi
    #without embedded images this is used as a fallback
    file="$music_dir/$(mpc --format %file% current)"
    album="${file%/*}"
    #search for cover image
    cover_path=$(find "$album"  -maxdepth 1 | grep -m 1 ".*\.\(jpg\|png\|gif\|bmp\)")
}

send () {
    notify-send -i "${cover_path:-$fallback_image}" "Now Playing" "$(mpc current)"
}

main
