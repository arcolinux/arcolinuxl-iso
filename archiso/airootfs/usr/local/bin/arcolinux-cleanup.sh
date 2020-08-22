#!/bin/bash
rm -f /etc/sudoers.d/g_wheel
rm -rf /usr/share/backgrounds/xfce
rm -f /etc/polkit-1/rules.d/49-nopasswd_global.rules
rm -r /etc/systemd/system/etc-pacman.d-gnupg.mount
rm /root/{.automated_script.sh,.zlogin}
rm /usr/local/bin/arcolinux-all-cores.sh
mv /etc/arcolinux-release /etc/lsb-release
pacman -R mkinitcpio-archiso --noconfirm
mv /etc/mkinitcpio.d/arcolinux /etc/mkinitcpio.d/linux.preset
rm /usr/local/bin/arcolinux-cleanup.sh
