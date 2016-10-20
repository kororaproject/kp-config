%packages
-PackageKit*                # we switched to yumex, so we don't need this
firefox
@mate
compiz
compiz-plugins-main
compiz-plugins-extra
compiz-manager
compizconfig-python
compiz-plugins-experimental
libcompizconfig
compiz-plugins-main
ccsm
simple-ccsm
emerald-themes
emerald
fusion-icon
@networkmanager-submodules
blueman

# some apps from mate-applications
caja-actions
mate-disk-usage-analyzer

# more backgrounds
f25-backgrounds-base
f25-backgrounds-mate
f24-backgrounds-extras-base

# system tools
system-config-printer
system-config-printer-applet
lightdm-gtk-greeter-settings

# audio video
parole
exaile
PackageKit-gstreamer-plugin

# blacklist applications which breaks mate-desktop
-audacious

# office
@libreoffice

# dsl tools
rp-pppoe

# some tools
p7zip
p7zip-plugins

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

%end
