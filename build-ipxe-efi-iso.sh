#!/bin/sh
git clone git://git.ipxe.org/ipxe.git
cd ipxe/src/
make -j4 bin-x86_64-efi/ipxe.efi
make -j4 bin-x86_64-efi/ipxe.usb
mkdir iso
cp -avf bin-x86_64-efi/ipxe.usb iso
#apt install genisoimage -y || yum install genisoimage -y
mkisofs -e ipxe.usb -o ipxe.efi.iso iso/
