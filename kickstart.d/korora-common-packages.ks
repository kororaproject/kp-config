%packages

#
# GROUPS
@admin-tools
@base-x
@guest-desktop-agents
@standard
@core
@fonts
@input-methods
@dial-up
@hardware-support
@printing
-@multimedia


# Explicitly specified here:
# <notting> walters: because otherwise dependency loops cause yum issues.
kernel-modules-extra

# This was added a while ago, I think it falls into the category of
# "Diagnosis/recovery tool useful from a Live OS image".  Leaving this untouched
# for now.
memtest86+

# the point of a live image is to install
anaconda
@anaconda-tools

# syslog replaced with journald
-rsyslog
-syslog-ng*

# include fedup so that future releases ca just run it and will always have the latest version
fedup

# make live images easy to shutdown and the like in libvirt
qemu-guest-agent

#
# THIRD PARTY
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
# ACCESSIBILITY
eekboard


#
# ARCHIVING
arj
lha
p7zip
p7zip-plugins
#unace - N/A - f22
unrar


#
# BRANDING
korora-extras
korora-release
korora-logos
-fedora-release-notes
korora-welcome
plymouth-theme-korora
grub2-starfield-theme
grub2-efi
efibootmgr
korora-icon-theme-base
korora-icon-theme
-f21-backgrounds*
freetype-freeworld


#
# CLOUD
mirall


#
# DESIGN / IMAGE EDITING
gimp
inkscape


#
# DEVELOPMENT / DEBUGGING
fpaste # fpaste is very useful for debugging and very small
gcc
git
ltrace
ntfsprogs
openssh-askpass
strace
vim
xz-lzma-compat


#
# DEVICE DRIVER / FIRMWARE MANAGEMENT
*firmware*
-b43-firmware-helper
b43-firmware
akmods
dkms
kernel-devel
pharlap


#
# FILESYSTEMS
btrfs-progs
exfat-utils
fuse
fuse-exfat
gparted
hdparm
samba
samba-winbind


#
# FONTS
aajohan-comfortaa-fonts  # need aajohan-comfortaa-fonts for the SVG rnotes images
open-sans-fonts


#
# GAMING PLATFORM
#removed due to bad selinux requirements. only people who want steam will get that
#steam


#
# NETWORKING
pptp-setup


#
# HARDWARE
libva-intel-driver
sane-backends
sane-backends-drivers-scanners
sane-backends-drivers-cameras
spice-server
spice-vdagent
splix


#
# HARDWARE MONITORING/CONTROLLING
htop
ksm
powertop

# fix 32bit breaking X when pulling in nvidia packages
mesa-libEGL


#
# MULTIMEDIA
HandBrake-gui
alsa-plugins-pulseaudio
alsa-utils
audacity-freeworld
dvb-apps
faac
ffmpeg
flac
flash-plugin.%%KP_BASEARCH%%
#flash-plugin.i386  # remove 32bit, now that we don't ship steam
gstreamer-ffmpeg
gstreamer-plugins-bad
gstreamer-plugins-bad-free
gstreamer-plugins-bad-free-extras
gstreamer-plugins-bad-nonfree
gstreamer-plugins-good
gstreamer-plugins-ugly
gstreamer1-libav
gstreamer1-plugins-bad-free
gstreamer1-plugins-bad-free-extras
gstreamer1-plugins-bad-freeworld
gstreamer1-plugins-good
gstreamer1-plugins-good-extras
gstreamer1-plugins-ugly
jack-audio-connection-kit
lame
libaacs
libdvdcss
libdvdnav
libdvdread
vlc
vlc-extras
vorbis-tools
xine-lib-extras
xine-lib-extras-freeworld
xine-plugin


#
# OFFICE / PRODUCTIVITY SUITE
-libreoffice-base
libreoffice-calc
libreoffice-draw
libreoffice-emailmerge
libreoffice-graphicfilter
libreoffice-impress
libreoffice-langpack-en
libreoffice-math
libreoffice-ogltrans
libreoffice-opensymbol-fonts
libreoffice-pdfimport
libreoffice-ure
libreoffice-writer
libreoffice-xsltfilter


#
# PACKAGE MANAGEMENT

# manage copr repos
dnf-plugins-core
yum-plugin-copr

yumex
yum-plugin-priorities
yum-plugin-refresh-updatesd
yum-plugin-versionlock
yum-updatesd


#
# SYSTEM ADMINSITRATION / CONFIGURATION
-ntp
-system-config-date
-system-config-firewall*
-system-config-keyboard
-system-config-language
-system-config-users
beesu
fonts-tweak-tool
liveusb-creator
policycoreutils-gui
polkit-desktop-policy
screen
screenfetch
setools-console
system-config-samba
system-config-services
#systemd-ui - N/A - f22
tmux


#
# TERMINAL ENHANCEMENTS

bash-completion
#etckeeper
unburden-home-dir
# undistract-me is great for notification on completion of long running terminal commands
#undistract-me


#
# WEB
firefox
mozilla-adblock-plus
mozilla-downthemall
mozilla-flashblock
mozilla-xclear


# TO SORT
chrony
expect
fprintd-pam
frei0r-plugins
java-1.8.0-openjdk
libimobiledevice
mlocate
PackageKit-browser-plugin
PackageKit-command-not-found
PackageKit-gstreamer-plugin
pavucontrol
planner
prelink
pybluez
time
xorg-x11-apps
xorg-x11-resutils

%end
