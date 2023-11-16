#!/bin/zsh
uriencode() {
  jq -nr --arg input $1 '$input | @uri'
}

HOOK="$(osascript -l JavaScript hooked.js)"
CLIPPING="$POPCLIP_MARKDOWN"
[[ -n $HOOK ]] && CLIPPING+=$'\n'"$HOOK #clipped"
exec open "obsidian://advanced-uri?vault=$(uriencode $POPCLIP_OPTION_VAULT)&daily=true&mode=append&data=$(uriencode $CLIPPING)"
