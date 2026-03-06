#!/usr/bin/env bash

set -euo pipefail

if [ "$EUID" -ne 0 ] ; then echo "EJECUTAR SCRIPT COMO USUARIO ROOT" ; exit 1 ; fi

DIR=$(dirname "$(realpath "$0")")

for iter in "$@" ; do

	if [ "$iter" == "--red" ] ; then

		INTERFACE=$(ip route | grep default | awk '{print $5}' | head -n1)

		if [ -z "$INTERFACE" ] ; then echo "NO SE ENCONTRO INTERFAZ DE RED" ; exit 1 ; fi

		zypper install -y systemd-networkd systemd-resolved

		mkdir -p /etc/systemd/network

		FILENET="/etc/systemd/network/10-main.network"

		sed "s/__INTERFACE__/$INTERFACE/g" "$DIR/10-main.network" > $FILENET

		if systemctl list-unit-files | grep -q NetworkManager ; then

			systemctl stop NetworkManager || true

			systemctl disable NetworkManager || true

		fi

		systemctl enable --now systemd-networkd

		systemctl enable --now systemd-resolved

		ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

		systemctl restart systemd-networkd

		networkctl status

	fi

	if [ "$iter" == "--override" ] ; then

		mkdir -p /etc/systemd/system/systemd-resolved.service.d/

		cp "$DIR/override.conf" /etc/systemd/system/systemd-resolved.service.d/override.conf

		systemctl daemon-reload

		systemctl restart systemd-resolved

	fi

done
