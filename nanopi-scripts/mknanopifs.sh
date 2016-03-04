#!/bin/bash

CURRENT_DIR=$(pwd)

echo '[nanopi] Removing nanopi directory'
[ -d nanopi ] && rm -rf nanopi

echo '[nanopi] Creating rootfs directory'
mkdir -p "$CURRENT_DIR/nanopi/usr/bin"

echo "[nanopi] Making filesystem on $CURRENT_DIR/nanopi"
systemd-nspawn -q -M nanopi.build --bind-ro /usr/bin/qemu-arm-static --bind $CURRENT_DIR/nanopi:/opt/nanopi --bind-ro /usr/bin/qemu-arm-static:/opt/nanopi/usr/bin/qemu-arm-static  -a -D $CURRENT_DIR/arietta /usr/bin/pacstrap -d -G -M /opt/nanopi base nano dialog
[ -d nanopi/root ] || {
    echo 'Invalid root filesystem'
    exit 1
}

echo '[nanopi] Updating packages inside NanoPi root filesystem'
mv nanopi/etc/resolv.conf nanopi/etc/resolv.conf.bak
systemd-nspawn -q -M nanopi --bind-ro /usr/bin/qemu-arm-static --bind-ro $CURRENT_DIR/custompkg:/opt/custompkg --bind-ro $CURRENT_DIR/prepare_inside.sh:/opt/prepare_inside.sh -a -D $CURRENT_DIR/nanopi /opt/prepare_inside.sh

echo '[nanopi] Symlinking /run/systemd/resolve/resolv.conf'
ln -sf /run/systemd/resolve/resolv.conf nanopi/etc/resolv.conf

echo '[nanopi] Cleaning NanoPi filesystem'
rm nanopi/var/log/*.log

echo '[nanopi] Compressing NanoPi filesystem'
bsdtar -cJf ArchLinuxARM-NanoPi-latest.tar.xz --option xz:compression-level=6 -C nanopi .
ls -l ArchLinuxARM*.tar.xz

echo '[nanopi] Done'
