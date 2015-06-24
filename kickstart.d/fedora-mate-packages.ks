%packages
PackageKit*                # we switched to yumex, so we don't need this
-ConsoleKit                 # ConsoleKit is deprecated
-ConsoleKit-x11             # ConsoleKit is deprecated
firefox
@mate
compiz
compiz-plugins-main
compiz-plugins-extra
compiz-manager
compizconfig-python
compiz-plugins-unsupported
compiz-mate
libcompizconfig
compiz-plugins-main
ccsm
emerald-themes
emerald
fusion-icon
fusion-icon-gtk
@libreoffice
@networkmanager-submodules

# some apps from mate-applications
caja-actions
mate-disk-usage-analyzer
mate-netspeed
mate-themes-extras

# more backgrounds
f22-backgrounds-mate
f21-backgrounds-extras-base
f21-backgrounds-extras-mate

# system tools
system-config-printer
system-config-printer-applet

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

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# This one needs to be kicked out of @standard
-smartmontools
%end
