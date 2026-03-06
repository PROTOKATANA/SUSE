#!/usr/bin/bash

set -euo pipefail

if [ "$EUID" -eq 0 ] ; then echo "EJECUTAR SCRIPT COMO USUARIO NOROOT" exit 1 ; fi

dependencias=(

	protobuf-devel

	protobuf-devel

	rustup

)

zypper refresh

instalacion() {

	if zypper search -i "$1" &>> /dev/null ; then echo -e "existente : [$1]"

	else sudo zypper install --auto-agree-with-licenses -y "$1" 2>&1 ; fi

}

for iter in "${dependencias[@]}" ; do instalacion "$iter" ; done

rustup default stable

if ! grep -F "export PATH=\"\$HOME/.cargo/bin:\$PATH\"" $HOME/.bashrc ; then

	echo "" >> $HOME/.bashrc

	echo "export PATH=\"\$HOME/.cargo/bin:\$PATH\"" >> $HOME/.bashrc

fi

cargo install rinf_cli
