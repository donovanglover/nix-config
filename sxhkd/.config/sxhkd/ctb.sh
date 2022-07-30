#!/bin/sh
# Clipboard to browser

CLIPBOARD="$(xclip -o)"
OPEN="/usr/bin/$BROWSER"
URL=""

if [[ "$1" == "jisho" ]]; then
  URL="https://jisho.org/search/$CLIPBOARD"

elif [[ "$1" == "weblio" ]]; then
  URL="https://ejje.weblio.jp/content/$CLIPBOARD"

elif [[ "$1" == "forvo" ]]; then
  # URL="https://forvo.com/search/$CLIPBOARD"
  URL="https://forvo.com/word/$CLIPBOARD/#ja"

elif [[ "$1" == "deepl" ]]; then
  URL="https://www.deepl.com/translator#ja/en/$CLIPBOARD"

elif [[ "$1" == "cambridge" ]]; then
  URL="https://dictionary.cambridge.org/dictionary/english/$CLIPBOARD"
fi

if [[ "$URL" != "" ]]; then
  "$OPEN" "$URL"
fi
