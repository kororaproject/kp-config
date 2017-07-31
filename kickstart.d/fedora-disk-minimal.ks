%include fedora-disk-base.ks
%include fedora-minimal-common.ks

services --enabled=sshd,NetworkManager,chronyd,initial-setup

autopart --type=plain

%packages
-xkeyboard-config
%end
