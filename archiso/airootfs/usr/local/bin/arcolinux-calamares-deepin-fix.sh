#!/bin/bash
echo "#################################"
echo "Start arcolinux-calamares-deepin-fix.sh"
echo "#################################"

echo "adding style"
echo "#################################"

FIND="\/usr\/bin\/calamares"
REPLACE="\/usr\/bin\/calamares --style fusion"

find "/usr/share/arcolinux-welcome-app/arcolinux-welcome-app.py" -type f -exec sed -i "s/$FIND/$REPLACE/g" {} \;

echo "#################################"
echo "End arcolinux-calamares-deepin-fix.sh"
echo "#################################"
rm /usr/local/bin/arcolinux-calamares-deepin-fix.sh
