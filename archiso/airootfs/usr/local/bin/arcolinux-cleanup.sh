#!/bin/bash
echo "#################################"
echo "Start arcolinux-cleanup.sh"
echo "#################################"

echo "Permissions of important folders"
echo "#################################"
chmod 750 /root
chmod 750 /etc/sudoers.d
chmod 750 /etc/polkit-1/rules.d
chgrp polkitd /etc/polkit-1/rules.d
chmod 600 /etc/gshadow
chmod 600 /etc/shadow

echo "Reflector"
echo "#################################"
reflector --threads 50 -l 100 -f 100 --number 20 --sort rate --save /etc/pacman.d/mirrorlist

echo "Populate Core Team keys"
echo "#################################"
pacman-key --init
pacman-key --populate archlinux
pacman-key --populate arcolinux
#erik
pacman-key --lsign-key 74F5DE85A506BF64
#marco
pacman-key --lsign-key F1ABB772CE9F7FC0
#john
pacman-key --lsign-key 4B1B49F7186D8731
#stephen
pacman-key --lsign-key 02D507C6EFB8CEAA
#brad
pacman-key --lsign-key 18064BF445855549
#raniel
pacman-key --lsign-key 7EC1A5550718AB89

echo " Copy grub Vimix theme (archiso deletes /boot when making the ISO)"
echo "#################################"
mkdir -p /boot/grub/themes
cp -Rf /usr/share/grub/themes/Vimix /boot/grub/themes/

echo "Cleanup autologin root"
echo "#################################"
rm -rf /etc/systemd/system/getty@tty1.service.d

echo "Fix for pamac icons not showing"
echo "#################################"
zcat /usr/share/app-info/xmls/community.xml.gz | sed 's|<em>||g;s|<\/em>||g;' | gzip > "new.xml.gz"
mv new.xml.gz /usr/share/app-info/xmls/community.xml.gz
appstreamcli refresh-cache --force

echo "Bluetooth improvements"
echo "#################################"
sed -i "s/#AutoEnable=false/AutoEnable=true/g" /etc/bluetooth/main.conf
echo 'load-module module-switch-on-connect' | sudo tee --append /etc/pulse/default.pa

#Original cleanup
echo "Cleanup original files"
echo "#################################"
rm -f /etc/sudoers.d/g_wheel
rm -rf /usr/share/backgrounds/xfce
rm -f /etc/polkit-1/rules.d/49-nopasswd_global.rules
rm -r /etc/systemd/system/etc-pacman.d-gnupg.mount
rm /root/{.automated_script.sh,.zlogin}
rm /usr/local/bin/arcolinux-all-cores.sh
mv /etc/arcolinux-release /etc/lsb-release
mv /etc/mkinitcpio.d/arcolinux /etc/mkinitcpio.d/linux.preset

echo "#################################"
echo "End arcolinux-cleanup.sh"
echo "#################################"
rm /usr/local/bin/arcolinux-cleanup.sh
