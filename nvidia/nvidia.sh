#!/usr/bin/bash

if [ "$EUID" -ne 0 ] ; then echo "EJECUTAR SCRIPT COMO USUARIO ROOT" exit 1 ; fi

USUARIO="katana"

nvidia=(

	nvidia-video-G06

	nvidia-compute-utils-G06

	kernel-firmware-nvidia

	kernel-default-devel

	nvidia-gfxG06-kmp-default

	nvidia-gl-G06

	nvidia-compute-G06

)

zypper remove -y Mesa-dri-nouveau

zypper al Mesa-dri-nouveau

echo "blacklist nouveau" > /etc/modprobe.d/50-blacklist.conf

usermod -a -G render,video $USUARIO

zypper install -y openSUSE-repos-Slowroll-NVIDIA

zypper refresh

zypper update -y --auto-agree-with-licenses

zypper remove -y nvidia-open-driver-G06-signed-kmp-default

instalacion() {

	if zypper search -i "$1" &>> /dev/null ; then echo -e "existente : [$1]"

    else zypper install --auto-agree-with-licenses -y "$1" 2>&1 ; fi

}

for iter in "${nvidia[@]}" ; do instalacion "$iter" ; done
