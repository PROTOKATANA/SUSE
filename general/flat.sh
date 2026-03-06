#!/usr/bin/bash

set -euo pipefail

if [ "$EUID" -eq 0 ] ; then echo "EJECUTAR SCRIPT COMO USUARIO NOROOT" ; exit 1 ; fi

for iter in "$@" ; do

	if [ "$iter" == "--install"] ; then

		flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

		sudo flatpak install -y flathub com.google.Chrome

	fi

	if [ "$iter" == "--override"] ; then

		sudo flatpak override --system --nosocket=cups com.google.Chrome

		sudo flatpak override --system --nodevice=all --device=dri com.google.Chrome

		sudo flatpak override --system --nofilesystem=home --nofilesystem=host --nofilesystem=xdg-documents --nofilesystem=xdg-pictures --nofilesystem=xdg-videos --nofilesystem=xdg-music com.google.Chrome

	fi

done
