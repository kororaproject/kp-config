# See docker-base-common.ks for details on how to hack on docker image kickstarts
# This base is a stripped back Fedora image without python3/dnf.
# If you need that use the standard base image.

%include fedora-docker-common.ks

%packages --excludedocs --instLangs=en --nocore --excludeWeakdeps
microdnf

%end

%post --erroronfail --log=/root/anaconda-post.log
# remove some random help txt files
rm -fv usr/share/gnupg/help*.txt

# Pruning random things
rm usr/lib/rpm/rpm.daily
rm -rfv usr/lib64/nss/unsupported-tools/  # unsupported

# Statically linked crap
rm -fv usr/sbin/{glibc_post_upgrade.x86_64,sln}
ln usr/bin/ln usr/sbin/sln

# Remove some dnf info
rm -rfv /var/lib/dnf

# don't need icons
rm -rfv /usr/share/icons/*

#some random not-that-useful binaries
rm -fv /usr/bin/pinky

# we lose presets by removing /usr/lib/systemd but we do not care
rm -rfv /usr/lib/systemd

# if you want to change the timezone, bind-mount it from the host or reinstall tzdata
rm -fv /etc/localtime
mv /usr/share/zoneinfo/UTC /etc/localtime
rm -rfv  /usr/share/zoneinfo

# Final pruning
rm -rfv /var/cache/* /var/log/* /tmp/*

%end

%post --nochroot --erroronfail --log=/mnt/sysimage/root/anaconda-post-nochroot.log
set -eux

# https://bugzilla.redhat.com/show_bug.cgi?id=1343138
# Fix /run/lock breakage since it's not tmpfs in docker
# This unmounts /run (tmpfs) and then recreates the files
# in the /run directory on the root filesystem of the container
# NOTE: run this in nochroot because "umount" does not exist in chroot
umount /mnt/sysimage/run
# The file that specifies the /run/lock tmpfile is
# /usr/lib/tmpfiles.d/legacy.conf, which is part of the systemd
# rpm that isn't included in this image. We'll create the /run/lock
# file here manually with the settings from legacy.conf
# NOTE: chroot to run "install" because it is not in anaconda env
chroot /mnt/sysimage install -d /run/lock -m 0755 -o root -g root


# See: https://bugzilla.redhat.com/show_bug.cgi?id=1051816
# NOTE: run this in nochroot because "find" does not exist in chroot
KEEPLANG=en_US
for dir in locale i18n; do
    find /mnt/sysimage/usr/share/${dir} -mindepth  1 -maxdepth 1 -type d -not \( -name "${KEEPLANG}" -o -name POSIX \) -exec rm -rfv {} +
done

%end
