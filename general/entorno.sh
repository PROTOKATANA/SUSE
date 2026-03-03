#!/usr/bin/bash

if [ "$EUID" -ne 0 ] ; then echo "EJECUTAR SCRIPT COMO USUARIO ROOT" ; exit 1 ; fi

dependencias=(

	dkms

	cmake

	ninja

	pkg-config

	clang

	gcc

	gcc-c++

	gtk3-devel

)

wayland=(

	wayland-utils

	wlroots-devel

	wayland-protocols-devel

	hyprland

	hyprland-devel

	hyprpaper

	hyprcursor

	hyprlock

	hypridle

	hyprland-qtutils

)

general=(

	git

	flatpak

	password-store

	alacritty

	neovim

	xwayland

)

zypper refresh

zypper update -y

instalacion() {

	if zypper search -i "$1" &>> /dev/null ; then echo -e "existente : [$1]"

	else zypper install --auto-agree-with-licenses -y "$1" 2>&1 ; fi

}

for iter in "${dependencias[@]}" ; do instalacion "$iter" ; done

for iter in "${wayland[@]}" ; do instalacion "$iter" ; done

for iter in "${general[@]}" ; do instalacion "$iter" ; done
