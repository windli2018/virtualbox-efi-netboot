#!/bin/bash

function install_pkg () {
	[ -x "$1" ] && return 0
	if [ -x /usr/bin/apt ] ; then
		apt install "$2" -y
	elif [ -x /usr/bin/yum ] ; then
		yum install "$2" -y
	else
		echo please install "$2" before running this script
		exit 1
	fi
	[ -x "$1" ] && return 0
	echo "$1" is not execcutable
	exit 1
}

install_pkg git git
install_pkg make make
install_pkg mkisofs genisoimage

git clone git://git.ipxe.org/ipxe.git
cd ipxe/src/
make -j4 bin-x86_64-efi/ipxe.efi
make -j4 bin-x86_64-efi/ipxe.usb
mkdir iso
cp -avf bin-x86_64-efi/ipxe.usb iso
mkisofs -e ipxe.usb -o ipxe.efi.iso iso/
