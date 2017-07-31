%packages
@firefox
@kde-apps
@kde-desktop
@kde-media
@kde-office
@kde-telepathy
@networkmanager-submodules

### The KDE-Desktop

### Browser
qupzilla

### fixes

# use kde-print-manager instead of system-config-printer
-system-config-printer
# make sure mariadb lands instead of MySQL (hopefully a temporary hack)
mariadb-embedded
mariadb-libs
mariadb-server

# minimal localization support - allows installing the kde-l10n-* packages
system-config-language
kde-l10n

# unwanted packages from @kde-desktop
# don't include these for now to fit on a cd
-desktop-backgrounds-basic
-kdeaccessibility*
#-ktorrent			# kget has also basic torrent features (~3 megs)
-digikam			# digikam has duplicate functionality with gwenview (~28 megs)
#-amarok 			# ~23 megs (mysql-embedded etc.)
-kipi-plugins			# ~8 megs + drags in Marble
#-kdeplasma-addons		# ~16 megs
#-krusader			# ~4 megs

# Additional packages that are not default in kde-* groups, but useful
k3b				# ~15 megs
#kdeartwork			# only include some parts of kdeartwork
fuse
mediawriter

# only include kdegames-minimal
-kdegames
kdegames-minimal

### space issues

# fonts (we make no bones about admitting we're english-only)
wqy-microhei-fonts			# a compact CJK font, to replace:
-naver-nanum-gothic-fonts		# Korean
-vlgothic-fonts				# Japanese
-adobe-source-han-sans-cn-fonts		# simplified Chinese
-adobe-source-han-sans-tw-fonts 	# traditional Chinese

-paratype-pt-sans-fonts	# Cyrillic (already supported by DejaVu), huge
#-stix-fonts		# mathematical symbols

# remove input methods to free space
-@input-methods
-scim*
-m17n*
-ibus*
-iok

# admin-tools
-gnome-disk-utility
# kcm_clock still lacks some features, so keep system-config-date around
#-system-config-date
# prefer kcm_systemd
-system-config-services
# prefer/use kusers
-system-config-users

## avoid serious bugs by omitting broken stuff

%end
