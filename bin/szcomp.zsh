#!/usr/bin/env zsh

DIR_SCRIPT="${0:A:h}"
LIB="$DIR_SCRIPT/../lib"
. $LIB/calc.zsh

zparseopts -F -E -D r:=ref -ref:=ref || return 1

if [[ -z "${ref[2]}" ]]
then
  while [[ "$#" -gt 1 ]]
  do
    szcomp "$1" "$2"
    shift 2 
  done
else
  orig="${ref[2]}"

  while [[ "$#" -gt 1 ]]
  do
    szcomp "$1" "$orig"
    shift 1 
  done
fi

