# Like the Atomic Host cloud image, but tuned for vagrant: enable the
# vagrant user, disable cloud-init.

%include fedora-atomic.ks

user --name=vagrant --password=vagrant
rootpw vagrant

# The addition of the net.ifnames=0 and biosdevnames=0 option ensures that
# even on VirtualBox virt, we get a primary network device with "eth0" as the name
# This simplifies things and allows a single disk image for both supported Vagrant
# platforms (virtualbox and kvm)
bootloader --timeout=1 --append="no_timer_check console=tty1 console=ttyS0,115200n8 net.ifnames=0 biosdevname=0"

%post --erroronfail

# Work around cloud-init being both disabled and enabled; need
# to refactor to a common base.
systemctl mask cloud-init cloud-init-local cloud-config cloud-final

# The inherited cloud %post locks the passwd, but we want it
# unlocked for vagrant, just like downstream.
passwd -u root

# Vagrant setup
sed -i 's,Defaults\\s*requiretty,Defaults !requiretty,' /etc/sudoers
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant-nopasswd
sed -i 's/.*UseDNS.*/UseDNS no/' /etc/ssh/sshd_config
mkdir -m 0700 -p ~vagrant/.ssh
cat > ~vagrant/.ssh/authorized_keys << EOKEYS
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
EOKEYS
chmod 600 ~vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant ~vagrant/.ssh/

%end

