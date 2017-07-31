%include fedora-live-xfce.ks
%include korora-base.ks
%include korora-common-packages.ks

#
# PACKAGES
#

%packages

# KORORA GNOME CONFIGURATION
korora-settings-xfce
korora-backgrounds-xfce
korora-backgrounds-extras-xfce


-PackageKit*                # we switched to yumex-dnf, so we don't need this
-yumex
yumex-dnf
-abiword
-abrt*
-audacious-plugins-amidi
-brasero
-brasero-nautilus
-claws-mail*
-dconf-editor
-deluge
-fedora-icon-theme
-geany
-gnome-abrt
-gnumeric
-im-chooser
-leafpad
-libreoffice-base
-mencoder
-midori
-mplayer
-parole
-pragha
-realmd                     # only seems to be used in GNOME
#-ristretto
-smartmontools
-thunderbird
-totem*
transmission
-xfdashboard
-xpdf
-xterm
@firefox
@libreoffice
@networkmanager-submodules
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
audacious
audacious-plugins*
blueman
brltty
catfish
-darktable
dconf-editor
#egtk-gtk2-theme
#egtk-gtk3-theme
ekiga
elementary-xfce-icon-theme
evince
f21-backgrounds-extras-xfce
fbreader-gtk
gconf-editor
gnome-disk-utility
gnome-keyring-pam
gpgme
gtk-murrine-engine
gtk-recordmydesktop
gtk-unico-engine
gvfs-mtp
gvfs-smb
#gwibber # not available at the moment
hardlink
iok
libmatroska
libmpg123
libproxy-networkmanager
libsane-hpaio
liferea
lightdm-gtk-greeter-settings
lirc
mousepad
mtools
ncftp
network-manager-applet
gst-transcoder
pitivi
pcsc-lite
pcsc-lite-ccid
#pharlap #no longer useful
pidgin
pidgin-guifications
pidgin-musictracker
pidgin-otr
pidgin-privacy-please
pidgin-sipe
pulseaudio-module-bluetooth
#purple-microblog - N/A - f22
python3-lens-gtk
-python3-lens-qt
shotwell
simple-mtpfs
simple-scan
soundconverter
strongswan
system-config-language
system-config-users
#system-config-date - f26
system-config-printer-applet
thunderbird
tumbler-extras
webkitgtk4
wget
x264
xfce4-volumed
xfce4-whiskermenu-plugin
xfpanel-switch
xfsprogs
xscreensaver-base
xscreensaver-extras-base
xscreensaver-gl-base
xscreensaver-gl-extras
xvidcore
%end

%post

echo -e "\n*****\nPOST SECTION\n*****\n"

# KP - customise gtk-greeter
cat > /etc/lightdm/lightdm-gtk-greeter.conf << EOF

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
#font-name=Sans Bold 9
position = 20%,center 50%,center
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

# KP - re'sync the /etc/skel settings for xfce and 
rsync -Pa /etc/skel/.config/xfce4 /home/liveuser/.config

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/
EOF

%end
