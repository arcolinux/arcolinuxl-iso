#!/bin/bash

function umaskFunc() {
    set -e -u
    umask 022
}

#function localeGenFunc() {
    # Set locales
    #sed -i 's/^#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
    #locale-gen
#}

function setTimeZoneAndClockFunc() {
    # Timezone
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime
    # Set clock to UTC
    hwclock --systohc --utc
}

function configRootUserFunc() {
    usermod -s /usr/bin/bash root
    cp -aT /etc/skel/ /root/
    chmod 750 /root
}

function editOrCreateConfigFilesFunc () {

    # Locale
    echo "LANG=en_US.UTF-8" > /etc/locale.conf

    sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
    sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
    sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf
}

function createLiveUserFunc () {
	# add liveuser
	useradd -m liveuser -u 500 -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/bash
  chown -R liveuser:users /home/liveuser

  #enable autologin
  groupadd -r autologin
  gpasswd -a liveuser autologin

	groupadd -r nopasswdlogin
	gpasswd -a liveuser nopasswdlogin
}

function setDefaultsFunc() {
    export _EDITOR=nano
    echo "EDITOR=${_EDITOR}" >> /etc/environment
    echo "EDITOR=${_EDITOR}" >> /etc/profile
}

function fixHavegedFunc(){
    systemctl enable haveged
}

function fixPermissionsFunc() {
    chmod 750 /etc/sudoers.d
    chmod 750 /etc/polkit-1/rules.d
    chgrp polkitd /etc/polkit-1/rules.d
}

function enableServicesFunc() {
	systemctl enable lightdm.service
	systemctl set-default graphical.target
	systemctl enable NetworkManager.service
	systemctl enable virtual-machine-check.service
	systemctl enable reflector.service
	systemctl enable reflector.timer
  systemctl enable org.cups.cupsd.service
  systemctl enable bluetooth.service
  systemctl enable ntpd.service
  #systemctl enable smb.service
  #systemctl enable nmb.service
  #systemctl enable winbind.service
  systemctl enable avahi-daemon.service
  systemctl enable avahi-daemon.socket
  #systemctl enable tlp.service
  #systemctl enable tlp-sleep.service
  #systemctl enable vnstat.service
}


function fixWifiFunc() {
    #https://wiki.archlinux.org/index.php/NetworkManager#Configuring_MAC_Address_Randomization
    su -c 'echo "" >> /etc/NetworkManager/NetworkManager.conf'
    su -c 'echo "[device]" >> /etc/NetworkManager/NetworkManager.conf'
    su -c 'echo "wifi.scan-rand-mac-address=no" >> /etc/NetworkManager/NetworkManager.conf'
}

function fixGeoclueRedshift() {
    pathToGeoclueConf="/etc/geoclue/geoclue.conf"
    echo '' >> $pathToGeoclueConf
    echo '[redshift]' >> $pathToGeoclueConf
    echo 'allowed=true' >> $pathToGeoclueConf
    echo 'system=false' >> $pathToGeoclueConf
    echo 'users=' >> $pathToGeoclueConf
}

function fixHibernateFunc() {
    sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
    sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
    sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf
}

function initkeysFunc() {
    pacman-key --init
    pacman-key --populate archlinux
    pacman-key --populate arcolinux
    #pacman-key --keyserver hkps://hkps.pool.sks-keyservers.net:443 -r 74F5DE85A506BF64
    #pacman-key --keyserver hkp://pool.sks-keyservers.net:80 -r 74F5DE85A506BF64
    pacman-key --lsign-key 74F5DE85A506BF64
    #sudo pacman-key --refresh-keys
}

function getNewMirrorCleanAndUpgrade() {
    #reflector --protocol https --latest 50 --number 20 --sort rate --save /etc/pacman.d/mirrorlist
    reflector -f 30 -l 30 --number 10 --save /etc/pacman.d/mirrorlist
    pacman -Sc --noconfirm
    pacman -Syyu --noconfirm
}
echo
echo "##########################################################"
echo "##########################################################"
echo
umaskFunc
echo "#####   Function umaskFunc done    #####"
echo
setTimeZoneAndClockFunc
echo
echo "#####   Function setTimeZoneAndClockFunc done    #####"
echo
editOrCreateConfigFilesFunc
echo
echo "#####   Function editOrCreateConfigFilesFunc done    #####"
echo
configRootUserFunc
echo
echo "#####   Function configRootUserFunc done    #####"
echo
createLiveUserFunc
echo
echo "#####   Function createLiveUserFunc done    #####"
echo
setDefaultsFunc
echo
echo "#####   Function setDefaultsFunc done    #####"
echo
fixHavegedFunc
echo
echo "#####   Function fixHavegedFunc done    #####"
echo
fixPermissionsFunc
echo
echo "#####   Function fixPermissionsFunc done    #####"
echo
enableServicesFunc
echo
echo "#####   Function enableServicesFunc done    #####"
echo
fixGeoclueRedshift
echo
echo "#####   Function fixGeoclueRedshift done    #####"
echo
fixWifiFunc
echo
echo "#####   Function fixWifiFunc done    #####"
echo
fixHibernateFunc
echo
echo "#####   Function fixHibernateFunc done    #####"
echo
initkeysFunc
echo
echo "#####   Function  initkeysFunc done    #####"
echo
getNewMirrorCleanAndUpgrade
echo
echo "#####   Function getNewMirrorCleanAndUpgrade done    #####"
echo
echo "##########################################################"
echo "##########################################################"
echo
