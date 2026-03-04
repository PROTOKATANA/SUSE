#!/usr/bin/bash

if [ "$EUID" -eq 0 ] ; then echo "EJECUTAR SCRIPT COMO USUARIO NOROOT" ; exit 1 ; fi

SSH="ssh-add \$HOME/.ssh/proto"

AGENTE='if [ -z "$SSH_AGENT_PID" ] ; then eval "$(ssh-agent -s)" && ssh-add "$HOME/.ssh/proto" ; fi'

for iter in "$@" ; do

	if [ "$iter" == "--generador" ] ; then

		ssh-keygen -t rsa -b 4096 -C "PROTOKATANA@proton.me" -f $HOME/.ssh/proto

		if ! grep -F "$SSH" $HOME/.profile ; then

			echo "" >> $HOME/.profile

			echo "$SSH" >> $HOME/.profile

		fi

	fi

	if [ "$iter" == "--ssh" ] ; then

		if ! grep -F "$AGENTE" $HOME/.profile ; then

			echo "" >> $HOME/.profile

			echo "$AGENTE" >> $HOME/.profile

		fi

	fi

	if [ "$iter" == "--cuenta" ] ; then

		git config --global user.name "PROTOKATANA"

		git config --global user.email "PROTOKATANA@proton.me"

	fi

done
