#!/bin/bash

echo '[nanopi] Hello from inside'
# hostnamectl set-hostname nanopi
# hostnamectl set-hassis embedded

echo '[nanopi] Installing additional packages'
echo -e "n\n" | pacman -U /root/custompkg/*-arm.pkg.tar.xz --force --noconfirm --needed --logfile /dev/null

echo '[nanopi] Removing systemd-sysvcompat'
pacman -R systemd-sysvcompat --noconfirm --logfile /dev/null

echo '[nanopi] Clearing pacman cache'
echo -e "y\ny\n" | pacman -Scc

echo '[nanopi] Updating configuration files'
[ -f /etc/dhcpd.conf.pacnew ] && {
    mv /etc/dhcpd.conf /etc/dhcpd.conf.bak
    mv /etc/dhcpd.conf.pacnew /etc/dhcpd.conf
}
[ -f /etc/fstab.pacnew ] && mv /etc/fstab.pacnew /etc/fstab

echo '[nanopi] Removing /var/log/journal'
[ -d /var/log/journal ] && rm -rf /var/log/journal

echo '[nanopi] Removing /etc/sysctl.d/100-manjaro.conf'
[ -f /etc/sysctl.d/100-manjaro.conf ] && rm /etc/sysctl.d/100-manjaro.conf

echo '[nanopi] Building man database'
mandb -q

echo '[nanopi] Bye from inside'
