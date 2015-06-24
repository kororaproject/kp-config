%include fedora-live-kde.ks
%include korora-base.ks

services --enabled=kdm --disabled=sddm

#
# PACKAGES
#

%packages
@firefox
@kde-desktop
@libreoffice

@kde-apps
@kde-telepathy

# make sure mariadb lands instead of MySQL (hopefully a temporary hack)
mariadb-embedded
mariadb-libs
mariadb-server

# FIXME; apparently the glibc maintainers dislike this
nss-mdns

# (RE)BRANDING
#korora-backgrounds-kde
#korora-backgrounds-extras-kde
-desktop-backgrounds-basic
-f22-kde-theme
-f22-backgrounds-kde

#egtk-gtk2-theme
#egtk-gtk3-theme
#elementary-icon-theme
adwaita-gtk3-theme

#
# EXTRA PACKAGES
#add-remove-extras
akmods
alsa-utils
alsa-plugins-pulseaudio
amarok
apper
backintime-kde
bash-completion
beesu
bluedevil
#bootconf-gui
btrfs-progs
calibre
choqok
chrony
#cups-pdf
dolphin-root-actions
digikam
eekboard
expect
firefox
*firmware*
#libXft-infinality
#freetype-infinality
#fontconfig-infinality
font-manager
fprintd-pam
frei0r-plugins
fuse
gimp
git
gparted
-NetworkManager*-gnome
HandBrake-gui
htop
hugin-base
inkscape
jack-audio-connection-kit
java-1.8.0-openjdk
#java-1.7.0-openjdk-plugin
#jockey
#jockey-kde
#jockey-selinux
#jockey-akmods
k3b-extras-freeworld
kalarm
kamoso
kaudiocreator
kde-l10n-*
kdeartwork
#kdeartwork-screensavers #remove this too because it pulls in xscreensaver stuff
kdeartwork-wallpapers
kdebase-workspace-ksplash-themes
-kdegames
kdegames-minimal
kdenlive
#kde-partitionmanager
kde-plasma-daisy
kde-plasma-yawp
kde-settings
kde-settings-pulseaudio
kde-settings-ksplash
kde-workspace-ksplash-themes
kde-settings-plasma
kdemultimedia-extras-freeworld
kdeplasma-addons
kdm
kipi-plugins
kjots
kde-plasma-nm*
kdiff3
konversation
korora-settings-kde
krdc
krename
krusader
ktimetracker
ktorrent
libdvdcss
libdvdnav
libdvdread
libimobiledevice
libreoffice-calc
libreoffice-draw
libreoffice-emailmerge
libreoffice-graphicfilter
libreoffice-impress
libreoffice-kde
libreoffice-langpack-en
libreoffice-math
libreoffice-ogltrans
libreoffice-opensymbol-fonts
libreoffice-pdfimport
#libreoffice-presenter-screen - f19 - N/A
#libreoffice-report-builder
libreoffice-ure
libreoffice-writer
libreoffice-xsltfilter
linphone
liveusb-creator
mlocate
mozilla-adblock-plus
mozilla-downthemall
mozilla-flashblock
#mozilla-oxygen-kde
#mozilla-plasma-notify
mozilla-xclear
-ntp
okular
p7zip
p7zip-plugins
PackageKit-browser-plugin
PackageKit-command-not-found
planner
policycoreutils-gui
polkit-desktop-policy
prelink
pybluez
qtcurve-kde4
qtcurve-gtk2
qt-recordmydesktop
#rawtherapee
darktable
samba
samba-winbind
sane-backends
screen
skanlite
-synaptic
#system-config-lvm - f19 - N/A
-system-config-printer
system-config-users
kde-print-manager
vim
xorg-x11-apps
#xscreensaver-gl-extras
#xscreensaver-extras
#xscreensaver-base
xorg-x11-resutils
yakuake
yumex
#yum-plugin-fastestmirror
yum-plugin-priorities
#yum-plugin-security
yum-plugin-refresh-updatesd
yum-plugin-versionlock
yum-updatesd

#
# MULTIMEDIA
# Note: KDE will use Xine by default, but also support Gstreamer
audacity-freeworld
faac
flac
gstreamer1-libav
gstreamer-ffmpeg
gstreamer-plugins-bad
gstreamer-plugins-bad-free
gstreamer-plugins-bad-free-extras
gstreamer-plugins-bad-nonfree
gstreamer-plugins-good
gstreamer-plugins-ugly
gstreamer1-plugins-bad-free
gstreamer1-plugins-bad-free-extras
gstreamer1-plugins-bad-freeworld
gstreamer1-plugins-good
gstreamer1-plugins-good-extras
gstreamer1-plugins-ugly
kid3
kio-ftps
kio_mtp
lame
libmpg123
#miro
PackageKit-gstreamer-plugin
pavucontrol
python3-PyQt4
phonon-backend-vlc
vlc
vlc-extras
vorbis-tools
xine-lib-extras
xine-lib-extras-freeworld
xine-plugin
xine-lib-extras
xine-lib-extras-freeworld


#
# development tools for out of tree modules
gcc
kernel-devel
dkms
time

%end

%post

echo -e "\n*****\nPOST SECTION\n*****\n"

#this is fixed now 21-2
# work around KDE bug
#mkdir -p /etc/skel/.kde/share/config
#cat > /etc/skel/.kde/share/config/kwalletrc << \EOF
#[Wallet]
#Launch Manager[$d]
#EOF

systemctl enable kdm.service

# KP - build out of kernel modules (so it's not done on first boot)
#echo -e "\n***\nBUILDING AKMODS\n***"
#/usr/sbin/akmods --force

#KDE - stop Klipper from starting
#sed -i 's/AutoStart:true/AutoStart:false/g' /usr/share/autostart/klipper.desktop

# KP - start yum-updatesd
systemctl enable yum-updatesd.service

# KP - update locate database
/usr/bin/updatedb

# KP - let's run prelink (makes things faster)
echo -e "***\nPRELINKING\n****"
/usr/sbin/prelink -av -mR -q

EOF

%end
