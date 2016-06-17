# fedora-cinnamon-packages.ks
#
# Description:
# - Fedora package set for the Cinnamon Desktop Environment
#
# Maintainer(s):
# - Dan Book <grinnz@grinnz.com>

%packages

@networkmanager-submodules
@cinnamon-desktop
@libreoffice

# internet and multimedia
pidgin
hexchat
transmission
parole

# make sure we have a graphical installer
yumex-dnf

# extra backgrounds
desktop-backgrounds-basic
f24-backgrounds-extras-gnome

# save some space
-fedora-icon-theme
-PackageKit*                # we switched to yumex, so we don't need this

%end
