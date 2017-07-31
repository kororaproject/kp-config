%include fedora-live-workstation.ks
%include korora-base.ks
%include korora-common-packages.ks


%packages

# KORORA GNOME CONFIGURATION
korora-settings-gnome
korora-backgrounds-gnome
korora-backgrounds-extras-gnome

arc-theme # new theme for k24
mozilla-arc-theme # new theme for k24
gnome-terminal #k24 not sure why this wasn't included already

#nautilus-dropbox
deja-dup-nautilus
seahorse-nautilus
owncloud-client-nautilus
gnome-terminal-nautilus
-nautilus-pastebin
nautilus-image-converter
nautilus-search-tool

-alacarte
-deluge
-gnome-mplayer
-gnome-mplayer-nautilus
-gnome-shell-extension-gpaste
-gnome-shell-extension-native-window-placement
-gnome-shell-extension-pidgin
-im-chooser
-mencoder
-mplayer
-nemo
-nemo-extensions
-smartmontools
-system-config-printer
-thunderbird
-totem
-xscreensaver-base
-xscreensaver-extras
-xscreensaver-gl-extras
NetworkManager-adsl
NetworkManager-bluetooth
NetworkManager-iodine-gnome
NetworkManager-l2tp
NetworkManager-openconnect
NetworkManager-openswan-gnome
NetworkManager-openvpn-gnome
NetworkManager-pptp-gnome
NetworkManager-ssh-gnome
NetworkManager-vpnc-gnome
NetworkManager-wifi
NetworkManager-wwan
PackageKit-gtk3-module
argyllcms
brasero
brasero-nautilus
brltty
control-center
darktable
dconf-editor
deja-dup
transmission
ekiga
empathy
evince
evolution
evolution-mapi
fbreader-gtk
font-manager
gconf-editor
gnome-classic-session
gnome-disk-utility
gnome-logs
gnome-packagekit
gnome-shell-extension-dash-to-dock
gnome-shell-extension-drive-menu
gnome-shell-extension-places-menu
gnome-shell-extension-pomodoro
gnome-shell-extension-user-theme
gnome-shell-extension-openweather
gnome-shell-theme-*
gnome-system-log
gnome-tweak-tool
gnote
gpgme
gtk-murrine-engine
gtk-recordmydesktop
gtk-unico-engine
gvfs-*
hardlink
iok
libmatroska
libmpg123
libproxy-networkmanager
libreoffice-gtk3
libsane-hpaio
liferea
lirc
mtools
nautilus-extensions
nautilus-image-converter
nautilus-sendto
ncftp
network-manager-applet
gst-transcoder
pitivi
pcsc-lite
pcsc-lite-ccid
pulseaudio-module-bluetooth
python3-lens-gtk
-python3-lens-qt
rhythmbox
shotwell
simple-scan
sound-juicer
soundconverter
strongswan
tracker-preferences
wget
x264
xfsprogs
xvidcore

%end


%post

cat >> /etc/rc.d/init.d/livesys << EOF

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

# KP - turn off screensaver
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /apps/gnome-screensaver/idle_activation_enabled false

# KP - configure our favourite apps for live
  cat >> /usr/share/glib-2.0/schemas/org.korora.gschema.override << FOE

[org.gnome.shell]
favorite-apps=['firefox.desktop', 'evolution.desktop', 'vlc.desktop', 'shotwell.desktop', 'libreoffice-writer.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Documents.desktop', 'org.gnome.Terminal.desktop', 'anaconda.desktop']
FOE

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF

%end
