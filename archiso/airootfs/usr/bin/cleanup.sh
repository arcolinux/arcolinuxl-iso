#!/bin/bash
rm -f /etc/sudoers.d/g_wheel
chmod 750 /etc/sudoers.d
chmod 750 /etc/polkit-1/rules.d
chgrp polkitd /etc/polkit-1/rules.d
rm -rf /usr/lib/calamares
rm -rf /usr/share/backgrounds/xfce
rm -f /etc/polkit-1/rules.d/49-nopasswd_global.rules
rm -r /etc/systemd/system/etc-pacman.d-gnupg.mount
rm /root/{.automated_script.sh,.zlogin}
rm /etc/mkinitcpio-archiso.conf
rm -r /etc/initcpio
gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ position 'left'
gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ theme 'OSXYosemite'
gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ zoom-enabled 'true'
gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ icon-size '36'
rm /usr/bin/cleanup.sh
