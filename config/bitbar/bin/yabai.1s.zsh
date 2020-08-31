#!/bin/zsh

# <bitbar.title>yabai mode</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Danielle McLean</bitbar.author>
# <bitbar.author.github>00dani</bitbar.author.github>
# <bitbar.desc>Display current desktop ID and layout from yabai.</bitbar.desc>
# <bitbar.dependencies>brew,yabai</bitbar.dependencies>

# For info about yabai, see: https://github.com/koekeishiya/yabai

path=(/usr/local/bin $path)
yabai==yabai

modes=(
  bsp 🌳
  stack 📚
  float ⛵
)
typeset -A icons
icons=($modes)

yabai -m query --spaces | jq -r 'map(select(.focused == 1))[-1] | (.index | tostring) + " " + .type' | read id mode

print -l "$icons[$mode] $id" "---"
for m i in $modes; do
  if [[ $mode = $m ]]; then
    print $i $m
  else
    print "$i $m | terminal=false bash=$yabai param1=-m param2=space param3=--layout param4=$m"
  fi
done
