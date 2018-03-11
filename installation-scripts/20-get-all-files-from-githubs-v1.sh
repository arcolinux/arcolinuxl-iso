#!/bin/bash
#set -e
#
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	Erik Dubois
# ArcoLinux : 	https://arcolinux.com/
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "Removing old files/folders from folder"
rm -rf ../archiso/airootfs/etc/skel/.* 2> /dev/null

echo "getting .bashrc from arcolinux-root"

wget https://raw.githubusercontent.com/arcolinux/arcolinux-root/master/root/.bashrc-latest -O ../archiso/airootfs/etc/skel/.bashrc
echo ".bashrc copied to /etc/skel"

echo "getting oblogout.conf from arcolinux-oblogout-themes"

wget https://raw.githubusercontent.com/arcolinux/arcolinux-oblogout-themes/master/oblogout.conf.arcolinuxnew -O ../archiso/airootfs/etc/oblogout.conf

echo "oblogout.conf copied"

echo "getting slim.conf from arcolinux-slimlock-themes"

wget https://raw.githubusercontent.com/arcolinux/arcolinux-slimlock-themes/master/slim.conf.arcolinuxnew -O ../archiso/airootfs/etc/slim.conf

echo "slim.conf copied"
