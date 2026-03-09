#!/usr/bin/bash

set -euo pipefail

if [ "$EUID" -ne 0 ] ; then echo "EJECUTAR SCRIPT COMO USUARIO ROOT" ; exit 1 ; fi

binarios=(

	rizin

	rizin-devel

	rz-pm

)
