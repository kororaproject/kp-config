%include fedora-arm-base.ks
%include fedora-minimal-common.ks

part /boot --size=512 --fstype ext4
part swap --size=256 --fstype swap
part / --size=1250 --fstype ext4

%packages
-xkeyboard-config
%end
