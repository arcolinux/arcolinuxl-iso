#!/bin/bash
#userid 972 error lightdm
chage -E -1 lightdm
rm -f /etc/sudoers.d/g_wheel
rm -rf /usr/share/backgrounds/xfce
rm -f /etc/polkit-1/rules.d/49-nopasswd_global.rules
rm -r /etc/systemd/system/etc-pacman.d-gnupg.mount
rm /root/{.automated_script.sh,.zlogin}
rm /etc/mkinitcpio-archiso.conf
rm -r /etc/initcpio
rm /usr/bin/arcolinux-all-cores.sh
rm /usr/bin/arcolinux-cleanup.sh
