#!/bin/bash
set -e
#
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	Erik Dubois
# Website 	: 	http://www.erikdubois.be
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "Let us change all instances of version number everywhere."

echo "What is the old version? e.g.   v20.4.1    (including v and dots)"
read oldversion

echo "To what version do you want upgrade e.g.    v20.4.2   (including v and dots)"

read newversion

echo "We will change all old instances i.e. "$oldversion" to this version: "$newversion
echo "Is this correct?  (y/n) "
read response
if [[ "$response" == [yY] ]]; then
    echo "Changing all instances";
    sed -i 's/'$oldversion'/'$newversion'/g' ../archiso/build.sh
    sed -i 's/'$oldversion'/'$newversion'/g' ../archiso/airootfs/etc/os-release
    #sed -i 's/'$oldversion'/'$newversion'/g' ../archiso/airootfs/etc/lsb-release
    sed -i 's/'$oldversion'/'$newversion'/g' ../archiso/airootfs/etc/dev-rel
    echo "All done"
	notify-send -u normal "All versions have been updated. Carry on!"

    else
    	echo "################################################################"
        echo "Nothing has been changed.";
		notify-send -u normal "Nothing has changed!"
fi
