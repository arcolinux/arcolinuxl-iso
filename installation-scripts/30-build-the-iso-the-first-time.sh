#!/bin/bash
#set -e
##################################################################################################################
# Author	:	Erik Dubois
# Website	:	https://www.erikdubois.be
# Website	:	https://www.arcolinux.info
# Website	:	https://www.arcolinux.com
# Website	:	https://www.arcolinuxd.com
# Website	:	https://www.arcolinuxb.com
# Website	:	https://www.arcolinuxiso.com
# Website	:	https://www.arcolinuxforum.com
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################
# set our parameters
buildFolder="$HOME/arcolinux-build"
outFolder="$HOME/ArcoLinux-Out"
isoFolder="arcolinux-iso"
iso_label="arcolinux-v20.11.7"
archisoversion=$(sudo pacman -Q archiso)

echo
echo "################################################################## "
tput setaf 2;echo "Phase 1 : get the latest bashrc from github";tput sgr0
echo "################################################################## "
echo
#echo "Removing old files/folders from /etc/skel"
#rm -rf ../archiso/airootfs/etc/skel/.* 2> /dev/null
echo "getting .bashrc from arcolinux-root"
wget https://raw.githubusercontent.com/arcolinux/arcolinux-root/master/etc/skel/.bashrc-latest -O ../archiso/airootfs/etc/skel/.bashrc
echo ".bashrc copied to /etc/skel"

echo
echo "################################################################## "
tput setaf 2;echo "Phase 2 : Checking if archiso is installed";tput sgr0
echo "################################################################## "
echo

package="archiso"

#----------------------------------------------------------------------------------

#checking if application is already installed or else install with aur helpers
if pacman -Qi $package &> /dev/null; then

		echo "################################################################"
		echo "################## "$package" is already installed"
		echo "################################################################"

else

	#checking which helper is installed
	if pacman -Qi yay &> /dev/null; then

		echo "################################################################"
		echo "######### Installing with yay"
		echo "################################################################"
		yay -S --noconfirm $package

	elif pacman -Qi trizen &> /dev/null; then

		echo "################################################################"
		echo "######### Installing with trizen"
		echo "################################################################"
		trizen -S --noconfirm --needed --noedit $package

	fi

	# Just checking if installation was successful
	if pacman -Qi $package &> /dev/null; then

		echo "################################################################"
		echo "#########  "$package" has been installed"
		echo "################################################################"

	else

		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		exit 1
	fi

fi
echo
echo "Changing the archiso.readme to the correct version"
sudo sed -i "s/\(^archiso-version=\).*/\1$archisoversion/" ../archiso.readme
echo
echo "Setting mkarchiso to verbose"
sudo sed -i 's/quiet="y"/quiet="n"/g' /usr/bin/mkarchiso

echo
echo "################################################################## "
tput setaf 2;echo "Phase 3 : Making sure we start with a clean slate";tput sgr0
echo "################################################################## "
echo
echo "Deleting the build folder if one exists - takes some time"
[ -d $buildFolder ] && sudo rm -rf $buildFolder


echo
echo "################################################################## "
tput setaf 2;echo "Phase 4 : Moving files to build folder";tput sgr0
echo "################################################################## "
echo
echo "Copying files and folder to build folder"
sudo cp -r ../../$isoFolder $buildFolder

sudo chmod 750 $buildFolder/archiso/airootfs/etc/sudoers.d
sudo chmod 750 $buildFolder/archiso/airootfs/etc/polkit-1/rules.d
sudo chgrp polkitd $buildFolder/archiso/airootfs/etc/polkit-1/rules.d
sudo chmod 750 $buildFolder/archiso/airootfs/root
sudo chmod 600 $buildFolder/archiso/airootfs/etc/gshadow
sudo chmod 600 $buildFolder/archiso/airootfs/etc/shadow

echo "adding time to /etc/dev-rel"
date_build=$(date -d now)
sudo sed -i "s/\(^ISO_BUILD=\).*/\1$date_build/" $buildFolder/archiso/airootfs/etc/dev-rel
echo
echo "################################################################## "
tput setaf 2;echo "Phase 5 : Cleaning the cache";tput sgr0
echo "################################################################## "
echo
yes | sudo pacman -Scc


echo
echo "################################################################## "
tput setaf 2;echo "Phase 6 : Building the iso";tput sgr0
echo "################################################################## "
echo

cd $buildFolder/archiso/
sudo ./build.sh

echo
echo "################################################################## "
tput setaf 2;echo "Phase 7 : Copying the iso to out folder";tput sgr0
echo "################################################################## "
echo
[ -d  $outFolder ] || mkdir $outFolder
echo "Moving iso to " $outFolder
cp $buildFolder/archiso/out/arcolinux* $outFolder

echo "###################################################################"
tput setaf 3;echo "checks and sign";tput sgr0
echo "###################################################################"
echo "Building sha1sum"
echo "########################"
cd $outFolder
sha1sum $iso_label-x86_64.iso > $iso_label.sha1
echo "Building sha256sum"
echo "########################"
sha256sum $iso_label-x86_64.iso > $iso_label.sha256
echo "Building md5sum"
echo "########################"
md5sum $iso_label-x86_64.iso > $iso_label.md5
echo "Moving pkglist.x86_64.txt"
echo "########################"
cp $buildFolder/archiso/work/iso/arch/pkglist.x86_64.txt  $outFolder/$iso_label".iso.pkglist.txt"
echo
echo "################################################################## "
tput setaf 2;echo "Phase 8 : Making sure we start with a clean slate next time";tput sgr0
echo "################################################################## "
echo
echo "Deleting the build folder if one exists - takes some time"
[ -d $buildFolder ] && sudo rm -rf $buildFolder
