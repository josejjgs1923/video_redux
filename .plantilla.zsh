#!/usr/bin/env zsh

DIR_SCRIPT="${0:A:h}"
MODULOS="$DIR_SCRIPT/modulos"
. $MODULOS/funciones_error.sh

ayuda() {
  less -FEXR <<- HELP
  uso: ${ZSH_ARGZERO:t}
HELP
	exit "$1"
}

zparseopts -F -E -D h=_ayuda -help=_ayuda || ayuda 1

[[ -n "${_ayuda:+1}" ]] && ayuda 0
