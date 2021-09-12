#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="arcolinuxl"
iso_label="arcolinuxl-v21.11.1"
iso_publisher="ArcoLinux <http://www.arcolinux.info>"
iso_application="ArcoLinux Live/Rescue CD"
iso_version="v21.11.1"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
file_permissions=(
  ["/etc/gshadow"]="0:0:600"	
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/etc/polkit-1/rules.d"]="0:0:750"
  ["/etc/sudoers.d"]="0:0:750"
  ["/usr/local/bin/arcolinux-all-cores"]="0:0:755"
  ["/usr/local/bin/arcolinux-final"]="0:0:755"
  ["/usr/local/bin/arcolinux-remove-nvidia"]="0:0:755"
  ["/usr/local/bin/arcolinux-displaymanager-check"]="0:0:755"
  ["/usr/local/bin/arcolinux-before"]="0:0:755"
)
