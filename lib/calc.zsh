#!/usr/bin/env zsh

szcomp(){
  stat --format "%s %n" "$1" "$2" | numfmt -d " " --to si --suffix B

  printf "compresion "

  printf "redux (%s; %s) to %%" $( stat --format "%s" "$1" "$2" ) | qalc --terse --set "maxdeci 2" --color
}

