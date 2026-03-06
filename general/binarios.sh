#!/usr/bin/bash

set -euo pipefail

if [ "$EUID" -ne 0 ] ; then echo "EJECUTAR SCRIPT COMO USUARIO ROOT" ; exit 1 ; fi

binarios=(

	nano

	vim

	netpbm

	samba-client

	cifs-utils

	qt6-base-common-devel

	qt6-declarative-tools

	groff-full

	ghostscript

	libpaper-tools

	screen

	sg3_utils

	smp_utils

	sharutils

	wol

	procmail

	openslp

	ruby4.0

	acpica

	net-snmp

	augeas

	tnftp

	gtk3-tools

	gtk4-tools

	NetworkManager

)

delete() {

	local exe="$1"

	if [ -z "$exe" ]; then return 1 ; fi

	if rpm -q "$exe" &>/dev/null ; then zypper remove --clean-deps -y "$exe" ;

    else echo "EXTINTO : [$exe]" ; fi

}

for iter in "${binarios[@]}" ; do delete "$iter" ; done
