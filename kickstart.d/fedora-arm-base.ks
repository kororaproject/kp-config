lang en_US.UTF-8
#keyboard us
auth --useshadow --passalgo=sha512
selinux --enforcing
firewall --enabled --service=mdns,ssh

# configure extlinux bootloader
bootloader extlinux

part /boot/fw --size=30 --fstype vfat --asprimary
part /boot --size=512 --fstype ext4 --asprimary
part swap --size=512 --fstype swap --asprimary
part / --size=2800 --fstype ext4 --asprimary

# make sure that initial-setup runs and lets us do all the configuration bits
firstboot --reconfig

services --enabled=sshd,NetworkManager,avahi-daemon,rsyslog,chronyd,initial-setup

%include fedora-repo.ks

%packages
@core
@standard
@hardware-support

kernel
# remove this in %post
dracut-config-generic
-dracut-config-rescue
# install tools needed to manage and boot arm systems
@arm-tools
-uboot-images-armv8
rng-tools
chrony
extlinux-bootloader
bcm283x-firmware
initial-setup
initial-setup-gui
-iwl*
-ipw*
-trousers-lib
-usb_modeswitch
-iproute-tc
#lets resize / on first boot
# dracut-modules-growroot

# make sure all the locales are available for inital0-setup and anaconda to work
glibc-all-langpacks

# workaround for consequence of RHBZ #1324623: without this, with
# yum-based creation tools, compose fails due to conflict between
# libcrypt and libcrypt-nss. dnf does not seem to have the same
# issue, so this may be dropped when appliance-creator is ported
# to dnf.
libcrypt-nss
-libcrypt
%end

%post

# Setup Raspberry Pi firmware
cp -Pr /usr/share/bcm283x-firmware/* /boot/fw/
cp -P /usr/share/uboot/rpi_2/u-boot.bin /boot/fw/rpi2-u-boot.bin
cp -P /usr/share/uboot/rpi_3_32b/u-boot.bin /boot/fw/rpi3-u-boot.bin
sed -i '/vfat/ d' /etc/fstab

# work around for poor key import UI in PackageKit
rm -f /var/lib/rpm/__db*
releasever=$(rpm -q --qf '%{version}\n' fedora-release)
basearch=armhfp
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
echo "Packages within this ARM disk image"
rpm -qa
# Note that running rpm recreates the rpm db files which aren't needed or wanted
rm -f /var/lib/rpm/__db*

# remove random seed, the newly installed instance should make it's own
rm -f /var/lib/systemd/random-seed

# Because memory is scarce resource in most arm systems we are differing from the Fedora
# default of having /tmp on tmpfs.
echo "Disabling tmpfs for /tmp."
systemctl mask tmp.mount

dnf -y remove dracut-config-generic

# Disable network service here, as doing it in the services line
# fails due to RHBZ #1369794
/sbin/chkconfig network off

# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id

%end

