%include fedora-live-workstation.ks
%include korora-base.ks


%packages
# (RE)BRANDING - KP
korora-backgrounds-gnome
#TODO: korora-backgrounds-extras-gnome

pharlap

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
#freetype-infinality
#fontconfig-infinality
gconf-editor
gimp
git
gnome-classic-session
gnome-disk-utility
gnome-packagekit

# Add GNOME shell extensions
gnome-shell-extension-dash-to-dock
gnome-shell-extension-drive-menu
gnome-shell-extension-places-menu
gnome-shell-extension-pomodoro
gnome-shell-extension-user-theme
gnome-shell-extension-weather
# TODO: no packages yet available in f20
#gnome-shell-extension-alternative-status-menu
#gnome-shell-extension-apps-menu
#gnome-shell-extension-auto-move-windows
#gnome-shell-extension-presentation-mode
#gnome-shell-extension-theme-selector
#gnome-shell-extension-workspacesmenu
#gnome-shell-extension-xrandr-indicator

# Remove GNOME shell extensions
-gnome-shell-extension-gpaste
-gnome-shell-extension-pidgin
-gnome-shell-extension-native-window-placement

gnome-shell-theme-*
gnome-system-log
gnome-tweak-tool
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
inkscape
iok
jack-audio-connection-kit
java-1.8.0-openjdk

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
#libreoffice-report-builder
libreoffice-ure
libreoffice-writer
libreoffice-xsltfilter
libimobiledevice
libsane-hpaio
liferea
lirc
#lirc-remotes   #FC22
liveusb-creator
mlocate
mozilla-adblock-plus
mozilla-downthemall
mozilla-flashblock
mozilla-xclear
mtools
#nautilus-actions   #FC21
nautilus-extensions
nautilus-image-converter
nautilus-open-terminal
#nautilus-pastebin
#nautilus-search-tool
nautilus-sendto
#nautilus-sound-converter   #FC21
ncftp
#NetworkManager-gnome
network-manager-applet
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
-nemo
-nemo-extensions
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
xorg-x11-resutils
xvidcore

# Remove screensaver additions
-xscreensaver-gl-extras
-xscreensaver-extras
-xscreensaver-base


#
# development tools for out of tree modules
gcc
kernel-devel
dkms
time

%end




%post


%end
