#!/bin/bash

wget http://archlinuxarm.org/os/ArchLinuxARM-arietta-latest.tar.gz || exit

echo '[nanopi] Unpacking'
mkdir arietta
bsdtar -xpf ArchLinuxARM-arietta-latest.tar.gz -C arietta

echo '[nanopi] Preparing QEMU'
cp /usr/bin/qemu-arm-static arietta/usr/bin

echo '[nanopi] arietta directory prepared'
