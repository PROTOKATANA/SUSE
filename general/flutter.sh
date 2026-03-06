#!/usr/bin/bash

set -euo pipefail

if [ "$EUID" -eq 0 ] ; then echo "EJECUTAR SCRIPT COMO USUARIO NOROOT" ; exit 1 ; fi

carpeta='torio'

dependencias=(

	clang

	cmake

	ninja

	pkg-config

	gtk3-devel

	gcc-c++

	libstdc++-devel

	vulkan-validationlayers

	vulkan-tools

	libvulkan1

)

instalacion() {

	if zypper search -i "$1" &>> /dev/null ; then echo -e "existente : [$1]"

	else sudo zypper install --auto-agree-with-licenses -y "$1" 2>&1 ; fi

}

for iter in "$@" ; do

	if [ "$iter" == "--tool" ] ; then

		zypper refresh

		zypper update -y

		for iter in "${dependencias[@]}" ; do instalacion "$iter" ; done

	fi

	if [ "$iter" == "--tar" ] ; then

		mkdir -p "$HOME/$carpeta"

		cd "$HOME/$carpeta" || exit

		wget -O "$HOME/$carpeta/flutter.tar.xz" "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.27.1-stable.tar.xz"

		tar -xf flutter.tar.xz

		rm flutter.tar.xz

	fi

	if [ "$iter" == "--entorno" ] ; then

		if ! grep -F "export PATH=\"\$HOME/$carpeta/flutter/bin:\$PATH\"" $HOME/.bashrc ; then

			echo "" >> $HOME/.bashrc

			echo "export PATH=\"\$HOME/$carpeta/flutter/bin:\$PATH\"" >> $HOME/.bashrc

			echo "" >> $HOME/.bashrc

			echo "export GDK_BACKEND=wayland" >> "$HOME/.bashrc"

		fi

	fi

done
