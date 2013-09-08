# Kickstart file for Korora Remix Canvas (GNOME) x86_64
# To use this for 32bit build, :4,$s/x86_64/i386/g
# and build with 'setarch i686 livecd-creator ...'

#
# KP:DESCRIPTION:START
#
# var KP_RELEASE_META_LABEL=canvas
#
#
# KP:DESCRIPTION:END
#

%include %%KP_KICKSTART_DIR%%/canvas-base.ks
#%include %%KP_KICKSTART_DIR%%/fedora-live-minimization.ks
#%include %%KP_KICKSTART_DIR%%/fedora-livecd-desktop.ks

#
# PACKAGES
#

%packages

#
# Live CD specific stuff
@anaconda-tools
anaconda
fpaste
kernel
#kernel-modules-extra
memtest86+
nss-mdns

#
#Install 3rd party repo releases
adobe-release
google-chrome-release
google-earth-release
google-talkplugin-release
rpmfusion-free-release
rpmfusion-nonfree-release

#
# (RE)BRANDING
elementary-icon-theme
#grub2-starfield-theme
korora-extras
korora-release
korora-logos
-korora-release-notes
korora-settings-gnome
korora-welcome
#korora-videos
plymouth-theme-korora

#
# Fonts
@fonts
#dejavu-sans-fonts
#dejavu-sans-mono-fonts
#dejavu-serif-fonts
##gnu-free-mono-fonts
##gnu-free-sans-fonts
##gnu-free-serif-fonts
#liberation-mono-fonts
#liberation-sans-fonts
#liberation-serif-fonts

#
# Canvas specific packages

@base-x
@core
@critical-path-gnome
@guest-desktop-agents
@hardware-support
#@input-methods
bash-completion
bridge-utils
chrony
cups
empathy
evince
evolution
evolution-mapi
evolution-ews
firefox
font-manager
fprintd-pam
gedit
gnome-documents
gnome-initial-setup
gnome-screenshot
#gnome-shell-extension-weather
gnome-shell-extension-alternative-status-menu
gnome-shell-extension-xrandr-indicator
#gnome-shell-extension-presentation-mode
gnome-shell-extension-drive-menu
gnome-shell-extension-user-theme
gnome-shell-extension-places-menu
gnome-tweak-tool
gparted
gvfs-archive
gvfs-goa
gvfs-gphoto2
gvfs-mtp
gvfs-smb
jockey-gtk
jockey-selinux
#jockey-akmods
libproxy-networkmanager
mlocate
mozilla-adblock-plus
mozilla-downthemall
mozilla-flashblock
mozilla-xclear
net-tools
network-manager-applet
NetworkManager-l2tp
NetworkManager-openconnect
NetworkManager-openswan
NetworkManager-openvpn
NetworkManager-pptp
NetworkManager-vpnc
NetworkManager-wimax
PackageKit-browser-plugin
PackageKit-command-not-found
PackageKit-gstreamer-plugin
PackageKit-gtk3-module
PackageKit-yum-plugin
prelink
rhythmbox
shotwell
simple-scan
strongswan
system-config-printer
system-config-printer-udev
tar
totem
wget

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
