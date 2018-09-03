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
    echo "EDITOR=${_EDITOR}" >> /etc/skel/.bashrc
    echo "EDITOR=${_EDITOR}" >> /etc/profile
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
    systemctl enable smb.service
    systemctl enable nmb.service
    systemctl enable winbind.service
    systemctl enable avahi-daemon.service
    #systemctl enable avahi-daemon.socket
    systemctl enable tlp.service
    systemctl enable tlp-sleep.service
    #systemctl enable vnstat.service
}


#function fontFix() {
    # To disable scaling of bitmap fonts (which often makes them blurry)
	# https://wiki.archlinux.org/index.php/font_configuration
#    rm -rf /etc/fonts/conf.d/10-scale-bitmap-fonts.conf
#}

function fixWifiFunc() {
    #https://wiki.archlinux.org/index.php/NetworkManager#Configuring_MAC_Address_Randomization
    su -c 'echo "" >> /etc/NetworkManager/NetworkManager.conf'
    su -c 'echo "[device]" >> /etc/NetworkManager/NetworkManager.conf'
    su -c 'echo "wifi.scan-rand-mac-address=no" >> /etc/NetworkManager/NetworkManager.conf'
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
    reflector --protocol https --latest 50 --number 20 --sort rate --save /etc/pacman.d/mirrorlist
    pacman -Sc --noconfirm
    pacman -Syyu --noconfirm
}

umaskFunc
echo "#####   Function umaskFunc done    #####"
#localeGenFunc
#echo "#####   Function localeGenFunc done    #####"
setTimeZoneAndClockFunc
echo "#####   Function setTimeZoneAndClockFunc done    #####"
editOrCreateConfigFilesFunc
echo "#####   Function editOrCreateConfigFilesFunc done    #####"
configRootUserFunc
echo "#####   Function configRootUserFunc done    #####"
createLiveUserFunc
echo "#####   Function createLiveUserFunc done    #####"
setDefaultsFunc
echo "#####   Function setDefaultsFunc done    #####"
enableServicesFunc
echo "#####   Function enableServicesFunc done    #####"
#fontFix
#echo "#####   Function fontFix done    #####"
fixWifiFunc
echo "#####   Function fixWifiFunc done    #####"
fixHibernateFunc
echo "#####   Function fixHibernateFunc done    #####"
initkeysFunc
echo "#####   Function  initkeysFunc done    #####"
getNewMirrorCleanAndUpgrade
echo "#####   Function getNewMirrorCleanAndUpgrade done    #####"
