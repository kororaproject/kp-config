%include fedora-live-workstation.ks
%include korora-base.ks

#
# PACKAGES
#

%packages

-PackageKit*                # we switched to yumex, so we don't need this
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
-im-chooser
-leafpad
-libreoffice-base
-mencoder
-midori
-mplayer
-parole
-pragha
-realmd                     # only seems to be used in GNOME
-ristretto
-smartmontools
-thunderbird
-totem*
-transmission-gtk
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
argyllcms
audacious
audacious-plugins*
blueman
brltty
catfish
dconf-editor
deluge
egtk-gtk2-theme
egtk-gtk3-theme
ekiga
elementary-xfce-icon-theme
evince
f21-backgrounds-extras-xfce
fbreader-gtk
ffmpeg
gconf-editor
gnome-disk-utility
gnome-keyring-pam
gpgme
gtk-murrine-engine
gtk-recordmydesktop
gtk-unico-engine
gvfs-mtp
gwibber
hardlink
iok
korora-backgrounds-xfce
korora-settings-xfce
libmatroska
libmpg123
libproxy-networkmanager
libsane-hpaio
liferea
lirc
mousepad
mtools
ncftp
network-manager-applet
openshot
owncloud
pcsc-lite
pcsc-lite-ccid
pharlap
pidgin
pidgin-guifications
pidgin-musictracker
pidgin-otr
pidgin-privacy-please
pidgin-sipe
pulseaudio-module-bluetooth
#purple-microblog - N/A - f22
rawtherapee
shotwell
simple-mtpfs
simple-scan
soundconverter
strongswan
system-config-users
thunderbird
webkitgtk4
wget
x264
xfce4-volumed
xfce4-whiskermenu-plugin
xfsprogs
xscreensaver-base
xscreensaver-extras-base
xscreensaver-gl-base
xscreensaver-gl-extras
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
