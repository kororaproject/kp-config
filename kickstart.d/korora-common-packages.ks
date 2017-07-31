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

# DEFAULT REMOVALS
-abrt*
-@multimedia

# Fixups
libcrypt-nss
-libcrypt

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

# make live images easy to shutdown and the like in libvirt
qemu-guest-agent

#
# THIRD PARTY
adobe-release
#dropbox-release # now in rpmfusion
google-chrome-release
google-earth-release
#google-talkplugin-release
#ksplice-uptrack
rpmfusion-free-release
rpmfusion-nonfree-release
virtualbox-release


#
# ACCESSIBILITY
#eekboard


#
# ARCHIVING
arj
lha
p7zip
p7zip-plugins
rar
#unace #k24
unrar
unar
xz-lzma-compat


#
# BRANDING
breeze-cursor-theme
korora-extras
korora-release
korora-logos
-fedora-release-notes
korora-welcome
plymouth-theme-korora
#plymouth-theme-hot-dog
#grub2-starfield-theme
grub2-efi
efibootmgr
korora-icon-theme-base
korora-icon-theme
korora-productimg-workstation
-fedora-productimg-workstation
-korora-release-workstation
-fedora-release-workstation
-f22-backgrounds*
freetype-freeworld


#
# CLOUD
owncloud-client


#
# DESIGN / IMAGE EDITING
gimp
inkscape


#
# DEVELOPMENT / DEBUGGING
ack
android-tools
#createrepo
fpaste # fpaste is very useful for debugging and very small
gcc
git
ltrace
#mock
ntfsprogs
openssh-askpass
#rpm-sign
strace
vim
fdupes

#
# DEVICE DRIVER / FIRMWARE MANAGEMENT
*firmware*
-b43-firmware-helper
b43-firmware
akmods
dkms
kernel-devel
lm_sensors-sensord
#pharlap #no longer useful


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
cups-*
-cups*devel
-cups-pdf # this doesn't work when building live images
#-cura-lulzbot
epson-inkjet-printer-escpr # support for recent Epson inkjet printers
hplip # support for extra HP printers
hpijs
libsane-hpaio # support for extra HP scanners
libva-intel-driver
mesa-libEGL # fix 32bit breaking X when pulling in nvidia packages
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

#
# MULTIMEDIA
HandBrake-gui
alsa-plugins-pulseaudio
alsa-utils
audacity-freeworld
dvb-apps
faac
ffmpeg
ffmpegthumbnailer
flac
#flash-plugin.%%KP_BASEARCH%%
#flash-plugin.i386  # remove 32bit, now that we don't ship steam
gstreamer-ffmpeg
gstreamer-plugins-bad
gstreamer-plugins-bad-free
gstreamer-plugins-bad-free-extras
gstreamer-plugins-bad-nonfree
gstreamer-plugins-good
gstreamer-plugins-good-extras
gstreamer-plugins-ugly
gstreamer1-libav
#gstreamer1-plugin-openh264 #k25
gstreamer1-plugins-bad-free
gstreamer1-plugins-bad-free-extras
gstreamer1-plugins-bad-freeworld
gstreamer1-plugins-good
gstreamer1-plugins-good-extras
gstreamer1-plugins-ugly
jack-audio-connection-kit
lame
libaacs
libbluray
libdvdcss
libdvdnav
libdvdread
#mozilla-openh264 #k25
raw-thumbnailer
vlc #k24
vlc-extras #k24
vorbis-tools


#
# OFFICE / PRODUCTIVITY SUITE
@libreoffice
libreoffice-langpack-en
libreoffice-ogltrans
libreoffice-opensymbol-fonts
libreoffice-pdfimport
libreoffice-ure
libreoffice-xsltfilter

#
# PACKAGE MANAGEMENT

# manage copr repos
dnf-plugins-core
dnf-plugin-system-upgrade
dnf-command(repomanage)
dnf-command(versionlock)

#yum-plugin-copr

yumex-dnf
#yum-plugin-priorities
#yum-plugin-refresh-updatesd
#yum-plugin-versionlock
#yum-updatesd


#
# SYSTEM ADMINSITRATION / CONFIGURATION
canvas
firewall-config
-ntp
-system-config-date
-system-config-firewall*
-system-config-keyboard
-system-config-language
-system-config-users
#beesu
fonts-tweak-tool
liveusb-creator
policycoreutils-gui
polkit-desktop-policy
#prelink
screen
screenfetch
setools-console
#system-config-samba - f26
-system-config-services
#systemd-ui - N/A - f22
tmux



#
# TERMINAL ENHANCEMENTS

bash-completion
#etckeeper
moe
unburden-home-dir
# undistract-me is great for notification on completion of long running terminal commands
#undistract-me


#
# WEB
firefox
#mozilla-adblock-plus
mozilla-arc-theme
mozilla-ublock-origin
#mozilla-downthemall
#mozilla-flashblock
mozilla-xclear


# TO SORT
aspell-en
chrony
cowsay
execstack
expect
fprintd-pam
frei0r-plugins
java-1.8.0-openjdk
icedtea-web
libimobiledevice
mlocate
PackageKit-command-not-found
PackageKit-gstreamer-plugin
pavucontrol
planner
pybluez
redhat-lsb-core
time
xorg-x11-apps
xorg-x11-resutils

%end
