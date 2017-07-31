# See docker-base-common.ks for details on how to hack on docker image kickstarts
# This base is a standard Fedora image with python3 and dnf

%include fedora-docker-common.ks

%packages --excludedocs --instLangs=en --nocore
rootfiles
tar # https://bugzilla.redhat.com/show_bug.cgi?id=1409920
vim-minimal
dnf
dnf-yum  # https://fedorahosted.org/fesco/ticket/1312#comment:29
sssd-client

%end

%post --erroronfail --log=/root/anaconda-post.log

# remove some extraneous files
rm -rf /var/cache/dnf/*
rm -rf /tmp/*

#Mask mount units and getty service so that we don't get login prompt
systemctl mask systemd-remount-fs.service dev-hugepages.mount sys-fs-fuse-connections.mount systemd-logind.service getty.target console-getty.service

# https://bugzilla.redhat.com/show_bug.cgi?id=1343138
# Fix /run/lock breakage since it's not tmpfs in docker
# This unmounts /run (tmpfs) and then recreates the files
# in the /run directory on the root filesystem of the container
#
# We ignore the return code of the systemd-tmpfiles command because
# at this point we have already removed the /etc/machine-id and all
# tmpfiles lines with %m in them will fail and cause a bad return
# code. Example failure:
#   [/usr/lib/tmpfiles.d/systemd.conf:26] Failed to replace specifiers: /run/log/journal/%m
#
umount /run
systemd-tmpfiles --prefix=/run/ --prefix=/var/run/ --create --boot || true

%end
