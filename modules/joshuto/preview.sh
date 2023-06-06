#!/usr/bin/env bash

IFS=$'\n'
set -o noclobber -o noglob -o nounset -o pipefail

FILE_PATH=""
PREVIEW_WIDTH=10
PREVIEW_HEIGHT=10

while [ "$#" -gt 0 ]; do
	case "$1" in
		"--path")
			shift
			FILE_PATH="$1"
			;;
		"--preview-width")
			shift
			PREVIEW_WIDTH="$1"
			;;
		"--preview-height")
			shift
			PREVIEW_HEIGHT="$1"
			;;
	esac
	shift
done

realpath=$(realpath "$FILE_PATH")

handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in
        lock)
            cat "${FILE_PATH}" && exit 0
            exit 1;;

        rar)
            unrar lt -p- -- "${FILE_PATH}" && exit 0
            exit 1;;
        7z)
            7z l -p -- "${FILE_PATH}" && exit 0
            exit 1;;

        pdf)
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | \
                fmt -w "${PREVIEW_WIDTH}" && exit 0
            mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | \
                fmt -w "${PREVIEW_WIDTH}" && exit 0
            exiftool "${FILE_PATH}" && exit 0
            exit 1;;

        torrent)
            transmission-show -- "${FILE_PATH}" && exit 0
            exit 1;;

        json)
            jq --color-output . "${FILE_PATH}" && exit 0
            ;;
    esac
}

handle_mime() {
	local mimetype="${1}"

	case "${mimetype}" in
        ## Text
        text/* | */xml)
            bat --color=always --paging=never \
		--style=plain \
		--terminal-width="${PREVIEW_WIDTH}" \
		 "${FILE_PATH}" && exit 0
            cat "${FILE_PATH}" && exit 0
            exit 1;;

        ## Image
        image/*)
            exit 5;;

        ## Video and audio
        video/* | audio/*)
            echo "$realpath"
            mediainfo "${FILE_PATH}" && exit 0
            exiftool "${FILE_PATH}" && exit 0
            exit 1;;
    esac
}

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"
handle_extension
MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"
handle_mime "${MIMETYPE}"

exit 1
