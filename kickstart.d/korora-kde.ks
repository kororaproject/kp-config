%include fedora-live-kde.ks
%include korora-base.ks

services --enabled=kdm --disabled=sddm

#
# PACKAGES
#

%packages

# KORORA KDE CONFIGURATION
korora-settings-kde
korora-kde-theme
korora-kdm-theme
korora-backgrounds-kde
korora-backgrounds-extras-kde

-NetworkManager*-gnome
-desktop-backgrounds-basic
-f22-backgrounds-kde
-f22-kde-theme
-kdegames
-kde-l10n-* #kde-l10n-* - CONFLICTS - plasma-desktop - f22
-calligra-l10n*
-synaptic
-system-config-printer
@firefox
@kde-apps
@kde-desktop
@kde-telepathy
@libreoffice
adwaita-gtk3-theme
amarok
apper
backintime-kde
bluedevil
calibre
choqok
darktable
digikam
dolphin-root-actions
font-manager
hugin-base
k3b-extras-freeworld
kalarm
kamoso
kaudiocreator
#kde-plasma-daisy - N/A - f22
#kde-plasma-yawp - N/A - f22
kde-print-manager
kde-settings
kde-settings-ksplash
kde-settings-plasma
kde-settings-pulseaudio
#kde-workspace-ksplash-themes - N/A - f22
#kdeartwork - N/A - f22
#kdeartwork-wallpapers - N/A - f22
#kdebase-workspace-ksplash-themes - N/A - f22
kdegames-minimal
kdemultimedia-extras-freeworld
kdenlive
kdeplasma-addons
kdiff3
kdm
kid3
kio-ftps
kio_mtp
kipi-plugins
kjots
konversation
krdc
krename
krusader
ktimetracker
ktorrent
libmpg123
libreoffice-kde
linphone
mariadb-embedded
mariadb-libs
mariadb-server
okular
phonon-backend-vlc
plasma-nm*
python3-PyQt4
qt-recordmydesktop
qtcurve-gtk2
qtcurve-kde4
skanlite
system-config-users
xine-lib-extras
xine-lib-extras-freeworld
yakuake

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

# add initscript
cat >> /etc/rc.d/init.d/livesys << EOF
# KP - disable yumupdatesd
systemctl --no-reload yum-updatesd.service 2> /dev/null || :
systemctl stop yum-updatesd.service 2> /dev/null || :

# KP - ensure liveuser desktop exists
mkdir ~liveuser/Desktop

# set up autologin for user liveuser
sed -i 's/#AutoLoginEnable=true/AutoLoginEnable=true/' /etc/kde/kdm/kdmrc
sed -i 's/#AutoLoginUser=fred/AutoLoginUser=liveuser/' /etc/kde/kdm/kdmrc

# set up user liveuser as default user and preselected user
sed -i 's/#PreselectUser=Default/PreselectUser=Default/' /etc/kde/kdm/kdmrc
sed -i 's/#DefaultUser=johndoe/DefaultUser=liveuser/' /etc/kde/kdm/kdmrc

# add liveinst.desktop to favorites menu
mkdir -p /home/liveuser/.config/
cat > /home/liveuser/.config/kickoffrc << MENU_EOF
[Favorites]
FavoriteURLs=/usr/share/applications/systemsettings.desktop,/usr/share/applications/firefox.desktop,/usr/share/applications/kde4/dolphin.desktop,/usr/share/applications/org.kde.konsole.desktop,/usr/share/applications/liveinst.desktop
MENU_EOF

# KP - don't use prelink on a running KDE live image
mv /usr/sbin/prelink /usr/sbin/prelink-disabled
rm /etc/cron.daily/prelink

# KP - un-mute sound card (fixes some issues reported)
#amixer set Master 85% unmute 2>/dev/null
#amixer set PCM 85% unmute 2>/dev/null
#pactl set-sink-mute 0 0
#pactl set-sink-volume 0 50000


# KP - disable screensaver
cat > /home/liveuser/.config/kscreensaverrc << SCREEN_EOF
[ScreenSaver]
Enabled=false
Lock=false
LockGrace=60000
PlasmaEnabled=false
Timeout=60
SCREEN_EOF

# KP - disable screen lock
cat > /home/liveuser/.config/powerdevilrc << LOCK_EOF
[General]
configLockScreen=false
LOCK_EOF


# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

# turn off PackageKit-command-not-found
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

EOF

%end
