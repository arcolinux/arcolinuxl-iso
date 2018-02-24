#!/bin/bash
#set -e
#
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	Erik Dubois
# Archmerge : 	https://archmerge.com/
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "Removing old files/folders from folder"
rm -rf ../archiso/airootfs/etc/skel/.* 2> /dev/null

echo "getting .bashrc from iso-skel"
cp -r ../../Archmerge-Root/root/.bashrc-latest ../archiso/airootfs/etc/skel/.bashrc
echo ".bashrc copied to /etc/skel"

echo "getting oblogout.conf from archmerge-oblogout-themes"
cp -r ../../Archmerge-Oblogout-Themes/oblogout.conf.archmergenew ../archiso/airootfs/etc/oblogout.conf
echo "oblogout.conf copied"

echo "getting slim.conf from archmerge-slimlock-themes"
cp -r ../../Archmerge-Slimlock-Themes/slim.conf.archmergenew ../archiso/airootfs/etc/slim.conf
echo "slim.conf copied"


# echo "Updating the .config folder"
# mkdir ../archiso/airootfs/etc/skel/.config
# echo "Copying files/folders to folder from github"
# cp -r ../../Archmerge-Iso-Skel/config/* ../archiso/airootfs/etc/skel/.config/
# echo "Everything copied in ~/.config"


# echo "Updating the .local folder"
# mkdir ../archiso/airootfs/etc/skel/.local
# echo "Copying files/folders to folder from github"
# cp -r ../../Archmerge-Iso-Skel/local/* ../archiso/airootfs/etc/skel/.local/
# echo "Everything copied in ~/.local"



# mkdir ../archiso/airootfs/etc/skel/.config/openbox
# echo "Copying new files/folders to folders from github"
# cp -r ../../Archmerge-Openbox-Configs/* ../archiso/airootfs/etc/skel/.config/openbox/
# echo "delete junk files"
# rm -rf ../archiso/airootfs/etc/skel/.config/openbox/git-v*.sh
# rm -rf ../archiso/airootfs/etc/skel/.config/openbox/README.md
# echo "Everything copied in ~/.config/openbox"


# echo "Updating i3 config files"
# mkdir ../archiso/airootfs/etc/skel/.config/i3
# echo "Copying new files/folders to folders from github"
# cp -r ../../Archmerge-i3wm/* ../archiso/airootfs/etc/skel/.config/i3/
# echo "delete junk files"
# rm -rf ../archiso/airootfs/etc/skel/.config/i3/git-v*.sh
# rm -rf ../archiso/airootfs/etc/skel/.config/i3/README.md
# echo "Everything copied in ~/.config/i3"


# echo "Updating the conky files"
# mkdir ../archiso/airootfs/etc/skel/.config/conky
# cp -r ../../Archmerge-Conky-Collection/* ../archiso/airootfs/etc/skel/.config/conky/
# echo "delete junk files"
# rm -rf ../archiso/airootfs/etc/skel/.config/conky/git-v*.sh
# rm -rf ../archiso/airootfs/etc/skel/.config/conky/README.md
# echo "Everything copied in ~/.config/conky"

# echo "Updating the termite themes files"
# mkdir ../archiso/airootfs/etc/skel/.config/termite/themes
# cp -r ../../Archmerge-Termite-Themes/themes/* ../archiso/airootfs/etc/skel/.config/termite/themes
# echo "Everything copied in ~/.config/termite/themes"
