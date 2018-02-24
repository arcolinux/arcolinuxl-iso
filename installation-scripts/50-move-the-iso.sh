#!/bin/bash
set -e
#
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	Erik Dubois
# ArcoLinux	: 	https://arcolinux.com/
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "moving iso to documents"
cp ~/arcolinux-build/archiso/out/arcolinux* ~/Documents/

echo "moving iso to insync just for Teammembers only"
cp ~/arcolinux-build/archiso/out/arcolinux* ~/Insync/SHARED/TeamMembers-Only/

#echo "moving iso to insync TEAMMEMBERS"
#cp ~/arcolinuxd-build/archiso/out/arcolinuxd* ~/Insync/SHARED/arcolinux/
