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
@firefox
@gnome-desktop
@gnome-games
@libreoffice

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# (RE)BRANDING - KP
korora-backgrounds-gnome
korora-backgrounds-extras-gnome

egtk-gtk2-theme
egtk-gtk3-theme
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
#cups-pdf
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
#libXft-infinality
freetype-infinality
fontconfig-infinality
gconf-editor
gimp
git
gnome-disk-utility
#gnome-games* - N/A - f19
#gnome-lirc-properties - N/A - f19
gnome-packagekit
-gnome-shell-extension-gpaste
-gnome-shell-extension-pidgin
#gnome-shell-extension-apps-menu
#gnome-shell-extension-auto-move-windows
gnome-shell-extension-user-theme
#gnome-shell-extension-theme-selector
gnome-shell-extension-workspacesmenu
gnome-shell-extension-alternative-status-menu
#gnome-shell-extension-dock - N/A - f19
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
#-ibus-pinyin-db-open-phrase - N/A - f19
#ibus-pinyin-db-android - N/A - f19
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
#libreoffice-presenter-screen - N/A - f19
#libreoffice-report-builder
libreoffice-ure
libreoffice-writer
libreoffice-xsltfilter
libimobiledevice
libsane-hpaio
lirc
lirc-remotes
liveusb-creator
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
#system-config-lvm  - N/A - f19
# We use gnome-control-center's printer and input sources panels instead
-system-config-printer
-im-chooser
#tilda
-totem*
-transmission-gtk
-thunderbird
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
#yum-plugin-security
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
-nemo
-nemo-open-terminal
-nemo-extensions
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
#xscreensaver-gl-extras
#xscreensaver-extras
#xscreensaver-base
xorg-x11-resutils
xvidcore

#
# development tools for out of tree modules
gcc
kernel-devel
dkms
time

%end

%post

echo -e "\n*****\nPOST SECTION\n*****\n"

# KP - build out of kernel modules (so it's not done on first boot)
echo -e "\n***\nBUILDING AKMODS\n***"
/usr/sbin/akmods --force

# KP - import keys
echo -e "\n***\nIMPORTING KEYS\n***"
for x in fedora google-chrome virtualbox korora adobe rpmfusion-free-fedora-19-primary rpmfusion-nonfree-fedora-19-primary korora-19-primary korora-19-secondary rpmfusion-free-fedora-18-primary rpmfusion-nonfree-fedora-18-primary korora-18-primary
do
  KEY="/etc/pki/rpm-gpg/RPM-GPG-KEY-${x}"
  if [ -r "${KEY}" ];
  then
    rpm --import "${KEY}"
  else
    echo "IMPORT KEY NOT FOUND: $KEY (${x})"
  fi
done

# KP - start yum-updatesd
systemctl enable yum-updatesd.service

# KP - update locate database
/usr/bin/updatedb

# KP - let's run prelink (makes things faster)
echo -e "***\nPRELINKING\n****"
/usr/sbin/prelink -av -mR -q

# KP
# live image setup is done by fedora-live-base.ks, such as:
#   - create user
# live imate modification is done in this init script, such as:
#   - set autologin,
#   - enable installer
cat >> /etc/rc.d/init.d/livesys << EOF


# disable updates plugin
cat >> /usr/share/glib-2.0/schemas/org.gnome.settings-daemon.plugins.updates.gschema.override << FOE
[org.gnome.settings-daemon.plugins.updates]
active=false
FOE

# don't run gnome-initial-setup
mkdir ~liveuser/.config
touch ~liveuser/.config/gnome-initial-setup-done

# KP - disable screensaver locking
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.screensaver.gschema.override << FOE
[org.gnome.desktop.screensaver]
lock-enabled=false
FOE

# KP - hide the lock screen option
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.lockdown.gschema.override << FOE
[org.gnome.desktop.lockdown]
disable-lock-screen=true
FOE

# KP - ensure liveuser desktop exists
mkdir ~liveuser/Desktop

# make the installer show up
if [ -f /usr/share/applications/liveinst.desktop ]; then
  # Show harddisk install in shell dash
  sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop ""
  # need to move it to anaconda.desktop to make shell happy
  mv /usr/share/applications/liveinst.desktop /usr/share/applications/anaconda.desktop

  # KP - show installer on the desktop
  cp /usr/share/applications/anaconda.desktop ~liveuser/Desktop
  chmod +x ~liveuser/Desktop/anaconda.desktop

  # KP - tweak our favourites
  cat >> /usr/share/glib-2.0/schemas/org.korora.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['firefox.desktop', 'evolution.desktop', 'vlc.desktop', 'shotwell.desktop', 'libreoffice-writer.desktop', 'nautilus.desktop', 'anaconda.desktop']
FOE
fi

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# set up auto-login
cat > /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=liveuser
FOE

# Turn off PackageKit-command-not-found while uninstalled
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

# KP - don't let prelink run on the live image
#sed -i 's/PRELINKING=yes/PRELINKING=no/' /etc/sysconfig/prelink # actually this forces prelink to run to undo prelinking (see /etc/sysconfig/prelink)
mv /usr/sbin/prelink /usr/sbin/prelink-disabled
rm /etc/cron.daily/prelink

# KP - un-mute sound card (fixes some issues reported)
amixer set Master 85% unmute 2>/dev/null
amixer set PCM 85% unmute 2>/dev/null
pactl set-sink-mute 0 0
pactl set-sink-volume 0 50000

# KP - turn off screensaver
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /apps/gnome-screensaver/idle_activation_enabled false

# KP - disable yum update service
systemctl stop yum-updatesd.service

# KP - disable jockey from autostarting
rm /etc/xdg/autostart/jockey*

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF

%end
