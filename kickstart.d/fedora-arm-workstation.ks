%include fedora-arm-base.ks
%include fedora-arm-xbase.ks
%include fedora-workstation-common.ks

part / --size=5500 --fstype ext4

%packages
-initial-setup
-initial-setup-gui

%end

%post
# Most of the ARM X accelerated drivers need some level of CMA allocation
sed -i 's/\(append .*\)/\1 cma=256MB/' /boot/extlinux/extlinux.conf

%end
