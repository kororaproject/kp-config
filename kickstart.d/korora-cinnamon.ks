%include fedora-live-cinnamon.ks
%include korora-base.ks

#repo --name="Cinnamon" --baseurl=http://repos.fedorapeople.org/repos/leigh123linux/Cinnamon/fedora-%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000

#
# PACKAGES
#

%packages
# (RE)BRANDING - KP
korora-backgrounds-gnome
#korora-backgrounds-extras-gnome

#
# EXTRA PACKAGES
-adwaita-nemo
akmods
-alacarte
argyllcms
bash-completion
beesu
blueman
#bootconf-gui
brltty
btrfs-progs
chrony
-control-center
#cups-pdf
dconf-editor
eekboard
ekiga
empathy
evince
-evolution*
expect
firefox
*firmware*
font-manager
fprintd-pam
fuse
#libXft-infinality
#freetype-infinality
#fontconfig-infinality
gconf-editor
gimp
git
#gnome-classic-session
gnome-disk-utility
#gnome-games* - N/A - f19
#gnome-lirc-properties - N/A - f19
gnome-packagekit
#-gnome-shell-extension-gpaste
#-gnome-shell-extension-pidgin
##gnome-shell-extension-apps-menu
##gnome-shell-extension-auto-move-windows
#gnome-shell-extension-user-theme
##gnome-shell-extension-theme-selector
#gnome-shell-extension-workspacesmenu
#gnome-shell-extension-alternative-status-menu
##gnome-shell-extension-dock - N/A - f19
#gnome-shell-extension-drive-menu
#gnome-shell-extension-places-menu
#-gnome-shell-extension-native-window-placement
#gnome-shell-extension-presentation-mode
#gnome-shell-extension-xrandr-indicator
#gnome-shell-extension-weather
#gnome-shell-theme-*
#gnome-system-log
#gnome-tweak-tool
gnote
gloobus-preview

gparted
gpgme
gtk-recordmydesktop
gtk-murrine-engine
gtk-unico-engine
gvfs-*
gwibber
hardlink
htop
#-ibus-pinyin-db-open-phrase - N/A - f19
#ibus-pinyin-db-android - N/A - f19
inkscape
iok
jack-audio-connection-kit
java-1.8.0-openjdk
#java-1.7.0-openjdk-plugin
#jockey
#jockey-gtk
#jockey-selinux
#jockey-akmods
pharlap
webkitgtk4
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
liferea
lirc
lirc-remotes
liveusb-creator
mlocate
mozilla-adblock-plus
mozilla-downthemall
mozilla-flashblock
mozilla-xclear
mtools
#nautilus-actions
#nautilus-extensions
#nautilus-image-converter
#nautilus-open-terminal
#nautilus-pastebin
#nautilus-search-tool
#nautilus-sendto
#nautilus-sound-converter
ncftp
network-manager-applet
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
strongswan
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
system-config-printer
-im-chooser
#tilda
-totem*
-transmission-gtk
thunderbird
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
#brasero-nautilus
faac
fbreader-gtk
ffmpeg
flac
frei0r-plugins
#gecko-mediaplayer
-deja-dup
-gnome-mplayer
-mplayer
-mencoder
-gnome-mplayer-nautilus
gstreamer1-libav
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
lame
libdvdcss
libdvdnav
libdvdread
libmatroska
libmpg123
#me-tv (this pulls in xine-ui)
#mencoder
#miro
#mozilla-vlc
#mpg321
#nautilus-sound-converter
nemo
#nemo-open-terminal
nemo-extensions
nemo-fileroller
openshot
PackageKit-browser-plugin
PackageKit-gstreamer-plugin
pavucontrol
#pitivi
policycoreutils-gui
pulseaudio-module-bluetooth
#rawtherapee
darktable
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
default-user-image=/usr/share/icons/hicolor/64x64/apps/korora-icon-generic.png
#theme-name=Greybird
icon-theme-name=korora
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
# KP - build out of kernel modules (so it's not done on first boot)
echo -e "\n***\nBUILDING AKMODS\n***"
/usr/sbin/akmods --force

# KP - start yum-updatesd
systemctl enable yum-updatesd.service

# KP - update locate database
/usr/bin/updatedb

# KP - let's run prelink (makes things faster)
echo -e "***\nPRELINKING\n****"
/usr/sbin/prelink -av -mR -q

%end
