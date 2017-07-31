# Maintained by the Fedora Python SIG:
# http://fedoraproject.org/wiki/SIGs/Python
# mailto:python-devel@lists.fedoraproject.org

# GNOME part of Python Classroom images

%include fedora-python-classroom-common.ks

%packages
ninja-ide
emacs
python3-matplotlib-tk
python3-pillow-tk

# Remove extra gnome-y things
-@graphical-internet
-@games
-@sound-and-video
-@multimedia
-dleyna*
-evolution*
-gnome-boxes
-gnome-calendar
-gnome-clocks
-gnome-contacts
-gnome-disk-utility
-gnome-documents
-gnome-font-viewer
-gnome-maps
-gnome-weather
-grilo-plugins
-cheese
-totem
-totem-nautilus

# This is no longer workstation
-@workstation-product
-fedora-productimg-workstation

# Add a web browser
@firefox

# Remove office suite
-@libreoffice
-libreoffice-*
-planner

# Drop the Java plugin and Java
-icedtea-web
-java*

# No printing
-@printing
-foomatic-db-ppds
-foomatic

# Dictionaries are big
-aspell-*
-words

# Help and art can be big, too
-gnome-user-docs
-desktop-backgrounds-basic
-*backgrounds-extras

# Legacy cmdline things we don't want
-krb5-auth-dialog
-krb5-workstation
-pam_krb5
-quota
-dos2unix
-finger
-ftp
-jwhois
-mtr
-pinfo
-rsh
-nfs-utils
-ypbind
-yp-tools
-rpcbind
-acpid
-ntsysv

# Don't need this
-linux-atm

# Drop some system-config things
-system-config-language
-system-config-network
-system-config-rootpassword
-system-config-services
-policycoreutils-gui

%end


%post

#Override the favorite desktop application in Dash
sed -i "s/favorite-apps=."'*'"/favorite-apps=['firefox.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.gedit.desktop', 'anaconda.desktop']/" /etc/rc.d/init.d/livesys

%end
