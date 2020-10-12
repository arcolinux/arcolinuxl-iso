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
echo
echo "################################################################## "
tput setaf 2
echo "Phase 1 : "
echo "- General parameters"
tput sgr0
echo "################################################################## "
echo

	#Let us set the desktop"
	#First letter of desktop is small letter

	desktop="xfce"
	lightdmDesktop="xfce"

	arcolinuxVersion='v20.11.7'

	isoLabel='arcolinux-'$arcolinuxVersion'-x86_64.iso'

	# setting of the general parameters
	buildFolder=$HOME"/arcolinux-build"
	outFolder=$HOME"/ArcoLinux-Out"
	archisoVersion=$(sudo pacman -Q archiso)
	
	echo "################################################################## "		
	echo "Building the desktop                   : "$desktop
	echo "Bulding version                        : "$arcolinuxVersion
	echo "Iso label                              : "$isoLabel
	echo "Do you have the right archiso version? : "$archisoVersion
	echo "Build folder                           : "$buildFolder
	echo "Out folder                             : "$outFolder
	echo "################################################################## "		

echo
echo "################################################################## "
tput setaf 2
echo "Phase 2 :" 
echo "- Checking if archiso is installed"
echo "- Saving current archiso version to readme"
echo "- Making mkarchiso verbose"
tput sgr0
echo "################################################################## "
echo

	package="archiso"

	#----------------------------------------------------------------------------------

	#checking if application is already installed or else install with aur helpers
	if pacman -Qi $package &> /dev/null; then

			echo "Archiso is already installed"

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
	echo "Saving current archiso version to readme"
	sudo sed -i "s/\(^archiso-version=\).*/\1$archisoVersion/" ../archiso.readme
	echo
	echo "Making mkarchiso verbose"
	sudo sed -i 's/quiet="y"/quiet="n"/g' /usr/bin/mkarchiso

echo
echo "################################################################## "
tput setaf 2
echo "Phase 3 :"
echo "- Deleting the work folder if one exists"
echo "- Deleting the build folder if one exists"
echo "- Copying the Archiso folder to work"
tput sgr0
echo "################################################################## "
echo

	echo "Deleting the work folder if one exists"
	[ -d ../work ] && sudo rm -rf ../work
	echo
	echo "Deleting the build folder if one exists - takes some time"
	[ -d $buildFolder ] && sudo rm -rf $buildFolder
	echo
	echo "Copying the Archiso folder to work"
	echo
	mkdir ../work
	cp -r ../archiso ../work

echo
echo "################################################################## "
tput setaf 2
echo "Phase 4 :"
echo "- Deleting any files in /etc/skel"
echo "- Getting the last version of bashrc in /etc/skel"
echo "- Removing the old packages.x86_64 file from work folder"
echo "- Copying the new packages.x86_64 file to the work folder"
tput sgr0
echo "################################################################## "
echo

	echo "Deleting any files in /etc/skel"
	rm -rf ../work/archiso/airootfs/etc/skel/.* 2> /dev/null
	echo

	echo "Getting the last version of bashrc in /etc/skel"
	echo
	wget https://raw.githubusercontent.com/arcolinux/arcolinux-root/master/etc/skel/.bashrc-latest -O ../work/archiso/airootfs/etc/skel/.bashrc

	echo "Removing the old packages.x86_64 file from work folder"
	rm ../work/archiso/packages.x86_64
	echo
	echo "Copying the new packages.x86_64 file to the work folder"
	cp -f ../archiso/packages.x86_64 ../work/archiso/packages.x86_64


echo
echo "################################################################## "
tput setaf 2
echo "Phase 5 : "
echo "- Changing all references"
echo "- Adding time to /etc/dev-rel"
tput sgr0
echo "################################################################## "
echo

	#Setting variables

	#profiledef.sh
	oldname1='iso_name=arcolinux'
	newname1='iso_name=arcolinux'

	oldname2='iso_label="arcolinux'
	newname2='iso_label="arcolinux'

	oldname3='ArcoLinux'
	newname3='ArcoLinux'

	#hostname
	oldname4='ArcoLinux'
	newname4='ArcoLinux'

	#lightdm.conf user-session
	oldname5='user-session=xfce'
	newname5='user-session='$lightdmDesktop

	#lightdm.conf autologin-session
	oldname6='#autologin-session='
	newname6='autologin-session='$lightdmDesktop

	echo "Changing all references to the -B variant"
	echo
	sed -i 's/'$oldname1'/'$newname1'/g' ../work/archiso/profiledef.sh
	sed -i 's/'$oldname2'/'$newname2'/g' ../work/archiso/profiledef.sh
	sed -i 's/'$oldname3'/'$newname3'/g' ../work/archiso/airootfs/etc/dev-rel
	sed -i 's/'$oldname4'/'$newname4'/g' ../work/archiso/airootfs/etc/hostname
	sed -i 's/'$oldname5'/'$newname5'/g' ../work/archiso/airootfs/etc/lightdm/lightdm.conf
	sed -i 's/'$oldname6'/'$newname6'/g' ../work/archiso/airootfs/etc/lightdm/lightdm.conf

	echo "Adding time to /etc/dev-rel"
	date_build=$(date -d now)
	echo "Iso build on : "$date_build
	sudo sed -i "s/\(^ISO_BUILD=\).*/\1$date_build/" ../work/archiso/airootfs/etc/dev-rel

echo
echo "################################################################## "
tput setaf 2
echo "Phase 6 : "
echo "- Copying files and folder to build folder as root"
echo "- Double-checking permissions"
tput sgr0
echo "################################################################## "
echo

	echo "Copying files and folder to build folder as root"
	[ -d  $buildFolder ] || sudo mkdir $buildFolder
	sudo cp -r ../work/* $buildFolder
	echo

	echo "Double-checking permissions"
	sudo chmod 750 $buildFolder/archiso/airootfs/etc/sudoers.d
	sudo chmod 750 $buildFolder/archiso/airootfs/etc/polkit-1/rules.d
	sudo chgrp polkitd $buildFolder/archiso/airootfs/etc/polkit-1/rules.d
	sudo chmod 750 $buildFolder/archiso/airootfs/root
	sudo chmod 600 $buildFolder/archiso/airootfs/etc/gshadow
	sudo chmod 600 $buildFolder/archiso/airootfs/etc/shadow

#echo
#echo "################################################################## "
#tput setaf 2
#echo "Phase 7 :"
#echo "- Cleaning the cache from /var/cache/pacman/pkg/"
#tput sgr0
#echo "################################################################## "
#echo

	#echo "Cleaning the cache from /var/cache/pacman/pkg/"
	#yes | sudo pacman -Scc

echo
echo "################################################################## "
tput setaf 2
echo "Phase 8 :"
echo "- Building the iso - this can take a while - be patient"
tput sgr0
echo "################################################################## "
echo

	cd $buildFolder/archiso/
	sudo ./build.sh

echo
echo "################################################################## "
tput setaf 2
echo "Phase 9 :"
echo "- Copying the iso to the out folder :"$outFolder
tput sgr0
echo "################################################################## "
echo

	[ -d $outFolder ] || mkdir $outFolder
	echo "Copying the iso to the out folder : "$outFolder
	cp $buildFolder/archiso/out/arcolinux* $outFolder

echo
echo "###################################################################"
tput setaf 2
echo "Phase 10 :"
echo "- Creating checksums"
echo "- Moving pgklist"
tput sgr0
echo "###################################################################"
echo

	cd $outFolder

	echo "Creating checksums for : "$isoLabel
	echo "##################################################################"
	echo
	echo "Building sha1sum"
	echo "########################"
	sha1sum $isoLabel > $isoLabel.sha1
	echo "Building sha256sum"
	echo "########################"
	sha256sum $isoLabel > $isoLabel.sha256
	echo "Building md5sum"
	echo "########################"
	md5sum $isoLabel >$isoLabel.md5
	echo
	echo "Moving pkglist.x86_64.txt"
	echo "########################"
	cp $buildFolder/archiso/work/iso/arch/pkglist.x86_64.txt  $outFolder/$isoLabel".iso.pkglist.txt"
	

#echo
#echo "##################################################################"
#tput setaf 2
#echo "Phase 11 :"
#echo "- Making sure we start with a clean slate next time"
#tput sgr0
#echo "################################################################## "
#echo

	#echo "Deleting the build folder if one exists - takes some time"
	#[ -d $buildFolder ] && sudo rm -rf $buildFolder

echo
echo "##################################################################"
tput setaf 2
echo "DONE"
echo "- Check your out folder :"$outFolder
tput sgr0
echo "################################################################## "
echo
