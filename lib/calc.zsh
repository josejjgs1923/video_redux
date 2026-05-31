#!/usr/bin/env zsh

szcomp(){
  du -s -b "$1" "$2" | numfmt --to si --suffix B

  compresion="$( printf "redux (%s; %s) to %%" $( du -s -b "$1" "$2" | cut -f1 ) )"

  printf "compresion "
  qalc --terse --set "maxdeci 2" --color "$compresion"
}

