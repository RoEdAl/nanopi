#!/bin/bash
echo '[nanopi] Removing nanopi directory'
[ -d nanopi ] && rm -rf nanopi

echo '[nanopi] Preparing directory'
mkdir -p nanopi/usr/bin
cp /usr/bin/qemu-arm-static nanopi/usr/bin

echo '[nanopi] Making filesystem'
pacstrap -C pacman-nanopi.conf -d -G -M nanopi base nano dialog
[ -d nanopi/root ] || {
    echo 'Invalid root filesystem'
    exit 1
}

echo '[nanopi] Updating packages inside NanoPi root filesystem'
mkdir nanopi/root/custompkg
cp prepare_inside.sh nanopi/root/custompkg
cp custompkg/*.pkg.tar.xz nanopi/root/custompkg
arch-chroot nanopi bash /root/custompkg/prepare_inside.sh

echo '[nanopi] Cleaning NanoPi filesystem'
rm -rf nanopi/root/cusotmfs
rm nanopi/usr/bin/qemu-arm-static

echo '[nanopi] Conmpressing NanoPi filesystem'
bsdtar -cJf ArchLinuxARM-NanoPi-latest.tar.xz --option xz:compression-level=6 -C nanopi .
ls -l *.tar.xz

echo '[nanopi] Done'

