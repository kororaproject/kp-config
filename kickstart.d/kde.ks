# kickstart file for Korora (KDE)
#
# KP:DESCRIPTION:START
#
# var KP_RELEASE_META_LABEL=kde
#
#
# KP:DESCRIPTION:END
#

%include %%KP_KICKSTART_DIR%%/base.ks
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
-f21-kde-theme
-f21-backgrounds-kde

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
kde-plasma-nm*
kdiff3
konversation
korora-settings-kde
krename
krusader
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
pharlap
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

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
DESKTOP="KDE"
DISPLAYMANAGER="KDE"
EOF

# make oxygen-gtk the default GTK+ theme for root (see #683855, #689070, #808062)
cat > /root/.gtkrc-2.0 << EOF
include "/usr/share/themes/oxygen-gtk/gtk-2.0/gtkrc"
include "/etc/gtk-2.0/gtkrc"
gtk-theme-name="oxygen-gtk"
EOF
mkdir -p /root/.config/gtk-3.0
cat > /root/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-theme-name = oxygen-gtk
EOF

# add initscript
cat >> /etc/rc.d/init.d/livesys << EOF
# KP - disable yumupdatesd
systemctl --no-reload yum-updatesd.service 2> /dev/null || :
systemctl stop yum-updatesd.service 2> /dev/null || :

# KP - ensure liveuser desktop exists
mkdir ~liveuser/Desktop

if [ -e /usr/share/icons/hicolor/96x96/apps/fedora-logo-icon.png ] ; then
    # use image also for kdm
    mkdir -p /usr/share/apps/kdm/faces
    cp /usr/share/icons/hicolor/96x96/apps/fedora-logo-icon.png /usr/share/apps/kdm/faces/fedora.face.icon
fi

# make liveuser use KDE
echo "startkde" > /home/liveuser/.xsession
chmod a+x /home/liveuser/.xsession
chown liveuser:liveuser /home/liveuser/.xsession

# set up autologin for user liveuser
if [ -f /etc/sddm.conf ]; then
sed -i 's/^#User=.*/User=liveuser/' /etc/sddm.conf
sed -i 's/^#Session=.*/Session=kde-plasma.desktop/' /etc/sddm.conf
else
cat > /etc/sddm.conf << SDDM_EOF
[Autologin]
User=liveuser
Session=kde-plasma.desktop
SDDM_EOF
fi

# set up autologin for user liveuser
sed -i 's/#AutoLoginEnable=true/AutoLoginEnable=true/' /etc/kde/kdm/kdmrc
sed -i 's/#AutoLoginUser=fred/AutoLoginUser=liveuser/' /etc/kde/kdm/kdmrc

# set up user liveuser as default user and preselected user
sed -i 's/#PreselectUser=Default/PreselectUser=Default/' /etc/kde/kdm/kdmrc
sed -i 's/#DefaultUser=johndoe/DefaultUser=liveuser/' /etc/kde/kdm/kdmrc

# add liveinst.desktop to favorites menu
mkdir -p /home/liveuser/.kde/share/config/
cat > /home/liveuser/.kde/share/config/kickoffrc << MENU_EOF
[Favorites]
FavoriteURLs=/usr/share/applications/kde4/systemsettings.desktop,/usr/share/applications/firefox.desktop,/usr/share/applications/kde4/dolphin.desktop,/usr/share/applications/kde4/konsole.desktop,/usr/share/applications/liveinst.desktop
MENU_EOF

# show liveinst.desktop on desktop and in menu
sed -i 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
#sed -i 's/Icon=liveinst/Icon=\/usr\/share\/icons\/Fedora\/scalable\/apps\/anaconda.svg/g' /usr/share/applications/liveinst.desktop

# chmod +x ~/Desktop/liveinst.desktop to disable KDE's security warning
chmod +x /usr/share/applications/liveinst.desktop

# copy over the icons for liveinst to hicolor
cp /usr/share/icons/gnome/16x16/apps/system-software-install.png /usr/share/icons/hicolor/16x16/apps/
cp /usr/share/icons/gnome/22x22/apps/system-software-install.png /usr/share/icons/hicolor/22x22/apps/
cp /usr/share/icons/gnome/24x24/apps/system-software-install.png /usr/share/icons/hicolor/24x24/apps/
cp /usr/share/icons/gnome/32x32/apps/system-software-install.png /usr/share/icons/hicolor/32x32/apps/
cp /usr/share/icons/gnome/48x48/apps/system-software-install.png /usr/share/icons/hicolor/48x48/apps/
cp /usr/share/icons/gnome/256x256/apps/system-software-install.png /usr/share/icons/hicolor/256x256/apps/
touch /usr/share/icons/hicolor/

# Set akonadi backend
mkdir -p /home/liveuser/.config/akonadi
cat > /home/liveuser/.config/akonadi/akonadiserverrc << AKONADI_EOF
[%General]
Driver=QSQLITE3
AKONADI_EOF

# Disable the update notifications of apper 
cat > /home/liveuser/.kde/share/config/apper << APPER_EOF
[CheckUpdate]
autoUpdate=0
distroUpgrade=0
interval=0
APPER_EOF

# Disable (apper's) plasma-applet-updater (#948099)
mkdir -p /home/liveuser/.kde/share/kde4/services/
sed -e "s|^X-KDE-PluginInfo-EnabledByDefault=true|X-KDE-PluginInfo-EnabledByDefault=false|g" \
   /usr/share/kde4/services/plasma-applet-updater.desktop > \
   /home/liveuser/.kde/share/kde4/services/plasma-applet-updater.desktop

# Disable some kded modules
# apperd: http://bugzilla.redhat.com/948099
cat > /home/liveuser/.kde/share/config/kdedrc << KDEDRC_EOF
[Module-apperd]
autoload=false
KDEDRC_EOF

# Disable baloo
cat > /home/liveuser/.kde/share/config/baloofilerc << BALOO_EOF
[Basic Settings]
Indexing-Enabled=false
BALOO_EOF

# Disable kres-migrator
cat > /home/liveuser/.kde/share/config/kres-migratorrc << KRES_EOF
[Migration]
Enabled=false
KRES_EOF

# Disable nepomuk
cat > /home/liveuser/.kde/share/config/nepomukserverrc << NEPOMUK_EOF
[Basic Settings]
Start Nepomuk=false

[Service-nepomukfileindexer]
autostart=false
NEPOMUK_EOF

# KP - don't use prelink on a running KDE live image
mv /usr/sbin/prelink /usr/sbin/prelink-disabled
rm /etc/cron.daily/prelink

# KP - un-mute sound card (fixes some issues reported)
#amixer set Master 85% unmute 2>/dev/null
#amixer set PCM 85% unmute 2>/dev/null
#pactl set-sink-mute 0 0
#pactl set-sink-volume 0 50000


# KP - disable screensaver
mkdir -p /home/liveuser/.kde/share/config
cat > /home/liveuser/.kde/share/config/kscreensaverrc << SCREEN_EOF
[ScreenSaver]
Enabled=false
Lock=false
LockGrace=60000
PlasmaEnabled=false
Timeout=60
SCREEN_EOF

# KP - disable screen lock
cat > /home/liveuser/.kde/share/config/powerdevilrc << LOCK_EOF
[General]
configLockScreen=false
LOCK_EOF


# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

# small hack to enable plasma-netbook workspace on boot
if strstr "\`cat /proc/cmdline\`" netbook ; then
   mv /usr/share/autostart/plasma-desktop.desktop /usr/share/autostart/plasma-netbook.desktop
   sed -i 's/desktop/netbook/g' /usr/share/autostart/plasma-netbook.desktop
fi


# KP - disable jockey from autostarting
#rm /etc/xdg/autostart/jockey*

# turn off PackageKit-command-not-found
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

EOF

%end
