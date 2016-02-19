#!/bin/bash

echo -e "n\n" | pacman -U /root/custompkg/*-arm.pkg.tar.xz --force --noconfirm --needed

echo '[nanopi] Clearing pacman cache'
echo -e "y\ny\n" | pacman -Scc

echo '[nanopi] Updating configuration files'
[ -f /etc/dhcpd.conf.pacnew ] && {
    mv /etc/dhcpd.conf /etc/dhcpd.conf.bak
    mv /etc/dhcpd.conf.pacnew /etc/dhcpd.conf
}
[ -f /etc/fstab.pacnew ] && mv /etc/fstab.pacnew /etc/fstab
[ -f /etc/systemd/journald.conf.pacnew ] && mv /etc/systemd/journald.conf.pacnew /etc/systemd/journald.conf

echo '[nanopi] Building man database'
mandb -q

echo '[nanopi] Bye from inside'
