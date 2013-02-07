# Kickstart file for Korora Remix (GNOME) x86_64
# To use this for 32bit build, :4,$s/x86_64/i386/g
# and build with 'setarch i686 livecd-creator ...'

#
# KP:DESCRIPTION:START
#
# var KP_RELEASE_META_LABEL=gnome
#
#
# KP:DESCRIPTION:END
#

%include %%KP_KICKSTART_DIR%%/base.ks

#
# PACKAGES
#

%packages
@cinnamon-desktop
@firefox
@gnome-desktop
@gnome-games
#@mate-desktop-environment
@libreoffice

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# (RE)BRANDING
korora-backgrounds-gnome
korora-backgrounds-extras-gnome

elementary-gtk
elementary-icon-theme

#
# EXTRA PACKAGES
akmods
-alacarte
argyllcms
bash-completion
beesu
#bootconf-gui
brltty
btrfs-progs
chrony
control-center
cups-pdf
dconf-editor
eekboard
ekiga
empathy
evince
evolution
evolution-mapi
expect
firefox
*firmware*
font-manager
fprintd-pam
fuse
libXft-infinality
freetype-infinality
fontconfig-infinality
gconf-editor
gimp
git
gnome-disk-utility
gnome-games*
gnome-lirc-properties
gnome-packagekit
-gnome-shell-extension-gpaste
-gnome-shell-extension-pidgin
#gnome-shell-extension-apps-menu
#gnome-shell-extension-auto-move-windows
gnome-shell-extension-user-theme
#gnome-shell-extension-theme-selector
gnome-shell-extension-workspacesmenu
gnome-shell-extension-alternative-status-menu
gnome-shell-extension-dock
gnome-shell-extension-drive-menu
gnome-shell-extension-places-menu
-gnome-shell-extension-native-window-placement
gnome-shell-extension-presentation-mode
gnome-shell-extension-xrandr-indicator
gnome-shell-extension-weather
gnome-shell-theme-*
gnome-system-log
gnome-tweak-tool
gnote
gloobus-preview

gparted
gpgme
gtk-murrine-engine
gtk-unico-engine
gvfs-obexftp
gwibber
hardlink
htop
-ibus-pinyin-db-open-phrase
ibus-pinyin-db-android
inkscape
iok
jack-audio-connection-kit
java-1.7.0-openjdk
#java-1.7.0-openjdk-plugin
jockey
jockey-gtk
jockey-selinux
jockey-akmods
korora-settings-gnome
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
libreoffice-presenter-screen
libreoffice-report-builder
libreoffice-ure
libreoffice-writer
libreoffice-xsltfilter
libimobiledevice
libsane-hpaio
lirc
lirc-remotes
liveusb-creator
mtpfs
mlocate
mozilla-adblock-plus
mozilla-downthemall
mozilla-flashblock
mozilla-xclear
mtools
nautilus-actions
nautilus-extensions
nautilus-image-converter
nautilus-open-terminal
#nautilus-pastebin
#nautilus-search-tool
nautilus-sendto
nautilus-sound-converter
ncftp
#NetworkManager-gnome
network-manager-applet
NetworkManager-l2tp
NetworkManager-openconnect
NetworkManager-openswan
NetworkManager-openvpn
NetworkManager-pptp
NetworkManager-vpnc
NetworkManager-wimax
strongswan-NetworkManager
libproxy-networkmanager
-ntp
p7zip
p7zip-plugins
PackageKit-browser-plugin
PackageKit-command-not-found
PackageKit-gtk3-module
pcsc-lite
pcsc-lite-ccid
#pidgin
#pidgin-rhythmbox
planner
polkit-desktop-policy
prelink
pybluez
samba
samba-winbind
sane-backends
screen
shotwell
simple-scan
-smartmontools
#synaptic
system-config-lvm
system-config-printer
#tilda
-transmission-gtk
deluge
vim
#vinagre
#vino
#wammu
wget
xfsprogs
yumex
#yum-plugin-fastestmirror
yum-plugin-priorities
yum-plugin-security
yum-plugin-refresh-updatesd
yum-plugin-versionlock
yum-updatesd

#
# MULTIMEDIA
alsa-plugins-pulseaudio
alsa-utils
audacity-freeworld
brasero
brasero-nautilus
faac
fbreader-gtk
ffmpeg
flac
frei0r-plugins
#gecko-mediaplayer
deja-dup
-gnome-mplayer
-mplayer
-mencoder
-gnome-mplayer-nautilus
gstreamer-ffmpeg
gstreamer-plugins-bad
gstreamer-plugins-bad-free
gstreamer-plugins-bad-free-extras
gstreamer-plugins-bad-nonfree
gstreamer-plugins-good
gstreamer-plugins-ugly
HandBrake-gui
lame
libdvdcss
libdvdnav
libdvdread
libmatroska
libmpg123
#me-tv (this pulls in xine-ui)
#mencoder
Miro
#mozilla-vlc
mpg321
nautilus-sound-converter
openshot
PackageKit-browser-plugin
PackageKit-gstreamer-plugin
pavucontrol
#pitivi
policycoreutils-gui
pulseaudio-module-bluetooth
rawtherapee
rhythmbox
soundconverter
sound-juicer
transcode
vlc
vlc-extras
vorbis-tools
x264
xine-lib-extras
xine-lib-extras-freeworld
xine-plugin
xorg-x11-apps
xscreensaver-gl-extras
xscreensaver-extras
xscreensaver-base
xorg-x11-resutils
xvidcore

#Flash deps - new meta-rpm should take care of these
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
for x in fedora google-chrome virtualbox korora adobe rpmfusion-free-fedora-18-primary rpmfusion-nonfree-fedora-18-primary korora-18-primary ; do rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-$x ; done

#Start yum-updatesd
systemctl enable yum-updatesd.service

#Update locate database
/usr/bin/updatedb

#Rebuild initrd to remove Generic branding (necessary?)
#/sbin/dracut -f

#Let's run prelink
/usr/sbin/prelink -av -mR -q

#LiveCD stuff (like creating user) is done by fedora-live-base.ks
#Modify LiveCD stuff, i.e. set autologin, enable installer (this is done in /etc/rc.d/init.d/livesys)
cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.screensaver.gschema.override << FOE
[org.gnome.desktop.screensaver]
lock-enabled=false
FOE

# and hide the lock screen option
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.lockdown.gschema.override << FOE
[org.gnome.desktop.lockdown]
disable-lock-screen=true
FOE

# disable updates plugin
cat >> /usr/share/glib-2.0/schemas/org.gnome.settings-daemon.plugins.updates.gschema.override << FOE
[org.gnome.settings-daemon.plugins.updates]
active=false
FOE

# make the installer show up
if [ -f /usr/share/applications/liveinst.desktop ]; then
  # Show harddisk install in shell dash
  sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
  sed -i -e 's/Icon=liveinst/Icon=\/usr\/share\/icons\/Fedora\/scalable\/apps\/anaconda.svg/' /usr/share/applications/liveinst.desktop
  # need to move it to anaconda.desktop to make shell happy
  #cp /usr/share/applications/liveinst.desktop /usr/share/applications/anaconda.desktop
  cat >> /usr/share/glib-2.0/schemas/org.korora.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['firefox.desktop', 'evolution.desktop', 'vlc.desktop', 'shotwell.desktop', 'libreoffice-writer.desktop', 'nautilus.desktop', 'liveinst.desktop']
FOE
  cat >> /usr/share/glib-2.0/schemas/org.korora.gschema.override << FOE
[org.cinnamon]
favorite-apps=['cinnamon-settings.desktop', 'firefox.desktop', 'evolution.desktop', 'vlc.desktop', 'shotwell.desktop', 'libreoffice-writer.desktop', 'nautilus.desktop', 'liveinst.desktop']
FOE

  # Make the welcome screen show up
  if [ -f /usr/share/anaconda/gnome/fedora-welcome.desktop ]; then
    mkdir -p ~liveuser/.config/autostart
    cp /usr/share/anaconda/gnome/fedora-welcome.desktop /usr/share/applications/
    cp /usr/share/anaconda/gnome/fedora-welcome.desktop ~liveuser/.config/autostart/
    chown -R liveuser:liveuser /home/liveuser/.config/
  fi
fi

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

#Set up autologin
sed -i '/^\[daemon\]/a AutomaticLoginEnable=true\nAutomaticLogin=liveuser' /etc/gdm/custom.conf

# Turn off PackageKit-command-not-found in live CD
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

# don't use prelink on a running live image
#sed -i 's/PRELINKING=yes/PRELINKING=no/' /etc/sysconfig/prelink # actually this forces prelink to run to undo prelinking (see /etc/sysconfig/prelink)
mv /usr/sbin/prelink /usr/sbin/prelink-disabled
rm /etc/cron.daily/prelink

#un-mute sound card (fixes some issues reported)
amixer set Master 85% unmute 2>/dev/null
amixer set PCM 85% unmute 2>/dev/null
pactl set-sink-mute 0 0
pactl set-sink-volume 0 50000

#chmod a+x /home/liveuser/Desktop/liveinst.desktop
chmod +x /usr/share/applications/liveinst.desktop
chown -Rf liveuser:liveuser /home/liveuser/Desktop
restorecon -R /home/liveuser/

#Turn off screensaver in live mode
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /apps/gnome-screensaver/idle_activation_enabled false

#disable yumupdatesd on live CD
systemctl stop yum-updatesd.service

#disable jockey from autostarting in live CD
rm /etc/xdg/autostart/jockey*

glib-compile-schemas /usr/share/glib-2.0/schemas

EOF

%end

