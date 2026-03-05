#!/usr/bin/env bash

set -e

if [ "$EUID" -ne 0 ] ; then echo "EJECUTAR SCRIPT COMO USUARIO ROOT" ; exit 1 ; fi

INTERFACE=$(ip route | grep default | awk '{print $5}' | head -n1)

if [ -z "$INTERFACE" ] ; then echo "NO SE ENCONTRO INTERFAZ DE RED" ; exit 1 ; fi

zypper install -y systemd-networkd systemd-resolved

mkdir -p /etc/systemd/network

FILENET="/etc/systemd/network/10-main.network"

TORNILLO="[Match]

Name=$INTERFACE

[Network]

DHCP=ipv4

IPv6AcceptRA=no

LinkLocalAddressing=no"

echo "$TORNILLO" > "$FILENET"

if systemctl list-unit-files | grep -q NetworkManager ; then

	systemctl stop NetworkManager || true

	systemctl disable NetworkManager || true

fi

systemctl enable --now systemd-networkd

systemctl enable --now systemd-resolved

ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

systemctl restart systemd-networkd

networkctl status
