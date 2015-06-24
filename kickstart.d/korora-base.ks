# korora-base.ks
#
# Defines the basics for all kickstarts in the fedora-live branch
# Does not include package selection (other then mandatory)
# Does not include localization packages or configuration
#
# Does includes "default" language configuration (kickstarts including
# this template can override these settings)

timezone Etc/UTC --isUtc --ntpservers=0.pool.ntp.org,1.pool.ntp.org,2.pool.ntp.org,3.pool.ntp.org
auth --enableshadow --passalgo=sha512 --enablefingerprint
selinux --enforcing
firewall --enabled --service=ipp-client,mdns,samba,samba-client,ssh
xconfig --startxonboot
part / --size 10240 --fstype ext4
services --enabled=ksmtuned,lirc,NetworkManager,restorecond,spice-vdagentd --disabled=abrtd,abrt-ccpp,abrt-oops,abrt-vmcore,abrt-xorg,capi,iprdump,iprinit,iprupdate,iscsi,iscsid,isdn,libvirtd,multipathd,netfs,network,nfs,nfslock,pcscd,rpcbind,rpcgssd,rpcidmapd,rpcsvcgssd,sendmail,sm-client,sshd

%include korora-repo.ks

#
# PACKAGES

%packages
-b43-firmware-helper
b43-firmware
@admin-tools
@base-x
@guest-desktop-agents
@standard
@core
@fonts
@input-methods
@dial-up
-@multimedia
@hardware-support
@printing

# Explicitly specified here:
# <notting> walters: because otherwise dependency loops cause yum issues.
kernel-modules-extra

# manage copr repos
dnf-plugins-core
yum-plugin-copr

# This was added a while ago, I think it falls into the category of
# "Diagnosis/recovery tool useful from a Live OS image".  Leaving this untouched
# for now.
memtest86+

# The point of a live image is to install
anaconda
@anaconda-tools

# Need aajohan-comfortaa-fonts for the SVG rnotes images
aajohan-comfortaa-fonts

# syslog replaced with journald
-rsyslog
-syslog-ng*

# Include fedup so that future releases ca just run it and will always have the latest version
fedup

# Make live images easy to shutdown and the like in libvirt
qemu-guest-agent

## KP START
#Install 3rd party repo releases
adobe-release
#dropbox-release
google-chrome-release
google-earth-release
google-talkplugin-release
#ksplice-uptrack
rpmfusion-free-release
rpmfusion-nonfree-release
virtualbox-release

#
# (RE)BRANDING
korora-extras
korora-release
korora-logos
-korora-release-notes
-fedora-release-notes
korora-welcome
plymouth-theme-korora
#korora-videos
grub2-starfield-theme
grub2-efi
efibootmgr
open-sans-fonts
korora-icon-theme-base
korora-icon-theme
-f21-backgrounds*
freetype-freeworld

#
# FILESYSTEMS
exfat-utils
fuse-exfat
hdparm

#
# TERMINAL ENHANCEMENTS

# undistract-me is great for notification on completion of long running terminal commands
#undistract-me
unburden-home-dir
#etckeeper

#Networking
pptp-setup

# Dev
openssh-askpass

# fpaste is very useful for debugging and very small
fpaste

#
# HARDWARE MONITORING/CONTROLLING
powertop
ksm

# archiving
arj
lha
#unace
unrar


# fix 32bit breaking X when pulling in nvidia packages
mesa-libEGL

#
# SYSTEM CONFIG
system-config-samba
system-config-services
#systemd-ui
-system-config-language
-system-config-date
-system-config-firewall*
-system-config-keyboard
-system-config-users
setools-console
fonts-tweak-tool
screenfetch

#
# Hardware
spice-server
spice-vdagent
splix
sane-backends-drivers-scanners
sane-backends-drivers-cameras
libva-intel-driver

#
# MULTIMEDIA
#flash-plugin-helper
flash-plugin.%%KP_BASEARCH%%
#remove 32bit, now that we don't ship steam
#flash-plugin.i386
dvb-apps
ffmpeg
libaacs

strace
ltrace

xz-lzma-compat
ntfsprogs

#
# GAMING PLATFORM
#removed due to bad selinux requirements. only people who want steam will get that
#steam

# Office
-libreoffice-base

#
# CLOUD
mirall

pharlap
## KP END

%end

%post

# disable all abrt services, we can't upload to bugzilla
for x in abrtd abrt-ccpp abrt-oops abrt-vmcore abrt-xorg ; do
  systemctl disable $x
done

# KP - import keys
echo -e "\n***\nIMPORTING KEYS\n***"
for x in 20 21 22
do
  for y in adobe fedora-$x-primary fedora-$x-secondary google-chrome google-earth google-talkplugin korora-$x-primary korora-$x-secondary rpmfusion-free-fedora-$x-primary rpmfusion-nonfree-fedora-$x-primary virtualbox
  do
    KEY="/etc/pki/rpm-gpg/RPM-GPG-KEY-${y}"
    if [ -r "${KEY}" ];
    then
      rpm --import "${KEY}" && echo "IMPORTED: $KEY (${y})"
    else
      echo "IMPORT KEY NOT FOUND: $KEY (${y})"
    fi
  done
done

# enable magic keys
echo "kernel.sysrq = 1" >> /etc/sysctl.conf

## KP START
# make home dir
mkdir /etc/skel/{Documents,Downloads,Music,Pictures,Videos}

# set the korora plymouth theme
sed -i s/^Theme=.*/Theme=korora/ /etc/plymouth/plymouthd.conf
## KP END

%end
