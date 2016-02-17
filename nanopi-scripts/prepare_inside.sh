#!/bin/bash

pacman -U /root/custompkg/linux-armv5-nanopi-*-arm.pkg.tar.xz /root/custompkg/nanopi-config-*-arm.pkg.tar.xz /root/custompkg/nanopi-nanoboot-*-arm.pkg.tar.xz --force --noconfirm --needed

echo '[nanopi] Updating fstab'
mv /etc/fstab.pacnew /etc/fstab

echo '[nanopi] Rebuilding man database'
mandb -q

echo '[nanopi] Bye from inside'
