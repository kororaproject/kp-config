# korora-base.ks
#
# Defines the basics for all kickstarts in the fedora-live branch
# Does not include package selection (other then mandatory)
# Does not include localization packages or configuration
#
# Does includes "default" language configuration (kickstarts including
# this template can override these settings)

timezone Etc/UTC --isUtc --ntpservers=0.pool.ntp.org,1.pool.ntp.org,2.pool.ntp.org,3.pool.ntp.org
auth --enableshadow --passalgo=sha512 --enablefingerprint
selinux --enforcing
firewall --enabled --service=ipp-client,kde-connect,mdns,samba,samba-client,ssh
xconfig --startxonboot
zerombr
clearpart --all
part / --size 10240 --fstype ext4
services --enabled=fstrim.timer,ksmtuned,lircd,ModemManager,NetworkManager,sensord,spice-vdagentd --disabled=abrtd,abrt-ccpp,abrt-oops,abrt-vmcore,abrt-xorg,capi,iprdump,iprinit,iprupdate,iscsi,iscsid,isdn,libvirtd,multipathd,netfs,network,nfs,nfslock,pcscd,rpcbind,rpcgssd,rpcidmapd,rpcsvcgssd,sendmail,sm-client,sshd

%include korora-repo.ks
#%include korora-repo-dev.ks
# move the common packages to the desktops so that canvas doesn't inherit them
#%include korora-common-packages.ks
%include snippets/packagekit-cached-metadata.ks

%post

# group for any vbox users
/usr/sbin/groupadd -r vboxusers

# disable all abrt services, we can't upload to bugzilla
for x in abrtd abrt-ccpp abrt-oops abrt-vmcore abrt-xorg ; do
  systemctl disable $x
done

# import keys
echo -e "\n***\nIMPORTING KEYS\n***"
for x in 20 21 22 23 24
do
  for y in adobe fedora-$x-primary fedora-$x-secondary google-chrome google-earth google-talkplugin korora-$x-primary korora-$x-secondary rpmfusion-free-fedora-$x-primary rpmfusion-nonfree-fedora-$x-primary virtualbox
  do
    KEY="/etc/pki/rpm-gpg/RPM-GPG-KEY-${y}"
    if [ -r "${KEY}" ];
    then
      rpm --import "${KEY}" && echo "IMPORTED: $KEY (${y})"
    else
      echo "IMPORT KEY NOT FOUND: $KEY (${y})"
    fi
  done
done

# enable magic keys
echo "kernel.sysrq = 1" >> /etc/sysctl.conf

# enable discards on LVM for trim
# DISABLED - breaks anaconda
#sed -i 's/issue_discards = 0/issue_discards = 1/g' /etc/lvm/lvm.conf

# make home dir - NOTE this seems to cause trouble on non-English installs :-(
#mkdir /etc/skel/{Documents,Downloads,Music,Pictures,Videos}
mkdir /etc/skel/Desktop

# set the korora plymouth theme
sed -i s/^Theme=.*/Theme=korora/ /etc/plymouth/plymouthd.conf

# KP - update locate database
/usr/bin/updatedb

# KP - let's run prelink (makes things faster)
#echo -e "***\nPRELINKING\n****"
#/usr/sbin/prelink -av -mR -q

cat >> /etc/rc.d/init.d/livesys << EOF

# disable fedora welcome screen
rm -f /usr/share/applications/fedora-welcome.desktop
rm -f ~liveuser/.config/autostart/fedora-welcome.desktop

# turn off PackageKit-command-not-found
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

# KP - don't let prelink run on the live image
#sed -i 's/PRELINKING=yes/PRELINKING=no/' /etc/sysconfig/prelink # actually this forces prelink to run to undo prelinking (see /etc/sysconfig/prelink)
#mv /usr/sbin/prelink /usr/sbin/prelink-disabled
#rm /etc/cron.daily/prelink

# Copy Anaconda branding in place
cp -a /usr/share/lorax/product/* /

# KP - ensure liveuser desktop exists
mkdir ~liveuser/Desktop

EOF

%end
