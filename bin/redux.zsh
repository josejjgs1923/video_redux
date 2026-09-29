#!/usr/bin/env zsh

DIR_SCRIPT="${0:A:h}"
LIB="$DIR_SCRIPT/../lib"
. $LIB/calc.zsh
. $LIB/util.sh
. $LIB/funciones_error.sh

zparseopts -F -E -D  h=_ayuda -help=_ayuda -simple=simple -log=log -crf:=crf c:=carpeta -carpeta:=carpeta -preset:=preset e:=extension -extension:=extension r:=resol -resolucion:=resol -1080=resol1080 || ayuda 1

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

local EXTENSION_IN="${in:e}"
local EXTENSION="${extension[2]:-$EXTENSION_IN}"
local out="$2"

if [[ -z "$out" ]]
then
  if [[ -n $simple ]]
  then
    out="${in:r}_SIMPLE"
  else
    out="${in:r}_CRF${CRF}_PRESET_${PRESET}"
  fi

  out="$out.${EXTENSION}"
fi

out="$CARPETA/$out"

local REPORT=

if [[ -n $log ]]
then
  export FFREPORT="file=${in:r}.log:level=32"
  REPORT="-report"
fi

args_out=()

if [[ ! -n $simple ]]
then
  args_out=( -c:v libx265 -preset "$PRESET" -crf "$CRF" -c:a aac )
fi


if [[ -n ${resol[1]} || -n ${resol1080} ]]
then
  if [[ -n ${resol1080} ]]
    arg_resol="1920:1080"
  then
  else
    arg_resol="${resol[2]}"
  fi

  args_out+=( -vf "scale=$arg_resol" )
fi

time ffmpeg -hide_banner $REPORT -y -i "$in" "${args_out[@]}" "$out"
unset FFREPORT

szcomp "$out" "$in"
