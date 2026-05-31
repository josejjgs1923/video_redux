#!/usr/bin/env zsh

szcomp(){
  stat --format "%s %n" "$1" "$2" | numfmt -d " " --to si --suffix B

  compresion="$( printf "redux (%s; %s) to %%" $( stat --format "%s" "$1" "$2" ) )"

  printf "compresion "
  qalc --terse --set "maxdeci 2" --color "$compresion"
}

