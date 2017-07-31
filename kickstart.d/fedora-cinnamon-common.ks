# fedora-cinnamon-common.ks
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

# mp3 support
gstreamer1-plugins-ugly-free

# extra backgrounds
desktop-backgrounds-basic
f26-backgrounds-extras-gnome

%end
