#!/bin/bash

echo '[nanopi] Hello from inside'
# hostnamectl set-hostname nanopi
# hostnamectl set-hassis embedded

echo '[nanopi] Installing additional packages'
echo -e "n\n" | pacman -U /opt/custompkg/*.pkg.tar.xz --force --noconfirm --needed --logfile /dev/null

echo '[nanopi] Removing systemd-sysvcompat'
pacman -R systemd-sysvcompat --noconfirm --logfile /dev/null

echo '[nanopi] Clearing pacman cache'
echo -e "y\ny\n" | pacman -Scc --logfile /dev/null

echo '[nanopi] Updating configuration files'
[ -f /etc/dhcpd.conf.pacnew ] && {
    mv /etc/dhcpd.conf /etc/dhcpd.conf.bak
    mv /etc/dhcpd.conf.pacnew /etc/dhcpd.conf
}
[ -f /etc/fstab.pacnew ] && mv /etc/fstab.pacnew /etc/fstab

echo '[nanopi] Setting default systemd target'
ln -sf multi-user.target /usr/lib/systemd/system/default.target

echo '[nanopi] Building man database'
mandb -q

echo '[nanopi] Bye from inside'
