%include fedora-live-cinnamon.ks
%include korora-base.ks
%include korora-common-packages.ks


%packages

# KORORA CINNAMON (GNOME) CONFIGURATION
korora-settings-cinnamon
korora-settings-gnome
korora-backgrounds-gnome
korora-backgrounds-extras-gnome

-adwaita-nemo
-alacarte
-control-center
-deja-dup
-deluge
-evolution*
-gnome-mplayer
-gnome-mplayer-nautilus
-im-chooser
-mencoder
-mplayer
-smartmontools
-totem*
transmission
NetworkManager-adsl
NetworkManager-bluetooth
NetworkManager-iodine
NetworkManager-l2tp
NetworkManager-openconnect
NetworkManager-openswan
NetworkManager-openvpn
NetworkManager-pptp
NetworkManager-ssh
NetworkManager-vpnc
NetworkManager-wifi
NetworkManager-wwan
PackageKit-gtk3-module
arc-theme
argyllcms
blueman
brasero
brltty
darktable
dconf-editor
ekiga
-empathy
evince
fbreader-gtk
font-manager
gconf-editor
gnome-disk-utility
gnome-packagekit
gnote
gpgme
gtk-murrine-engine
gtk-recordmydesktop
gtk-unico-engine
gvfs-*
#gwibber # not in f23 yet
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
ncftp
nemo
nemo-extensions
nemo-fileroller
network-manager-applet
gst-transcoder
pitivi
-parole
pcsc-lite
pcsc-lite-ccid
#pharlap #no longer useful
plank
arc-theme-plank
pulseaudio-module-bluetooth
python3-lens-gtk
-python3-lens-qt
rhythmbox
shotwell
simple-scan
sound-juicer
soundconverter
strongswan
system-config-printer
thunderbird
#transcode #k24
webkitgtk4
wget
x264
xfsprogs
xvidcore
-yumex
yumex-dnf

%end

%post

echo -e "\n*****\nPOST SECTION\n*****\n"

cat > /etc/lightdm/lightdm-gtk-greeter.conf << EOF
#
# background = Background file to use, either an image path or a color (e.g. #772953)
# theme-name = GTK+ theme to use
# icon-theme-name = Icon theme to use
# font-name = Font to use
# xft-antialias = Whether to antialias Xft fonts (true or false)
# xft-dpi = Resolution for Xft in dots per inch (e.g. 96)
# xft-hintstyle = What degree of hinting to use (none, slight, medium, or hintfull)
# xft-rgba = Type of subpixel antialiasing (none, rgb, bgr, vrgb or vbgr)
# show-indicators = semi-colon ";" separated list of allowed indicator modules. Built-in indicators include "~a11y", "~language", "~session", "~power". Unity indicators can be represented by short name (e.g. "sound", "power"), service file name, or absolute path
# show-clock (true or false)
# clock-format = strftime-format string, e.g. %H:%M
# keyboard = command to launch on-screen keyboard
# position = main window position: x y
# default-user-image = Image used as default user icon, path or #icon-name
# screensaver-timeout = Timeout (in seconds) until the screen blanks when the greeter is called as lockscreen
# 
[greeter]
background=/usr/share/backgrounds/korora/default/standard/korora.png
default-user-image=/usr/share/pixmaps/fedora-logo-small.png
theme-name=Arc-Dark
icon-theme-name=Numix-Circle
position = 20%,center 50%,center

#font-name=Sans Bold 9
#xft-antialias=
#xft-dpi=
#xft-hintstyle=
#xft-rgba=
#show-indicators=
#show-clock=
#clock-format=
#keyboard=
#position=
#screensaver-timeout=

EOF

cat >> /etc/rc.d/init.d/livesys << EOF

# make the installer show up
cat >> /usr/share/glib-2.0/schemas/org.korora.gschema.override << FOE

[org.cinnamon]
favorite-apps=['cinnamon-settings.desktop', 'firefox.desktop', 'mozilla-thunderbird.desktop', 'vlc.desktop', 'shotwell.desktop', 'libreoffice-writer.desktop', 'nemo.desktop', 'gpk-application.desktop', 'anaconda.desktop']
FOE

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF

%end
