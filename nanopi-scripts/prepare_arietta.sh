#!/bin/bash

wget http://archlinuxarm.org/os/ArchLinuxARM-arietta-latest.tar.gz || exit

echo '[nanopi] Unpacking'
mkdir arietta
bsdtar -xpf ArchLinuxARM-arietta-latest.tar.gz -C arietta
rm arietta/etc/resolv.conf

echo '[nanopi] Preparing system'
systemd-nspawn -M nanopi.build --bind-ro /usr/bin/qemu-arm-static -D arietta /usr/bin/pacman -Suy arch-install-scripts

echo '[nanopi] arietta directory prepared'
