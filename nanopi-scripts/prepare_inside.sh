#!/bin/bash

pacman -U /root/custompkg/linux-armv5-nanopi-*-arm.pkg.tar.xz /root/custompkg/nanopi-config-*-arm.pkg.tar.xz /root/custompkg/nanopi-nanoboot-*-arm.pkg.tar.xz --force --noconfirm --needed

echo '[nanopi] Clearing pacgage cache'
echo -e "y\ny\n" | pacman -Scc

echo '[nanopi] Updating configuration files'
[ -f /etc/dhcpd.conf.pacnew ] && mv /etc/dhcpd.conf.pacnew /etc/dhcpd.conf
[ -f /etc/fstab.pacnew ] && mv /etc/fstab.pacnew /etc/fstab
[ -f /etc/dhcpd.conf.pacnew ] && mv /etc/dhcpd.conf.pacnew /etc/dhcpd.conf

echo '[nanopi] Rebuilding man database'
mandb -q

echo '[nanopi] Bye from inside'
