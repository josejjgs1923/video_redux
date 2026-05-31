#!/usr/bin/env zsh 

target1=redux
target2=szcomp


BIN="$HOME/.local/bin/"
mkdir -p "$BIN"


ln -sf "$PWD/bin/${target1}.zsh" "$BIN/$target1"
ln -sf "$PWD/bin/${target2}.zsh" "$BIN/$target2"
