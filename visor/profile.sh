#!/bin/bash

LANZADOR='if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ] ; then exec start-hyprland ; fi'

if ! grep -F "$LINE" $HOME/.profile ; then

	echo "" >> $HOME/.profile

	echo "$LANZADOR" >> $HOME/.profile

fi
