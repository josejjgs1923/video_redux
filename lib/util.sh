#!/usr/bin/env zsh

ayuda() {
  less -FEXR <<- HELP
  uso: ${ZSH_ARGZERO:t} [--carpeta/-c ruta] [--extension/-e str] [--crf compresion] [--simple] [--log] [--preset PRESET] in_file out_file

  Script Wrapper para ffmpeg, utilizado para comprimir videos

  opciones:
     -c/--carpeta ruta   carpeta objetivo para los videos comprimidos
     -e/--extension str  extension de salida, usando por defecto la del archivo
                         de entrada
     --crf               factor de compresion, defecto 28
     --preset PRESET     valor de preset para comando ffmepg, por defecto es 'fast'
     --simple            No usar factor se compresion, usar los valores
                         por defecto de ffmpeg
     --log               crear archivo log para el comando
HELP
	exit "$1"
}
