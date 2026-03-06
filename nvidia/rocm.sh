#!/usr/bin/bash

if [ "$EUID" -eq 0 ] ; then echo "EJECUTAR SCRIPT COMO USUARIO NOROOT" ; exit 1 ; fi

hip=(

	hipcc

	rocm-hip

	rocm-hip-devel

	rocm-clang

	rocm-clang-devel

	rocm-llvm

	rocm-llvm-devel

	rocminfo

)

instalacion() {

	if zypper search -i "$1" &>> /dev/null ; then echo -e "existente : [$1]"

    else sudo zypper install --auto-agree-with-licenses -y "$1" 2>&1 ; fi

}

sudo zypper refresh

sudo zypper update -y

for iter in "${hip[@]}" ; do instalacion "$iter" ; done

if ! grep -F "export HIP_PLATFORM=\"nvidia\"" "$HOME/.bashrc" &>> /dev/null ; then

	echo "" >> $HOME/.bashrc

	echo "export HIP_PLATFORM=\"nvidia\"" >> $HOME/.bashrc

fi

if ! grep -F "export HIP_COMPILER=\"nvcc\"" "$HOME/.bashrc" &>> /dev/null ; then

	echo "" >> $HOME/.bashrc

	echo "export HIP_COMPILER=\"nvcc\"" >> $HOME/.bashrc

fi
