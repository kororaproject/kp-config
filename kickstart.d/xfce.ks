# Kickstart file for Korora Remix (Xfce) x86_64
# To use this for 32bit build, :4,$s/x86_64/i386/g
# and build with 'setarch i686 livecd-creator ...'

#
# KP:DESCRIPTION:START
#
# var KP_RELEASE_META_LABEL=xfce
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
@libreoffice
@xfce-desktop
@xfce-apps
@xfce-extra-plugins
@xfce-media
@networkmanager-submodules
#@xfce-office
-xfdashboard


# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# (RE)BRANDING - KP
korora-backgrounds-xfce
f21-backgrounds-extras-xfce
-fedora-icon-theme

korora-settings-xfce

# unlock default keyring. FIXME: Should probably be done in comps
gnome-keyring-pam

egtk-gtk2-theme
egtk-gtk3-theme
elementary-xfce-icon-theme

-realmd                     # only seems to be used in GNOME
-PackageKit*                # we switched to yumex, so we don't need this

#
# EXTRA PACKAGES
-abrt*
-gnome-abrt
-dconf-editor
akmods
alacarte
argyllcms
bash-completion
beesu
#bootconf-gui
brltty
btrfs-progs
catfish
chrony
#control-center
#cups-pdf
dconf-editor
eekboard
ekiga
#empathy
evince
#evolution
#evolution-mapi
expect
firefox
*firmware*
#font-manager
fprintd-pam
fuse
#libXft-infinality
#freetype-infinality
#fontconfig-infinality
gconf-editor
-geany
gimp
git
gnome-disk-utility
#gnote
#gloobus-preview
gtk-recordmydesktop
gvfs-mtp
gwibber

gparted
gpgme
gtk-murrine-engine
gtk-unico-engine
#gvfs-*
#-gvfs-devel
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
#korora-settings-xfce
-leafpad
mousepad
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
owncloud
p7zip
p7zip-plugins
pidgin
pidgin-otr
pidgin-privacy-please
#pidgin-rhythmbox
pidgin-sipe
pidgin-musictracker
pidgin-guifications
purple-microblog
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
simple-mtpfs
simple-scan
-smartmontools
#synaptic
#system-config-lvm  - N/A - f19
system-config-users
# We use gnome-control-center's printer and input sources panels instead
#-system-config-printer
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
-xpdf
-xterm
yumex
#yum-plugin-fastestmirror
yum-plugin-priorities
#yum-plugin-security
yum-plugin-refresh-updatesd
yum-plugin-versionlock
yum-updatesd
xfce4-volumed
xfce4-whiskermenu-plugin
xscreensaver-base
xscreensaver-gl-base
xscreensaver-extras-base
xscreensaver-gl-extras

#
# MULTIMEDIA
-pragha
-parole
-ristretto
-midori
-claws-mail*
-deluge
alsa-plugins-pulseaudio
alsa-utils
audacious
audacious-plugins*
-audacious-plugins-amidi
-libreoffice-base
audacity-freeworld
-brasero
-brasero-nautilus
faac
fbreader-gtk
ffmpeg
flac
frei0r-plugins
#gecko-mediaplayer
-mplayer
-mencoder
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
HandBrake-gui
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
openshot
pavucontrol
#pitivi
policycoreutils-gui
pulseaudio-module-bluetooth
rawtherapee
#rhythmbox
soundconverter
#sound-juicer
thunderbird
#transcode
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
font-name=Sans Bold 9
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
#echo -e "\n***\nBUILDING AKMODS\n***"
#/usr/sbin/akmods --force

# KP - start yum-updatesd
systemctl enable yum-updatesd.service

# KP - update locate database
/usr/bin/updatedb

# KP - let's run prelink (makes things faster)
echo -e "***\nPRELINKING\n****"
/usr/sbin/prelink -av -mR -q

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startxfce4
DISPLAYMANAGER=/usr/sbin/lightdm
EOF


# KP
# live image setup is done by fedora-live-base.ks, such as:
#   - create user
# live imate modification is done in this init script, such as:
#   - set autologin,
#   - enable installer
cat >> /etc/rc.d/init.d/livesys << EOF

mkdir -p /home/liveuser/.config/xfce4

#cat > /home/liveuser/.config/xfce4/helpers.rc << FOE
#MailReader=thunderbird
#FileManager=Thunar
#WebBrowser=firefox
#FOE

# disable screensaver locking (#674410)
cat >> /home/liveuser/.xscreensaver << FOE
mode:           off
lock:           False
dpmsEnabled:    False
FOE

# deactivate xfconf-migration (#683161)
rm -f /etc/xdg/autostart/xfconf-migration-4.6.desktop || :

# deactivate xfce4-panel first-run dialog (#693569)
#mkdir -p /home/liveuser/.config/xfce4/xfconf/xfce-perchannel-xml
#cp /etc/xdg/xfce4/panel/default.xml /home/liveuser/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
#sed -i 's/^#show-language-selector=.*/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf

# set Xfce as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=xfce/' /etc/lightdm/lightdm.conf

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
chmod a+x /usr/share/applications/liveinst.desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# KP - don't let prelink run on the live image
#sed -i 's/PRELINKING=yes/PRELINKING=no/' /etc/sysconfig/prelink # actually this forces prelink to run to undo prelinking (see /etc/sysconfig/prelink)
mv /usr/sbin/prelink /usr/sbin/prelink-disabled
rm /etc/cron.daily/prelink

# KP - un-mute sound card (fixes some issues reported)
#amixer set Master 85% unmute 2>/dev/null
#amixer set PCM 85% unmute 2>/dev/null
#pactl set-sink-mute 0 0
#pactl set-sink-volume 0 50000

# KP - disable yum update service
systemctl --no-reload disable yum-updatesd.service 2> /dev/null || :
systemctl stop yum-updatesd.service 2> /dev/null || :

# KP - disable jockey from autostarting
#rm /etc/xdg/autostart/jockey*

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF

%end
