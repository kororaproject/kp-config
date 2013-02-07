# Kickstart file for Kororaa Remix (KDE) x86_64
# To use this for 32bit build, :4,$s/x86_64/i386/g
# and build with 'setarch i686 livecd-creator ...'

#
# KP:DESCRIPTION:START
#
# var KP_RELEASE_META_LABEL=kde
#
#
# KP:DESCRIPTION:END
#

%include %%KP_KICKSTART_DIR%%/base.ks

#
# PACKAGES
#

%packages
@firefox
@kde-desktop
@libreoffice

# FIXME; apparently the glibc maintainers dislike this
nss-mdns

# (RE)BRANDING
korora-backgrounds-kde
korora-backgrounds-extras-kde
-desktop-backgrounds-basic

elementary-gtk
elementary-icon-theme
adwaita-gtk3-theme

#
# EXTRA PACKAGES
#add-remove-extras
akmods
alsa-utils
alsa-plugins-pulseaudio
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
cups-pdf
dolphin-root-actions
eekboard
expect
firefox
*firmware*
libXft-infinality
freetype-infinality
fontconfig-infinality
font-manager
fprintd-pam
frei0r-plugins
fuse
gimp
git
#gparted
-gnome-packagekit*
HandBrake-gui
htop
hugin-base
inkscape
jack-audio-connection-kit
java-1.7.0-openjdk
#java-1.7.0-openjdk-plugin
jockey
jockey-kde
jockey-selinux
jockey-akmods
k3b-extras-freeworld
kamoso
kaudiocreator
kde-l10n-*
kdeartwork
kdeartwork-wallpapers
kdebase-workspace-ksplash-themes
-kdegames
kdegames-minimal
kdenlive
#kde-partitionmanager #broken deps atm
kde-plasma-daisy
kde-plasma-yawp
kde-settings
kde-settings-pulseaudio
kde-settings-ksplash
kde-workspace-ksplash-themes
kde-settings-plasma
kdemultimedia-extras-freeworld
kdeplasma-addons
kipi-plugins
kde-plasma-networkmanagement-openvpn
kde-plasma-networkmanagement-pptp
kdiff3
konversation
korora-settings-kde
krename
krusader
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
libreoffice-presenter-screen
libreoffice-report-builder
libreoffice-ure
libreoffice-writer
libreoffice-xsltfilter
linphone
liveusb-creator
mtpfs
mlocate
mozilla-adblock-plus
mozilla-downthemall
mozilla-flashblock
mozilla-oxygen-kde
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
rawtherapee
samba
samba-winbind
sane-backends
screen
skanlite
-synaptic
system-config-lvm
-system-config-printer
kde-print-manager
vim
xorg-x11-apps
xscreensaver-gl-extras
xscreensaver-extras
xscreensaver-base
xorg-x11-resutils
yakuake
yumex
#yum-plugin-fastestmirror
yum-plugin-priorities
yum-plugin-security
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
kid3
kio_mtp
lame
libmpg123
Miro
PackageKit-gstreamer-plugin
pavucontrol
phonon-backend-vlc
vlc
vlc-extras
vorbis-tools
xine-lib-extras
xine-lib-extras-freeworld
xine-plugin
xine-lib-extras
xine-lib-extras-freeworld

#Flash deps - new  meta-rpm should take care of these
#pulseaudio-libs.i686
#alsa-plugins-pulseaudio.i686
#libcurl.i686
#nspluginwrapper.i686

#
#Development tools for out of tree modules
gcc
kernel-devel
dkms
time

%end

%post

echo -e "\n*****\nPOST SECTION\n*****\n"

#Build out of kernel modules (so it's not done on first boot)
echo "****BUILDING AKMODS****"
/usr/sbin/akmods --force

#Import keys
for x in fedora google-chrome virtualbox korora livna adobe rpmfusion-free-fedora-18-primary rpmfusion-nonfree-fedora-18-primary korora-18-primary ; do rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-$x ; done

#KDE - stop Klipper from starting
sed -i 's/AutoStart:true/AutoStart:false/g' /usr/share/autostart/klipper.desktop

#Start yum-updatesd
systemctl enable yum-updatesd.service

#Update locate database
/usr/bin/updatedb

#Rebuild initrd to remove Generic branding (necessary?)
#/sbin/dracut -f

#Let's run prelink
/usr/sbin/prelink -av -mR -q

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
DESKTOP="KDE"
DISPLAYMANAGER="KDE"
EOF

# make oxygen-gtk the default GTK+ 2 theme for root (see #683855, #689070)
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

#LiveCD stuff (like creating user) is done by fedora-live-base.ks
#Modify LiveCD stuff, i.e. set autologin, enable installer (this is done in /etc/rc.d/init.d/livesys)
cat >> /etc/rc.d/init.d/livesys << EOF
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
sed -i 's/#AutoLoginEnable=true/AutoLoginEnable=true/' /etc/kde/kdm/kdmrc
sed -i 's/#AutoLoginUser=fred/AutoLoginUser=liveuser/' /etc/kde/kdm/kdmrc

# set up user liveuser as default user and preselected user
sed -i 's/#PreselectUser=Default/PreselectUser=Default/' /etc/kde/kdm/kdmrc
sed -i 's/#DefaultUser=johndoe/DefaultUser=liveuser/' /etc/kde/kdm/kdmrc

# show liveinst.desktop on desktop and in menu
sed -i 's/NoDisplay=true/NoDisplay=false/g' /usr/share/applications/liveinst.desktop
sed -i 's/Icon=liveinst/Icon=\/usr\/share\/icons\/Fedora\/scalable\/apps\/anaconda.svg/g' /usr/share/applications/liveinst.desktop

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
interval=0
APPER_EOF

# Disable kres-migrator
cat > /home/liveuser/.kde/share/config/kres-migratorrc << KRES_EOF
[Migration]
Enabled=false
KRES_EOF

cat > /usr/share/kde-settings/kde-profile/default/share/config/kres-migratorrc << KRES_EOF
[Migration]
Enabled=false
KRES_EOF

# Disable nepomuk
cat > /home/liveuser/.kde/share/config/nepomukserverrc << NEPOMUK_EOF
[Basic Settings]
Start Nepomuk=false

[Service-nepomukstrigiservice]
autostart=false
NEPOMUK_EOF

cat > /usr/share/kde-settings/kde-profile/default/share/config/nepomukserverrc << NEPOMUK_EOF
[Basic Settings]
Start Nepomuk=false

[Service-nepomukstrigiservice]
autostart=false
NEPOMUK_EOF

# don't use prelink on a running KDE live image
#sed -i 's/PRELINKING=yes/PRELINKING=no/' /etc/sysconfig/prelink #this doesn't stop prelink, in fact it forces it to run to undo prelinking (see /etc/sysconfig/prelink)
mv /usr/sbin/prelink /usr/sbin/prelink-disabled
rm /etc/cron.daily/prelink

#un-mute sound card (fixes some issues reported)
amixer set Master 85% unmute 2>/dev/null
amixer set PCM 85% unmute 2>/dev/null
pactl set-sink-mute 0 0
pactl set-sink-volume 0 50000


#Disable screensaver on live system
mkdir -p /home/liveuser/.kde/share/config
cat > /home/liveuser/.kde/share/config/kscreensaverrc << SCREEN_EOF
[ScreenSaver]
Enabled=false
Lock=false
LockGrace=60000
PlasmaEnabled=false
Timeout=60
SCREEN_EOF

#Disable screen lock
cat > /home/liveuser/.kde/share/config/powerdevilrc << LOCK_EOF
[General]
configLockScreen=false
LOCK_EOF

#set permissions
chown -Rf liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser/

# small hack to enable plasma-netbook workspace on boot
if strstr "\`cat /proc/cmdline\`" netbook ; then
   mv /usr/share/autostart/plasma-desktop.desktop /usr/share/autostart/plasma-netbook.desktop
   sed -i 's/desktop/netbook/g' /usr/share/autostart/plasma-netbook.desktop
fi

#disable yumupdatesd on live CD
#service yum-updatesd stop
systemctl stop yum-updatesd.service

#disable jockey from autostarting in live CD
rm /etc/xdg/autostart/jockey*

# Turn off PackageKit-command-not-found in live CD
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
        sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

# Turn on liveinst file
sed -i s/NoDisplay=true/NoDisplay=false/g /usr/local/share/applications/liveinst.desktop

EOF

%end
