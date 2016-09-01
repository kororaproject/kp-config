%include fedora-live-mate_compiz.ks
%include korora-base.ks
%include korora-common-packages.ks

#
# PACKAGES
#

%packages

# KORORA GNOME CONFIGURATION
korora-settings-gnome
korora-settings-mate
korora-backgrounds-mate
korora-backgrounds-extras-mate

-PackageKit*                # we switched to yumex-dnf, so we don't need this
-yumex
yumex-dnf
-brasero
-brasero-nautilus
-claws-mail # K21 replace with thunderbird
-exaile
-deluge
-geany
-gnome-mplayer
-gnome-mplayer-nautilus
-gvfs-devel
-im-chooser
-mencoder
-mplayer
-nautilus
-nemo
-nemo-extensions
-parole
-realmd                     # only seems to be used in GNOME
-smartmontools
-totem*
-xpdf
-xterm
@firefox
@libreoffice
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
alacarte
arc-theme
argyllcms
asunder
audacious
blueman
brltty
ccsm
compiz
compiz-bcop
compiz-manager
#compiz-mate # k25
compiz-plugins-extra
compiz-plugins-main
compiz-plugins-main
compiz-plugins-unsupported
compizconfig-python
-darktable
dconf-editor
ekiga
emerald
emerald-themes
fbreader-gtk
fusion-icon
#fusion-icon-gtk #k25
gconf-editor
gnome-disk-utility
gnote
gpgme
#greybird-gtk2-theme
#greybird-gtk3-theme
#greybird-metacity-theme
gtk-murrine-engine
gtk-recordmydesktop
gtk-unico-engine
gvfs-*
#gwibber # not in 23 yet
hardlink
iok
libcompizconfig
libmatroska
libproxy-networkmanager
libsane-hpaio
liferea
lightdm-gtk-greeter-settings
lirc
-mintmenu
mtools
ncftp
network-manager-applet
gst-transcoder
pitivi
pcsc-lite
pcsc-lite-ccid
#pharlap #no longer useful
pidgin
plank
arc-theme-plank
pulseaudio-module-bluetooth
python3-lens-gtk
-python3-lens-qt
shotwell
simple-scan
soundconverter
strongswan
system-config-language
system-config-users
thunderbird
#transcode #k24
transmission
wget
x264
xfsprogs
xvidcore
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
#screensaver-timeout=
EOF

cat >> /etc/rc.d/init.d/livesys << EOF

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/
EOF

%end
