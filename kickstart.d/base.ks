# fedora-live-base.ks
#
# Defines the basics for all kickstarts in the fedora-live branch
# Does not include package selection (other then mandatory)
# Does not include localization packages or configuration
#
# Does includes "default" language configuration (kickstarts including
# this template can override these settings)

lang en_US.UTF-8
keyboard us
timezone --utc Australia/Sydney
authconfig --enableshadow --passalgo=sha512 --enablefingerprint
selinux --enforcing
authconfig --enableshadow --passalgo=sha512 --enablefingerprint
firewall --enabled --service=ipp-client,mdns,samba,samba-client,ssh
xconfig --startxonboot
services --enabled=lirc,NetworkManager,restorecond --disabled=abrtd,abrt-ccpp,abrt-oops,abrt-vmcore,abrt-xorg,capi,iprdump,iprinit,iprupdate,iscsi,iscsid,isdn,libvirtd,multipathd,netfs,network,nfs,nfslock,pcscd,rpcbind,rpcgssd,rpcidmapd,rpcsvcgssd,sendmail,sm-client,sshd

#Partitioning, for Live CD
part / --size 7168 --fstype ext4

#
# REPOS

repo --name="Adobe Systems Incorporated" --baseurl=http://linuxdownload.adobe.com/linux/%%KP_BASEARCH%%/ --cost=1000
#repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%% - Development" --baseurl=ftp://mirror.internode.on.net/pub/fedora/linux/development/%%KP_VERSION%%/%%KP_BASEARCH%%/os/ --cost=1000
repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%%" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/releases/%%KP_VERSION%%/Everything/%%KP_BASEARCH%%/os/ --cost=1000
#repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%% - Updates Testing" --baseurl=http://download.fedoraproject.org/pub/fedora/linux/updates/testing/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000
repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%% - Updates" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/updates/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000
repo --name="Google Chrome" --baseurl=http://dl.google.com/linux/chrome/rpm/stable/%%KP_BASEARCH%%/ --cost=1000
repo --name="Korora %%KP_VERSION%%" --baseurl=file://%%KP_REPOSITORY_DIR%%/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=10

#repo --name="Kororaa Testing" --baseurl=file:///home/chris/repos/kororaa/testing/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=5
#repo --name="Ksplice Uptrack for Fedora" --baseurl=http://www.ksplice.com/yum/uptrack/fedora/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000

#repo --name="RPMFusion Free" --baseurl=http://download1.rpmfusion.org/free/fedora/development/%%KP_VERSION%%/%%KP_BASEARCH%%/os/ --cost=1000
repo --name="RPMFusion Free" --baseurl=http://download1.rpmfusion.org/free/fedora/releases/%%KP_VERSION%%/Everything/%%KP_BASEARCH%%/os/ --cost=1000
repo --name="RPMFusion Free - Updates" --baseurl=http://download1.rpmfusion.org/free/fedora/updates/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000

#repo --name="RPMFusion Non-Free" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/development/%%KP_VERSION%%/%%KP_BASEARCH%%/os/ --cost=1000
repo --name="RPMFusion Non-Free" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/%%KP_VERSION%%/Everything/%%KP_BASEARCH%%/os/ --cost=1000
repo --name="RPMFusion Non-Free - Updates" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/updates/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000
repo --name="VirtualBox" --baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000

#
# PACKAGES

%packages
@admin-tools
@base-x
@core
@critical-path-base
@dial-up
@fonts
@input-methods
@hardware-support
-@multimedia
@printing
@standard

# Explicitly specified here:
# <notting> walters: because otherwise dependency loops cause yum issues.
kernel
kernel-modules-extra

# This was added a while ago, I think it falls into the category of
# "Diagnosis/recovery tool useful from a Live OS image".  Leaving this untouched
# for now.
memtest86+

# The point of a live image is to install
anaconda
@anaconda-tools

#Install 3rd party repo releases
adobe-release
google-chrome-release
google-earth-release
google-talkplugin-release
#ksplice-uptrack
rpmfusion-free-release
rpmfusion-nonfree-release
virtualbox-release

#
# (RE)BRANDING
korora-backgrounds
korora-extras
korora-release
korora-logos
korora-release-notes
plymouth-theme-korora

#
# TERMINAL ENHANCEMENTS

# undistract-me is great for notification on completion of long running terminal commands
undistract-me
unburden-home-dir

# fpaste is very useful for debugging and very small
fpaste

#
# HARDWARE MONITORING/CONTROLLING
powertop

# system config
system-config-samba
system-config-services

%end

%post
#Set the korora plymouth theme
sed -i s/^Theme=.*/Theme=korora/ /etc/plymouth/plymouthd.conf

# FIXME: it'd be better to get this installed from a package
cat > /etc/rc.d/init.d/livesys << EOF
#!/bin/bash
#
# live: Init script for live image
#
# chkconfig: 345 00 99
# description: Init script for live image.

. /etc/init.d/functions

if ! strstr "\`cat /proc/cmdline\`" rd.live.image || [ "\$1" != "start" ]; then
    exit 0
fi

if [ -e /.liveimg-configured ] ; then
    configdone=1
fi

exists() {
    which \$1 >/dev/null 2>&1 || return
    \$*
}

touch /.liveimg-configured

# Make sure we don't mangle the hardware clock on shutdown
ln -sf /dev/null /etc/systemd/system/hwclock-save.service

livedir="LiveOS"
for arg in \`cat /proc/cmdline\` ; do
  if [ "\${arg##rd.live.dir=}" != "\${arg}" ]; then
    livedir=\${arg##rd.live.dir=}
    return
  fi
  if [ "\${arg##live_dir=}" != "\${arg}" ]; then
    livedir=\${arg##live_dir=}
    return
  fi
done

# enable swaps unless requested otherwise
swaps=\`blkid -t TYPE=swap -o device\`
if ! strstr "\`cat /proc/cmdline\`" noswap && [ -n "\$swaps" ] ; then
  for s in \$swaps ; do
    action "Enabling swap partition \$s" swapon \$s
  done
fi
if ! strstr "\`cat /proc/cmdline\`" noswap && [ -f /run/initramfs/live/\${livedir}/swap.img ] ; then
  action "Enabling swap file" swapon /run/initramfs/live/\${livedir}/swap.img
fi

mountPersistentHome() {
  # support label/uuid
  if [ "\${homedev##LABEL=}" != "\${homedev}" -o "\${homedev##UUID=}" != "\${homedev}" ]; then
    homedev=\`/sbin/blkid -o device -t "\$homedev"\`
  fi

  # if we're given a file rather than a blockdev, loopback it
  if [ "\${homedev##mtd}" != "\${homedev}" ]; then
    # mtd devs don't have a block device but get magic-mounted with -t jffs2
    mountopts="-t jffs2"
  elif [ ! -b "\$homedev" ]; then
    loopdev=\`losetup -f\`
    if [ "\${homedev##/run/initramfs/live}" != "\${homedev}" ]; then
      action "Remounting live store r/w" mount -o remount,rw /run/initramfs/live
    fi
    losetup \$loopdev \$homedev
    homedev=\$loopdev
  fi

  # if it's encrypted, we need to unlock it
  if [ "\$(/sbin/blkid -s TYPE -o value \$homedev 2>/dev/null)" = "crypto_LUKS" ]; then
    echo
    echo "Setting up encrypted /home device"
    plymouth ask-for-password --command="cryptsetup luksOpen \$homedev EncHome"
    homedev=/dev/mapper/EncHome
  fi

  # and finally do the mount
  mount \$mountopts \$homedev /home
  # if we have /home under what's passed for persistent home, then
  # we should make that the real /home.  useful for mtd device on olpc
  if [ -d /home/home ]; then mount --bind /home/home /home ; fi
  [ -x /sbin/restorecon ] && /sbin/restorecon /home
  if [ -d /home/liveuser ]; then USERADDARGS="-M" ; fi
}

findPersistentHome() {
  for arg in \`cat /proc/cmdline\` ; do
    if [ "\${arg##persistenthome=}" != "\${arg}" ]; then
      homedev=\${arg##persistenthome=}
      return
    fi
  done
}

if strstr "\`cat /proc/cmdline\`" persistenthome= ; then
  findPersistentHome
elif [ -e /run/initramfs/live/\${livedir}/home.img ]; then
  homedev=/run/initramfs/live/\${livedir}/home.img
fi

# if we have a persistent /home, then we want to go ahead and mount it
if ! strstr "\`cat /proc/cmdline\`" nopersistenthome && [ -n "\$homedev" ] ; then
  action "Mounting persistent /home" mountPersistentHome
fi

# make it so that we don't do writing to the overlay for things which
# are just tmpdirs/caches
mount -t tmpfs -o mode=0755 varcacheyum /var/cache/yum
mount -t tmpfs vartmp /var/tmp
[ -x /sbin/restorecon ] && /sbin/restorecon /var/cache/yum /var/tmp >/dev/null 2>&1

if [ -n "\$configdone" ]; then
  exit 0
fi

# add fedora user with no passwd
action "Adding live user" useradd \$USERADDARGS -c "Live User" liveuser
passwd -d liveuser > /dev/null
#echo "liveuser" | passwd --stdin liveuser
gpasswd -a liveuser wheel

# turn off firstboot for livecd boots
systemctl --no-reload disable firstboot-text.service 2> /dev/null || :
systemctl --no-reload disable firstboot-graphical.service 2> /dev/null || :
systemctl stop firstboot-text.service 2> /dev/null || :
systemctl stop firstboot-graphical.service 2> /dev/null || :

# don't use prelink on a running live image
sed -i 's/PRELINKING=yes/PRELINKING=no/' /etc/sysconfig/prelink &>/dev/null || :

# turn off mdmonitor by default
systemctl --no-reload disable mdmonitor.service 2> /dev/null || :
systemctl --no-reload disable mdmonitor-takeover.service 2> /dev/null || :
systemctl stop mdmonitor.service 2> /dev/null || :
systemctl stop mdmonitor-takeover.service 2> /dev/null || :

# don't enable the gnome-settings-daemon packagekit plugin
gsettings set org.gnome.settings-daemon.plugins.updates active 'false' || :

# don't start cron/at as they tend to spawn things which are
# disk intensive that are painful on a live image
systemctl --no-reload disable crond.service 2> /dev/null || :
systemctl --no-reload disable atd.service 2> /dev/null || :
systemctl stop crond.service 2> /dev/null || :
systemctl stop atd.service 2> /dev/null || :

# and hack so that we eject the cd on shutdown if we're using a CD...
if strstr "\`cat /proc/cmdline\`" CDLABEL= ; then
  cat >> /sbin/halt.local << FOE
#!/bin/bash
# XXX: This often gets stuck during shutdown because /etc/init.d/halt
#      (or something else still running) wants to read files from the block\
#      device that was ejected.  Disable for now.  Bug #531924
# we want to eject the cd on halt, but let's also try to avoid
# io errors due to not being able to get files...
#cat /sbin/halt > /dev/null
#cat /sbin/reboot > /dev/null
#/usr/sbin/eject -p -m \$(readlink -f /run/initramfs/livedev) >/dev/null 2>&1
#echo "Please remove the CD from your drive and press Enter to finish restarting"
#read -t 30 < /dev/console
FOE
chmod +x /sbin/halt.local
fi

EOF

# bah, hal starts way too late
cat > /etc/rc.d/init.d/livesys-late << EOF
#!/bin/bash
#
# live: Late init script for live image
#
# chkconfig: 345 99 01
# description: Late init script for live image.

. /etc/init.d/functions

if ! strstr "\`cat /proc/cmdline\`" liveimg || [ "\$1" != "start" ] || [ -e /.liveimg-late-configured ] ; then
    exit 0
fi

exists() {
    which \$1 >/dev/null 2>&1 || return
    \$*
}

touch /.liveimg-late-configured

# read some variables out of /proc/cmdline
for o in \`cat /proc/cmdline\` ; do
    case \$o in
    ks=*)
        ks="--kickstart=\${o#ks=}"
        ;;
    xdriver=*)
        xdriver="\${o#xdriver=}"
        ;;
    esac
done

# if liveinst or textinst is given, start anaconda
if strstr "\`cat /proc/cmdline\`" liveinst ; then
   plymouth --quit
   /usr/sbin/liveinst \$ks
fi
if strstr "\`cat /proc/cmdline\`" textinst ; then
   plymouth --quit
   /usr/sbin/liveinst --text \$ks
fi

# configure X, allowing user to override xdriver
if [ -n "\$xdriver" ]; then
   cat > /etc/X11/xorg.conf.d/00-xdriver.conf <<FOE
Section "Device"
	Identifier	"Videocard0"
	Driver	"\$xdriver"
EndSection
FOE
fi

EOF

chmod 755 /etc/rc.d/init.d/livesys
/sbin/restorecon /etc/rc.d/init.d/livesys
/sbin/chkconfig --add livesys

chmod 755 /etc/rc.d/init.d/livesys-late
/sbin/restorecon /etc/rc.d/init.d/livesys-late
/sbin/chkconfig --add livesys-late

# enable tmpfs for /tmp
systemctl enable tmp.mount

# work around for poor key import UI in PackageKit
rm -f /var/lib/rpm/__db*
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora
echo "Packages within this LiveCD"
rpm -qa
# Note that running rpm recreates the rpm db files which aren't needed or wanted
rm -f /var/lib/rpm/__db*

# go ahead and pre-make the man -k cache (#455968)
/usr/bin/mandb

# save a little bit of space at least...
rm -f /boot/initramfs*
# make sure there aren't core files lying around
rm -f /core*

# convince readahead not to collect
# FIXME: for systemd

%end


%post --nochroot
cp $INSTALL_ROOT/usr/share/doc/*-release-*/GPL $LIVE_ROOT/GPL
cat > $LIVE_ROOT/README.txt << EOF
Thank you for downloading Korora!

This is a Live DVD, simply reboot your computer to run from this DVD.

To install Kororaa, simply run the installer on the desktop or in the left menu (under GNOME).

Please provide us with feedback and any suggestions at http://kororaproject.org

Enjoy!

Note: The Korora Project is not provided or supported by the Fedora Project. Official, unmodified Fedora software is available through the Fedora Project website (http://fedoraproject.org).
EOF

# only works on x86, x86_64
if [ "$(uname -i)" = "i386" -o "$(uname -i)" = "x86_64" ]; then
  if [ ! -d $LIVE_ROOT/LiveOS ]; then mkdir -p $LIVE_ROOT/LiveOS ; fi
  cp /usr/bin/livecd-iso-to-disk $LIVE_ROOT/LiveOS
fi
%end
