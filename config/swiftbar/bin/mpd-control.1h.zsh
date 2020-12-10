#!/bin/zsh

path+=(/usr/local/bin)
mpc==mpc
print -n ♫

state=$(mpc status | sed '/^[^\[]/d; s/^\[\(.*\)\].*$/\1/')
i=$(mpc current -f %position%)

if [[ $state == playing ]]; then
  icon=' ▶ '
  menu=("Ⅱ Pause | terminal=false bash=$mpc param1=pause")
else
  icon=' Ⅱ '
  menu=("▶ Play | terminal=false bash=$mpc param1=play")
fi

if [[ -n $state ]]; then
  print -n $icon
  menu=(
    "⏪ Previous | terminal=false bash=$mpc param1=prev"
    $menu
    "⏩ Next | terminal=false bash=$mpc param1=next"
    "⏹ Stop | terminal=false bash=$mpc param1=stop"
  )
else
  i=0
  print
fi
menu=(--- $menu "🔀 Shuffle | terminal=false bash=$mpc param1=shuffle" ---)

format=()
for field in position title artist; format+=($field %$field%)

songs=( ${(f)"$(mpc playlist -f ${(j-::-)format})"} )
typeset -A song
for s in $songs; do
  song=(${(s/::/)s})
  song[menu]="$song[title] - $song[artist] | length=50"
  if (( $song[position] == $i )); then
    print "$song[title] | length=30"
  else
    song[menu]+=" terminal=false bash=$mpc param1=play param2=$song[position]"
  fi
  menu+=($song[menu])
done

print -l -- $menu
