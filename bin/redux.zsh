#!/usr/bin/env zsh

DIR_SCRIPT="${0:A:h}"
LIB="$DIR_SCRIPT/../lib"
. $LIB/calc.zsh

ayuda() {
  less -FEXR <<- HELP
  uso: ${ZSH_ARGZERO:t} [--crf compresion] [--simple] [--log] [--preset PRESET] in_file out_file
HELP
	exit "$1"
}

zparseopts -F -E -D  h=_ayuda -help=_ayuda -simple=simple -log=log -crf:=crf c:=carpeta -carpeta:=carpeta -preset:=preset || ayuda 1

[[ -n "${_ayuda:+1}" ]] && ayuda 0

#Comprimir Video
local CARPETA_DEFAULT=.
local CRF_DEFAULT=28
local PRESET_DEFAULT=fast

[[ -z "$1" ]] && error "Debe pasarse al menos un argumento."

local in="$1"
local CARPETA="${carpeta[2]:-$CARPETA_DEFAULT}"
local CRF="${crf[2]:-$CRF_DEFAULT}"
local PRESET="${preset[2]:-$PRESET_DEFAULT}"

local out="$2"

if [[ -z "$out" ]]
then
  if [[ -n $simple ]]
  then
    out="${in:r}_SIMPLE.${in:e}"
  else
    out="${in:r}_CRF${CRF}_PRESET_${PRESET}.${in:e}"
  fi
fi

out="$CARPETA/$out"

local REPORT=

if [[ -n $log ]]
then
  export FFREPORT="file=${in:r}.log:level=32"
  REPORT="-report"
fi

if [[ -n $simple ]]
then
  time ffmpeg -hide_banner $REPORT -y -i "$in" "$out"
else
  time ffmpeg -hide_banner $REPORT -y -i "$in" -c:v libx265 -preset "$PRESET" -crf "$CRF" -c:a aac "$out"
fi
unset FFREPORT

szcomp "$out" "$in"
