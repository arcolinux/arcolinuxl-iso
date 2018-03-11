#!/bin/bash
set -e
#
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	Erik Dubois
# ArcoLinux	: 	https://arcolinux.info/
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "Checking if archiso is installed"

package="archiso"

#----------------------------------------------------------------------------------

#checking if application is already installed or else install with aur helpers
if pacman -Qi $package &> /dev/null; then

	echo "################################################################"
	echo "################## "$package" is already installed"
	echo "################################################################"

else

	#checking which helper is installed
	if pacman -Qi yaourt &> /dev/null; then

		echo "Installing with yaourt"
		yaourt -S --noconfirm $package

	elif pacman -Qi pacaur &> /dev/null; then

		echo "Installing with pacaur"
		pacaur -S --noconfirm --noedit  $package

	elif pacman -Qi packer &> /dev/null; then

		echo "Installing with packer"
		packer -S --noconfirm --noedit  $package

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

	fi

fi



echo "building local"


echo "Deleting the build folder if one exists - takes some time"

# cleaning folder
[ -d ~/arcolinux-build ] && sudo rm -rf ~/arcolinux-build

echo "Copying files and folder to ~/arcolinux-build"

sudo cp -r ../../arcolinux-iso ~/arcolinux-build



cd ~/arcolinux-build/archiso/


echo "################################################################"
read -p "In order to build an iso we need to clean your cache (y/n)?" choice

	case "$choice" in
 	 y|Y ) sudo pacman -Sc;;
 	 n|N ) echo "Script has stopped. Nothing changed." & exit;;
 	 * ) echo "Type y or n." & echo "Script ended!" & exit;;
	esac


echo "Making the Iso"

sudo ./build.sh -v
