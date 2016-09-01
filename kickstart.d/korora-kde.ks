%include fedora-live-kde.ks
%include korora-base.ks
%include korora-common-packages.ks

services --enabled=sddm --disabled=kdm

#
# PACKAGES
#

%packages

# KORORA KDE CONFIGURATION
#korora-settings-kde #k25
#korora-kde-theme #k25
#korora-kdm-theme #k25
korora-backgrounds-kde
korora-backgrounds-extras-kde

# REMOVED FROM DEFAULTS
-kdiff3
-konqueror
-@kde-education
-@kde-office
okular
-dragon
-gparted
-gnome-disk-utility

-NetworkManager*-gnome
-desktop-backgrounds-basic
-f22-backgrounds-kde
-f22-kde-theme
-kdegames
-kde-l10n* #kde-l10n-* - CONFLICTS - plasma-desktop - f22
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
-font-manager
hugin-base
k3b-extras-freeworld
kalarm
kamoso
kaudiocreator
#kde-plasma-daisy - N/A - f22
#kde-plasma-yawp - N/A - f22
kde-connect
kde-gtk-config
kde-print-manager
kde-settings
#kde-settings-ksplash
kde-settings-plasma
kde-settings-pulseaudio
#kde-workspace-ksplash-themes - N/A - f22
#kdeartwork - N/A - f22
#kdeartwork-wallpapers - N/A - f22
#kdebase-workspace-ksplash-themes - N/A - f22
kdegames-minimal
#kdemultimedia-extras-freeworld #k24
kdenlive #k24
kdeplasma-addons
kdiff3
-kdm
kid3
kio-ftps
kio_mtp
kf5-kipi-plugins
kjots
konversation
krdc
krename
krusader
ksuperkey
ktimetracker
ktorrent
libmpg123
libreoffice-kde
linphone
mariadb-embedded
mariadb-libs
mariadb-server
okular
#phonon-backend-vlc #k24 #k24
#phonon-qt5-backend-vlc #k24 #k24
plasma-nm*
python3-PyQt4
-python3-lens-gtk
python3-lens-qt5
qt-recordmydesktop
qtcurve-gtk2
qtcurve-kde4
skanlite
soundkonverter
system-config-users
#xine-lib-extras
#xine-lib-extras-freeworld
yakuake

%end

%post

echo -e "\n*****\nPOST SECTION\n*****\n"

systemctl enable sddm.service

# enable ksuperkey
cp /usr/share/applications/ksuperkey.desktop /etc/xdg/autostart/

# add initscript
cat >> /etc/rc.d/init.d/livesys << EOF

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
FavoriteURLs=/usr/share/applications/systemsettings.desktop,/usr/share/applications/firefox.desktop,/usr/share/applications/org.kde.dolphin.desktop,/usr/share/applications/org.kde.konsole.desktop,/usr/share/applications/liveinst.desktop
MENU_EOF

# KP - disable screenlock
cat > /home/liveuser/.config/kscreenlockerrc << SCREEN_EOF
[$Version]
update_info=kscreenlocker.upd:0.1-autolock

[Daemon]
Autolock=false

[Greeter]
Theme=org.kde.breeze.desktop

SCREEN_EOF

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF

%end
