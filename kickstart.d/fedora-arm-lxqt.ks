%include fedora-arm-base.ks
%include fedora-arm-xbase.ks
%include fedora-lxqt-common.ks

part / --size=3800 --fstype ext4 --asprimary

%packages
# trojita not available on non-x86 platforms
-trojita
%end

%post

%end
