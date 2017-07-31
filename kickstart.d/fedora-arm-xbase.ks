%packages
@base-x
@fonts
@input-methods
@multimedia
@printing
%end

%post
# Most of the ARM X accelerated drivers need some level of CMA allocation
sed -i 's/\(append .*\)/\1 cma=192MB/' /boot/extlinux/extlinux.conf

# Explicitly set graphical.target as default as this is how initial-setup detects which version to run
ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target

%end
