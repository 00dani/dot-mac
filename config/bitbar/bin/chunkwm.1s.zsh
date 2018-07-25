#!/bin/zsh

# <bitbar.title>chunkwm mode</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Danielle McLean</bitbar.author>
# <bitbar.author.github>00dani</bitbar.author.github>
# <bitbar.desc>Display current desktop ID and layout from chunkwm.</bitbar.desc>
# <bitbar.dependencies>brew,chunkwm</bitbar.dependencies>

# For info about chunkwm, see: https://github.com/koekeishiya/chunkwm

chunkc=/usr/local/bin/chunkc

modes=(
  bsp 🌳
  monocle 🔍
  float ⛵
)
typeset -A icons
icons=($modes)

id=$($chunkc tiling::query --desktop id)
mode=$($chunkc tiling::query --desktop mode)
print -l "$icons[$mode] $id" "---"
for m i in $modes; do
  if [[ $mode = $m ]]; then
    print $i $m
  else
    print "$i $m | terminal=false bash=$chunkc param1=tiling::desktop param2=--layout param3=$m"
  fi
done
