#!/usr/bin/bash

set -euo pipefail

if [ "$EUID" -eq 0 ] ; then echo "EJECUTAR SCRIPT COMO USUARIO NOROOT" ; exit 1 ; fi

carpeta='torio'

path="export PATH=\"\$HOME/$carpeta/flat:\$PATH\""

cd "$HOME/$carpeta" || exit

curl -LO "https://flatassembler.net/fasm2.zip"

mkdir -p flat

unzip -o fasm2.zip -d flat

chmod +x flat/fasm2 flat/fasmg.x64

shred -uvz fasm2.zip

if ! grep -Fq "$path" $HOME/.bashrc ; then

	echo "" >> $HOME/.bashrc

	echo "$path" >> $HOME/.bashrc

fi
