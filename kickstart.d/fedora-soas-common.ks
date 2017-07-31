# fedora-livecd-soas.ks
#
# Description:
# - A Sugar environment that you can carry in your pocket
#
# Maintainers:
# - Peter Robinson <pbrobinson AT gmail DOT com>

firewall --enabled --service=mdns,presence

%packages
-@fonts
-@dial-up
-@multimedia
-@printing
-foomatic
-@gnome-desktop 
-yp-tools
-ypbind
-rdate
-rdist
-icedtea-web
-firefox
-glx-utils
-nmap-ncat
-PackageKit
-eekboard-libs
-open-vm-tools*
-gfs2-utils
-abrt-cli
-ibus*
-hyperv-daemons
-webkitgtk4-plugin-process-gtk2
webkitgtk3

# Add some extra fonts
dejavu-sans-fonts
dejavu-sans-mono-fonts
madan-fonts
aajohan-comfortaa-fonts
sil-abyssinica-fonts
vlgothic-fonts

# == Core Sugar Platform ==
@sugar-desktop
-sugar-ruler
sugar-cp-updater
lightdm
lightdm-gtk

# Write breaks unless we do this (we don't need it anyway)
# enable for testing in the F17 dev cycle
@input-methods

# Needed for wifi, bluetooth and WWAN connection support
@networkmanager-submodules

# == Platform Components ==
# from http://wiki.sugarlabs.org/go/0.94/Platform_Components
alsa-plugins-pulseaudio
alsa-utils
gstreamer1-plugins-base
gstreamer1-plugins-good
gstreamer1-plugins-bad-free
gstreamer-plugins-espeak
pulseaudio
pulseaudio-utils

# explicitly remove openbox and hopefully deal with what firstboot wants
-openbox

# remove deps that come from god knows where
-sane-backends
-sane-backends-drivers-scanners

# Usefulness for DSL connections as per:
# http://bugs.sugarlabs.org/ticket/1951
rp-pppoe

# Get the Sugar boot screen
-plymouth-system-theme
-plymouth-theme-charge
sugar-logos

%end

%post

# Rebuild initrd for Sugar boot screen
KERNEL_VERSION=$(rpm -q kernel --qf '%{version}-%{release}.%{arch}\n')
/usr/sbin/plymouth-set-default-theme sugar
/sbin/dracut -f /boot/initramfs-$KERNEL_VERSION.img $KERNEL_VERSION

# Note that running rpm recreates the rpm db files which aren't needed or wanted
rm -f /var/lib/rpm/__db*

# Get proper release naming in the control panel
cat >> /boot/olpc_build << EOF
Sugar on a Stick
EOF
cat /etc/fedora-release >> /boot/olpc_build

# Add our activities to the favorites
cat > /usr/share/sugar/data/activities.defaults << EOF
org.laptop.WebActivity
org.laptop.HelpActivity
org.laptop.Chat
org.laptop.sugar.ReadActivity
org.laptop.sugar.GetBooksActivity
org.laptop.AbiWordActivity
org.laptop.TurtleArtActivity
org.laptop.Calculate
org.laptop.Clock
org.laptop.ImageViewerActivity
org.laptop.Memorize
org.laptop.physics
org.laptop.Pippy
org.laptop.RecordActivity
org.laptop.Oficina
org.laptop.StopWatchActivity
org.laptop.community.Finance
org.laptop.community.TypingTurtle
org.laptop.sugar.Jukebox
org.laptop.Words
org.eq.FotoToon
org.gnome.Labyrinth
com.laptop.Ruler
org.sugarlabs.AbacusActivity
org.sugarlabs.IRC
org.sugarlabs.InfoSlicer
org.sugarlabs.PortfolioActivity
org.sugarlabs.StoryActivity
org.sugarlabs.VisualMatchActivity
com.garycmartin.Moon
mulawa.Countries
tv.alterna.Clock
vu.lux.olpc.Maze
vu.lux.olpc.Speak
EOF

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/sugar
DISPLAYMANAGER=/usr/sbin/lightdm
EOF

# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf

# Don't use the default system user (in SoaS liveuser) as nick name
# Disable the logout menu item in Sugar
# Enable Sugar power management
cat >/usr/share/glib-2.0/schemas/sugar.soas.gschema.override <<EOF
[org.sugarlabs.user]
default-nick='disabled'

[org.sugarlabs]
show-logout=false

[org.sugarlabs.power]
automatic=true
EOF
/usr/bin/glib-compile-schemas /usr/share/glib-2.0/schemas/sugar.soas.gschema.override

%end
