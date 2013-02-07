# Kickstart file for Kororaa (KDE) x86_64
# To use this for 32bit build, :4,$s/x86_64/i386/g
# and build with 'setarch i686 livecd-creator ...'


%include fedora-live-base.ks
#%include fedora-livecd-kde.ks

#version=DEVEL
install

#install system from the net, to get latest updates
url --url=http://mirror.internode.on.net/pub/fedora/linux/releases/14/Fedora/x86_64/os/

lang en_AU.UTF-8
keyboard us
network --onboot yes --device eth0 --bootproto dhcp --noipv6
timezone --utc Australia/Sydney
#rootpw  --iscrypted $6$D8V.j2ICJUxPjPEl$S.OjfjUxpIBfYKEMjSBolPPHGG1wLSIrihg75qvd1K34CUA7KfPC3fIzypVY/A4LSPs8uwG3joDXMiZ6vGaN40
selinux --enforcing
authconfig --enableshadow --passalgo=sha512 --enablefingerprint
firewall --enabled --service=ssh,mdns
xconfig --startxonboot
services --enabled=NetworkManager --disabled=abrtd,avahi-daemon,bluetooth,capi,crond,ip6tables,iscsi,iscsid,isdn,netfs,network,nfs,nfslock,pcscd,rpcbind,rpcgssd,rpcidmapd,rpcsvcgssd,sendmail,sshd

#Partitioning, for Live CD
part / --size 8192 --fstype ext4


#Partitioning, for virtual machine testing
#clearpart --all --drives=sda
#
#part /boot --fstype=ext4 --size=512
#part pv.EaGFJm-w7pp-JMFF-02sd-ynAj-3bbx-Yj8Kfz --grow --size=512
#
#volgroup system --pesize=32768 pv.EaGFJm-w7pp-JMFF-02sd-ynAj-3bbx-Yj8Kfz
#logvol / --fstype=ext4 --name=root --vgname=system --grow --size=1024 --maxsize=20480
#logvol swap --name=swap --vgname=system --grow --size=1024 --maxsize=2048
#bootloader --location=mbr --driveorder=sda --append="rhgb quiet"

#Repos
repo --name="Adobe Systems Incorporated" --baseurl=http://linuxdownload.adobe.com/linux/i386/ --cost=1000
#repo --name="ATrpms" --baseurl=http://dl.atrpms.net/f14-x86_64/atrpms/stable/ --cost=1000
repo --name="Fedora 14 - x86_64" --baseurl=http://mirror.internode.on.net/pub/fedora/linux/releases/14/Everything/x86_64/os/ --cost=1000
repo --name="Fedora 14 - x86_64 - Updates" --baseurl=http://mirror.internode.on.net/pub/fedora/linux/updates/14/x86_64/ --cost=1000
repo --name="Google Chrome" --baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64/ --cost=1000
repo --name="Kororaa" --baseurl=http://mirror.linux.org.au/pub/kororaa/releases/14/x86_64/ --cost=1000
repo --name="Ksplice Uptrack for Fedora" --baseurl=http://www.ksplice.com/yum/uptrack/fedora/14/x86_64/ --cost=1000
#repo --name="LibreOffice" --baseurl=http://kororaa.org/repos/libreoffice/14/x86_64/ --cost=1000
#repo --name="Livna" --baseurl=http://rpm.livna.org/repo/14/x86_64/ --cost=1000
repo --name="RPMFusion Free" --baseurl=http://download1.rpmfusion.org/free/fedora/releases/14/Everything/x86_64/os/ --cost=1000
repo --name="RPMFusion Free - Updates" --baseurl=http://download1.rpmfusion.org/free/fedora/updates/14/x86_64/ --cost=1000
repo --name="RPMFusion Non-Free" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/14/Everything/x86_64/os/ --cost=1000
repo --name="RPMFusion Non-Free - Updates" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/updates/14/x86_64/ --cost=1000
repo --name="VirtualBox" --baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/14/x86_64/ --cost=1000
#repo --name="Yum Rawhide" --baseurl=http://repos.fedorapeople.org/repos/james/yum-rawhide/fedora-14/x86_64/ --cost=1000

%packages
@core
@base-x
@british-support
@dial-up
#@fonts
@hardware-support
@kde-desktop

#Install 3rd party repo releases
adobe-release
ksplice-uptrack
#livna-release
rpmfusion-free-release
rpmfusion-nonfree-release

#Rebranding requirements
-fedora-logos
-fedora-release
-fedora-release-notes
kororaa-release
kororaa-logos
kororaa-release-notes

#Package for checksumming livecd on boot, installer, memtest
anaconda
isomd5sum
#liveusb-creator

#Removing from @kde-desktop
-amarok*
-desktop-backgrounds-basic
-digikam*
-k3b*
-kaffeine*
-kdeaccessibility*
-kdeartwork-screensavers
-kdeedu*
-kdegames
-kdegraphics*
#-kdemultimedia*
#-kdenetwork*
-kdepim*
-kdeplasma-addons
-kdeutils-printer-applet
-kdeutils*
-kftpgrabber
-kipi-plugins
-konq-plugins
-konversation
-ktorrent
-phonon-backend-gstreamer
-scribus
-system-config-printer-kde

#Extra packages
add-remove-extras
alsa-utils
bash-completion
beesu
choqok
firefox
git
#fprintd-pam
#gimp
#git
#Take htop out, KDE has own
#htop
#inkscape
#java-1.6.0-openjdk
#java-1.6.0-openjdk-plugin
#k3b-extras-freeworld
-kdeartwork
kde-partitionmanager
kde-settings-pulseaudio
-kdegames-minimal
#kdenlive (broken, missing libmlt)
kdeplasma-addons
#kipi-plugins
kdemultimedia
kdenetwork
kde-plasma-networkmanagement-openvpn
kde-plasma-networkmanagement-pptp
libdvdcss
#libimobiledevice
#openoffice.org-calc
#openoffice.org-draw
#openoffice.org-emailmerge
#openoffice.org-extendedPDF
#openoffice.org-graphicfilter
#openoffice.org-impress
#openoffice.org-langpack-en
#openoffice.org-math
#openoffice.org-pdfimport
#openoffice.org-presenter-screen
#openoffice.org-writer
#openoffice.org-xsltfilter
#p7zip
#p7zip-plugins
openssh-clients
#PackageKit-command-not-found
prelink
rsync
#samba
#samba-winbind
#skanlite
system-config-lvm
-system-config-printer
#system-config-printer-kde
usbutils
vim
vlc
wget
yumex
#yum-plugin-fastestmirror
#yum-plugin-security
yum-presto
yum-updatesd

#Multimedia (KDE will use Xine by default, but also suport Gstreamer)
#flac
#gstreamer-ffmpeg
#gstreamer-plugins-bad
#gstreamer-plugins-bad-free
#gstreamer-plugins-bad-free-extras
#gstreamer-plugins-bad-nonfree
#gstreamer-plugins-good
#gstreamer-plugins-ugly
#kid3
#lame
#libmpg123
#PackageKit-gstreamer-plugin
#phonon-backend-vlc
xine-lib-extras
xine-lib-extras-freeworld
#should we include a transcoder? (like converting video/music between formats)

#Development tools for out of tree modules
#gcc
#kernel-devel
#dkms
#time

#Out of kernel GPL drivers
#akmod-VirtualBox-OSE
#akmod-wl (I don't think this is GPLv2!)
#kmod-staging
mesa-dri-drivers-experimental

#Extra firmware? (what is needed above @hardware-support?)
#aic94xx-firmware
#ar9170-firmware
#atmel-firmware
#b43-openfwwf
#bfa-firmware
#crystalhd-firmware
#cx18-firmware
#fxload
#ipw2100-firmware
#ipw2200-firmware
#iscan-firmware
#isight-firmware-tools
#ivtv-firmware
#iwl1000-firmware
#iwl3945-firmware
#iwl4965-firmware
#iwl5000-firmware
#iwl5150-firmware
#iwl6000-firmware
#iwl6050-firmware
#libertas-sd8686-firmware
#libertas-usb8388-firmware
#midisport-firmware
#psb-firmware
#ql2100-firmware
#ql2200-firmware
#ql23xx-firmware
#ql2400-firmware
#ql2500-firmware
#r5u87x-firmware
#rt61pci-firmware
#rt73usb-firmware
#zd1211-firmware

%post

echo -e "\n*****\nPOST SECTION\n*****\n"

#Set resolv.conf
echo "nameserver 192.168.28.1" >> /etc/resolv.conf

#Let's get a copy of the source
git clone git://kororaa.git.sourceforge.net/gitroot/kororaa/kororaa kororaa-source

#export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

#Kororaa customisations
#Set Kororaa branding
#sed -i 's/^Generic.*/Kororaa\ 14\ (Nemo)/g' /etc/fedora-release /etc/issue /etc/issue.net
#sed -i 's/generic/kororaa/g' /etc/system-release-cpe

#Change backgrounds
#for x in normalish standard wide ; do convert -fill black -draw 'color 0,0 reset' /usr/share/backgrounds/laughlin/default/$x/laughlin.png /usr/share/backgrounds/laughlin/default/$x/laughlin.png ; done
#cp kororaa-source/artwork/fedora-logo.png /usr/share/pixmaps/fedora-logo.png
#cp kororaa-source/artwork/fedora-logo-small.png /usr/share/pixmaps/fedora-logo-small.png
#cp kororaa-source/artwork/fedora-logo.png /usr/share/pixmaps/system-logo-white.png
#cp kororaa-source/artwork/fedora-logo-sprite.svg /usr/share/pixmaps/fedora-logo-sprite.svg
#cp kororaa-source/artwork/fedora-logo-sprite.svg /usr/share/pixmaps/fedora-logo-sprite.svg
for x in normalish standard wide ; do composite -gravity SouthEast -geometry +50+50 /usr/share/pixmaps/fedora-logo-small.png /usr/share/backgrounds/laughlin/default/$x/laughlin.png /usr/share/backgrounds/laughlin/default/$x/laughlin.png ; done
#composite -gravity SouthEast -geometry +50+50 /usr/share/pixmaps/fedora-logo-small.png /usr/share/backgrounds/laughlin/default/standard/laughlin.png /usr/share/backgrounds/laughlin/default/standard/laughlin.png
#composite -gravity SouthEast -geometry +50+50 /usr/share/pixmaps/fedora-logo-small.png /usr/share/backgrounds/laughlin/default/wide/laughlin.png /usr/share/backgrounds/laughlin/default/wide/laughlin.png

#Plymouth artwork
#for x in 06 07 08 09 10 11 12 13 14 15 ; do rm -f /usr/share/plymouth/themes/charge/throbber-$x.png ; cp kororaa-source/artwork/plymouth/throbber-$x.png /usr/share/plymouth/themes/charge/throbber-$x.png ; done


#Remove Fedora KDE theme
sed -i 's/^Theme=Laughlin/Theme=Simple\nEngine=Simple/g' /usr/share/kde-settings/kde-profile/default/share/config/ksplashrc
sed -i 's/^name=Laughlin-netbook/name=oxygen/g' /usr/share/kde-settings/kde-profile/default/share/config/plasmarc
sed -i 's/^GreetString=Fedora\ 14\ (Laughlin)/GreetString=Kororaa\ 14\ (Nemo)/g' /etc/kde/kdm/kdmrc
sed -i 's/^UseTheme=true/UseTheme=false/g' /etc/kde/kdm/kdmrc
#sed -i 's/^Theme=.*/Theme=\/usr\/share\/kde4\/apps\/kdm\/themes\/oxygen-air/g' /etc/kde/kdm/kdmrc
sed -i 's/^#ColorScheme=.*/ColorScheme=Oxygen/g' /etc/kde/kdm/kdmrc
sed -i 's/^#GUIStyle=.*/GUIStyle=Oxygen/g' /etc/kde/kdm/kdmrc

#Get and set up the Kororaa Adobe flash and NVIDIA driver installers
#cp kororaa-source/files/add-remove-extras.sh /usr/local/bin/add-remove-extras.sh
#chmod a+x /usr/local/bin/add-remove-extras.sh
#cp kororaa-source/tools/add-remove-extras.desktop /usr/local/share/applications/add-remove-extras.desktop
#chmod a+x /usr/local/share/applications/add-remove-extras.desktop

#Copy add-remove-extras to the desktop
mkdir /etc/skel/Desktop
cp /usr/share/applications/add-remove-extras.desktop /etc/skel/Desktop/

#Copy Help document to desktop
cp kororaa-source/doco/Help.pdf /etc/skel/Desktop/

#Build out of kernel modules (so it's not done on first boot)
echo "****BUILDING AKMODS****"
/usr/sbin/akmods --force

#Download repo files for those without a release package to install
#cp kororaa-source/repos/atrpms.repo /etc/yum.repos.d/atrpms.repo
cp kororaa-source/repos/google-chrome.repo /etc/yum.repos.d/google-chrome.repo
#cp kororaa-source/repos/kororaa.repo /etc/yum.repos.d/kororaa.repo
cp kororaa-source/repos/ksplice-uptrack.repo /etc/yum.repos.d/ksplice-uptrack.repo
#cp kororaa-source/repos/libreoffice.repo /etc/yum.repos.d/libreoffice.repo
cp kororaa-source/repos/virtualbox.repo /etc/yum.repos.d/virtualbox.repo
#cp kororaa-source/repos/fedora-yum-rawhide.repo /etc/yum.repos.d/fedora-yum-rawhide.repo

#Import keys
for x in kororaa livna adobe-linux rpmfusion-free-fedora rpmfusion-nonfree-fedora ; do rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-$x ; done
#Chrome (this should prob just go in the repo file instead)
wget https://dl-ssl.google.com/linux/linux_signing_key.pub
rpm --import linux_signing_key.pub
rm linux_signing_key.pub
#Ksplice key
wget https://www.ksplice.com/yum/RPM-GPG-KEY-ksplice
rpm --import RPM-GPG-KEY-ksplice
rm RPM-GPG-KEY-ksplice
#ATrpms key
#wget http://ATrpms.net/RPM-GPG-KEY.atrpms
#rpm --import RPM-GPG-KEY.atrpms
#rm RPM-GPG-KEY.atrpms

#Don't allow Adobe to install reader (auto pulled in by flash).. yuck.
echo "exclude=AdobeReader*" >> /etc/yum.repos.d/adobe-linux-i386.repo

#Set yum to autoclean orphans on package removal and to only keep one old kernel around
#sed -i '/^\[main\]$/a clean_requirements_on_remove=1' /etc/yum.conf
sed -i 's/^installonly_limit=.*/installonly_limit=2/g' /etc/yum.conf

#Set up default Firefox profile with goodies like adblockplus, plasma notify, xclear, flashblock, etc.
wget http://kororaa.org/files/firefox-extensions.tar.bz2

#Set up firefox extensions and prefs. Just do both, it should fail on the other archs, echo doesn't seem to work properly.
tar -xvf firefox-extensions.tar.bz2 -C /usr/lib64/firefox-3.6/defaults/profile/
cat >> /usr/lib64/firefox-3.6/defaults/profile/prefs.js << EOF
user_pref("browser.download.manager.showAlertOnComplete", false);
user_pref("browser.download.manager.showWhenStarting", false);
user_pref("browser.download.useDownloadDir", false);
user_pref("extensions.dss.switchPending", true);
user_pref("extensions.lastSelectedSkin", "oxygen");
user_pref("downbar.function.version", "0.9.7.2");
user_pref("intl.accept_languages", "en-au,en-us,en");
EOF
chown -Rf root:root /usr/lib64/firefox-3.6/defaults/profile/

#32 bit
tar -xvf firefox-extensions.tar.bz2 -C /usr/lib/firefox-3.6/defaults/profile/
cat >> /usr/lib/firefox-3.6/defaults/profile/prefs.js << EOF
user_pref("browser.download.manager.showAlertOnComplete", false);
user_pref("browser.download.manager.showWhenStarting", false);
user_pref("browser.download.useDownloadDir", false);
user_pref("extensions.dss.switchPending", true);
user_pref("extensions.lastSelectedSkin", "oxygen");
user_pref("downbar.function.version", "0.9.7.2");
user_pref("intl.accept_languages", "en-au,en-us,en");
EOF
chown -Rf root:root /usr/lib/firefox-3.6/defaults/profile/

rm firefox-extensions.tar.bz2

#Patch the Firefox bookmarks and start page
patch < doco/bookmarks.patch /usr/lib64/firefox-3.6/defaults/profile/bookmarks.html
patch < doco/bookmarks.patch /usr/lib/firefox-3.6/defaults/profile/bookmarks.html
sed -i 's/start.fedoraproject.org//' /usr/lib*/firefox-3.6/browserconfig.properties

#Sudoers modifications
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/01_kororaa
echo "Defaults secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin" >> /etc/sudoers.d/01_kororaa
chmod 0440 /etc/sudoers.d/01_kororaa

#User modification, add first user to wheel, adm and lp groups
cat >> /etc/rc.local << EOF
for x in wheel adm lp ; do gpasswd -a \$(tail -n1 /etc/passwd |awk -F ":" {'print \$1'}) \$x ; done
for x in livesys livesys-late ; do chkconfig $x off ; done
sed -i '/^for.*/d' /etc/rc.local /etc/rc.d/rc.local /etc/rc.d/rc*.d/S99rc-local
sed -i '/^sed.*/d' /etc/rc.local /etc/rc.d/rc.local /etc/rc.d/rc*.d/S99rc-local
EOF

#KDE modifications
#KDE - Set default apps: vlc, firefox
cp /usr/share/kde-settings/kde-profile/default/share/applications/defaults.list /usr/local/share/applications/mimeapps.list
sed -i 's/Default\ Applications/Added\ Associations/g' /usr/local/share/applications/mimeapps.list
sed -i 's/kde4-dragonplayer.desktop/vlc.desktop/g' /usr/local/share/applications/mimeapps.list
sed -i 's/kde4-konqueror.desktop/mozilla-firefox.desktop/g' /usr/local/share/applications/mimeapps.list
sed -i '/^\[Added\ Associations\]$/a application/xhtml+xml=mozilla-firefox.desktop;kde4-kfmclient_html.desktop;kde4-kwrite.desktop;' /usr/local/share/applications/mimeapps.list
echo -e "\n[Added KDE Service Associations]\ntext/html=kwebkitpart.desktop;khtml.desktop;katepart.desktop;\ntext/html=kwebkitpart.desktop;khtml.desktop;katepart.desktop;" >> /usr/local/share/applications/mimeapps.list

#KDE - enable locale and spelling
echo -e "\n[Locale]\nCountry=au\nLanguage=en_GB" >> /usr/share/kde-settings/kde-profile/default/share/config/kdeglobals
echo -e "[Spelling]\nbackgroundCheckerEnabled=true\ncheckUppercase=true\ncheckerEnabledByDefault=true\ndefaultClient=\ndefaultLanguage=en_AU\nskipRunTogether=true" > /usr/share/kde-settings/kde-profile/default/share/config/sonnetrc

#KDE - Set click to double
echo -e "\n[KDE]\nSingleClick=false" >> /usr/share/kde-settings/kde-profile/default/share/config/kdeglobals

#KDE - Set cursor theme to white
sed -i 's/cursorTheme=default/cursorTheme=dmz/g' /usr/share/kde-settings/kde-profile/default/share/config/kcminputrc

#KDE - Turn on MusicBrainz
echo -e "[Lookup]\nMusicBrainzLookupEnabled=true" > /usr/share/kde-settings/kde-profile/default/share/config/kcmcddbrc

#KDE - Set restore manually saved KDEsession
sed -i '/^\[General\]$/a loginMode=restoreSavedSession' /usr/share/kde-settings/kde-profile/default/share/config/ksmserverrc

#KDE - Turn on anti-aliasing
sed -i '/^\[General\]$/a XftHintStyle=hintmedium\nXftSubPixel=none' /usr/share/kde-settings/kde-profile/default/share/config/kdeglobals

#KDE - Set DPI to 96 by default
echo -e "[General]\ndontChangeAASettings=false\nforceFontDPI=96" > /usr/share/kde-settings/kde-profile/default/share/config/kcmfonts

#KDE - Set firefox to default Web browser
sed -i '/^\[General\]$/a BrowserApplication[$e]=mozilla-firefox.desktop' /usr/share/kde-settings/kde-profile/default/share/config/kdeglobals

#KDE - Turn off sound when exiting (slow and annoying)
echo -e "[Event/exitkde]\nAction=\nExecute=\nKTTS=\nLogfile=" > /usr/share/kde-settings/kde-profile/default/share/config/kde.notifyrc

#KDE - Set phonon backend to xine (vlc needs testing!)
echo -e "[PhononBackend]\nEntry0_Preference=3\nEntry0_Service=phononbackends/xine.desktop\nEntry1_Preference=2\nEntry1_Service=phononbackends/gstreamer.desktop\nEntry2_Preference=1\nEntry2_Service=phononbackends/vlc.desktop\nNumberOfEntries=3" > /usr/share/kde-settings/kde-profile/default/share/config/servicetype_profilerc

#KDE lite default options
#Set netbook by default (users can change if they want in their profile)
mv /usr/share/autostart/plasma-desktop.desktop /usr/share/autostart/plasma-netbook.desktop
sed -i 's/desktop/netbook/g' /usr/share/autostart/plasma-netbook.desktop

#KDE - turn on focus stealing window (useful for authentication prompts)
sed -i '/^\[Windows\]$/a FocusStealingPreventionLevel=0' /usr/share/kde-settings/kde-profile/default/share/config/kwinrc

#Don't hide top bar by default, leave it accessible (less screen realestate, but more stable)
echo -e "[PlasmaViews][2]\npanelAutoHide=false\n\n[ViewIds]\n1=1\n2=2" > /usr/share/kde-settings/kde-profile/default/share/config/plasma-netbookrc

#Copy over plasma netbook settings
mkdir -p /etc/skel/.kde/share/config/
cp kororaa-source/skel/plasma-netbook-appletsrc /etc/skel/.kde/share/config/plasma-netbook-appletsrc
cp kororaa-source/skel/plasma-netbookrc /etc/skel/.kde/share/config/plasma-netbookrc
chown -Rf root:root /etc/skel/.kde
chmod -Rf a+r /etc/skel/.kde


#Disable kres-migrator
cat > /usr/share/kde-settings/kde-profile/default/share/config/kres-migratorrc << KRES_EOF
[Migration]
Enabled=false
KRES_EOF

# Disable nepomuk
cat > /usr/share/kde-settings/kde-profile/default/share/config/nepomukserverrc << NEPOMUK_EOF
[Basic Settings]
Start Nepomuk=false

#Turn off nepomuk
[Service-nepomukstrigiservice]
autostart=false
NEPOMUK_EOF

#Stop Klipper from starting
sed -i 's/AutoStart:true/AutoStart:false/g' /usr/share/autostart/klipper.desktop


#/KDE lite options

#KDE - Set fonts to liberation
#sed -i 's/Sans\ Serif/Liberation Sans/g' /usr/share/kde-settings/kde-profile/default/share/config/kdeglobals

#KDE - Turn on tips, handy for new users?
#sed -i 's/TipsOnStart=false/TipsOnStart=true/g' /usr/share/kde-settings/kde-profile/default/share/config/kdewizardrc

#KDE - Set menu and kicker items
cp kororaa-source/skel/plasma-desktop-appletsrc /usr/share/kde-settings/kde-profile/default/share/config/plasma-desktop-appletsrc
chmod a+r /usr/share/kde-settings/kde-profile/default/share/config/plasma-desktop-appletsrc
cp kororaa-source/skel/kickoffrc /usr/share/kde-settings/kde-profile/default/share/config/kickoffrc
chmod a+r /usr/share/kde-settings/kde-profile/default/share/config/kickoffrc

#Polkit changes to let wheel users do admin work (not yet implemented)
cp kororaa-source/polkit/10-kororaa-overrides.pkla /var/lib/polkit-1/localauthority/50-local.d/10-kororaa-overrides.pkla
/sbin/restorecon '/var/lib/polkit-1/localauthority/50-local.d/10-kororaa-overrides.pkla'

#Modify some existing app groups
sed -i 's/^Categories=Network;/Categories=/g' /usr/share/applications/redhat-system-control-network.desktop
sed -i 's/^Categories=/Categories=Utilities;/g' /usr/share/applications/kde4/konsole.desktop
sed -i 's/^Categories=/Categories=System;/g' /usr/share/applications/kde4/systemsettings.desktop
sed -i 's/^Categories=/Categories=Utilities;/g' /usr/share/applications/kde4/dolphin.desktop

#Update locate database (not installed on lite)
#/usr/bin/updatedb

#Rebuild initrd to remove Generic branding (necessary?)
/sbin/dracut -f

#Set vim background to be dark
echo "set bg=dark" >> /etc/vimrc

#Set colourful bash
echo "alias ls='ls --color=auto'" >> /etc/skel/.bashrc
echo "alias vim='vi'" >> /etc/skel/.bashrc
echo 'export PS1="\[\033[01;32m\]\u\[\033[1;32m\]@\[\033[01;32m\]\h\[\033[01;34m\] \W\[\033[01;32m\] \[\033[01;34m\]\$\[\033[00m\] "' >> /etc/skel/.bashrc

#Set cgroup hack
cat >> /etc/skel/.bashrc << EOF
if [ "\$PS1" ] ; then
        mkdir -m 0700 -p /cgroup/cpu/user/\$$ 2>/dev/null
        echo 1 > /cgroup/cpu/user/\$$/notify_on_release 2>/dev/null
        echo \$$ > /cgroup/cpu/user/\$$/tasks 2>/dev/null
fi
EOF

#Get script to remove cgroups
cp kororaa-source/tools/rm-cgroup.sh /usr/local/bin/rm-cgroup.sh
chmod a+x /usr/local/bin/rm-cgroup.sh

#Tell system to set up cgroups
cat >> /etc/rc.local << EOF
#Set up "200 line patch", in bash
mkdir /cgroup/cpu 2>/dev/null
mount -t cgroup -o cpu none /cgroup/cpu 2>/dev/null
mkdir -p -m 0777 /cgroup/cpu/user 2>/dev/null
echo "/usr/local/bin/rm-cgroup.sh" > /cgroup/cpu/release_agent 2>/dev/null
EOF

#Set history search
#echo '"\e[1;5A": history-search-backward' >> /etc/skel/.inputrc
#echo '"\e[1;5B": history-search-forward' >> /etc/skel/.inputrc

#Disable touchpad when keys pressed
mkdir -p /etc/skel/.config/autostart/
cat >> /etc/skel/.config/autostart/syndaemon.desktop << EOF
[Desktop Entry]
Comment[en_GB]=
Comment=
Exec=syndaemon -d -i 0.25
GenericName[en_GB]=
GenericName=
Icon=system-run
MimeType=
Name[en_GB]=
Name=
Path=
StartupNotify=false
Terminal=false
TerminalOptions=
Type=Application
X-DBUS-ServiceName=
X-DBUS-StartupType=
X-KDE-SubstituteUID=false
X-KDE-Username=
EOF

#Let's run prelink
/usr/sbin/prelink -av -mR -q

#LiveCD stuff (like creating user) is done by fedora-live-base.ks
#Modify LiveCD stuff, i.e. set autologin, enable installer (this is done in /etc/rc.d/init.d/livesys)
cat >> /etc/rc.d/init.d/livesys << EOF
sed -i 's/^#AutoLoginEnable=true/AutoLoginEnable=true/g' /etc/kde/kdm/kdmrc
sed -i 's/^#AutoLoginUser=fred/AutoLoginUser=liveuser\nAutoLoginDelay=5/g' /etc/kde/kdm/kdmrc
#sed -i 's/NoDisplay=true/NoDisplay=false/g' /home/liveuser/Desktop/liveinst.desktop
sed -i 's/NoDisplay=true/NoDisplay=false/g' /usr/share/applications/liveinst.desktop

#Add installer to desktop (netbook)
sed -i '/NVIDIA/a \\\n[Containments][1][stripwidget][favourite-4]\nurl=/usr/share/applications/liveinst.desktop' /home/liveuser/.kde/share/config/plasma-netbook-appletsrc

# Disable the update notifications of kpackagekit
cat > /usr/share/kde-settings/kde-profile/default/share/config/KPackageKit << KPACKAGEKIT_EOF
[CheckUpdate]
autoUpdate=0
interval=0

[Notify]
notifyLongTasks=2
notifyUpdates=0
KPACKAGEKIT_EOF

# don't use prelink on a running KDE live image
sed -i 's/PRELINKING=yes/PRELINKING=no/' /etc/sysconfig/prelink

#un-mute sound card (some issues reported)
amixer set Master 85% unmute

#chmod a+x /home/liveuser/Desktop/liveinst.desktop
chmod +x /usr/share/applications/liveinst.desktop
chown -Rf liveuser:liveuser /home/liveuser/Desktop
restorecon -R /home/liveuser/

EOF

#Finally, clean up resolv.conf hack
echo "" > /etc/resolv.conf

#Clean up git
rm -Rf kororaa-source

%end

