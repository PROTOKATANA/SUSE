#!/usr/bin/bash

if [ "$EUID" -eq 0 ] ; then echo "EJECUTAR SCRIPT COMO USUARIO NOROOT" ; exit 1 ; fi

systemctl --user start pipewire

systemctl --user enable pipewire

systemctl --user start pipewire-pulse

systemctl --user enable pipewire-pulse
