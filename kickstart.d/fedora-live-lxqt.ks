# fedora-live-lxqt.ks
#
# Description:
# – Fedora Live Spin with the LXQt desktop environment
#
# Maintainer(s):
# – Christian Dersch <lupinix@fedoraproject.org>
#

%include fedora-live-base.ks
%include fedora-live-minimization.ks
%include fedora-lxqt-common.ks

%post
# add initscript
cat >> /etc/rc.d/init.d/livesys << EOF

# set up autologin for user liveuser
if [ -f /etc/sddm.conf ]; then
sed -i 's/^#User=.*/User=liveuser/' /etc/sddm.conf
sed -i 's/^#Session=.*/Session=lxqt.desktop/' /etc/sddm.conf
else
cat > /etc/sddm.conf << SDDM_EOF
[Autologin]
User=liveuser
Session=lxqt.desktop
SDDM_EOF
fi

# show liveinst.desktop on desktop and in menu
sed -i 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp -a /usr/share/applications/liveinst.desktop /home/liveuser/Desktop/

# set up preferred apps 
cat > /etc/xdg/libfm/pref-apps.conf << FOE 
[Preferred Applications]
WebBrowser=qupzilla.desktop
FOE

# no updater applet in live environment
rm -f /etc/xdg/autostart/org.mageia.dnfdragora-updater.desktop

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF

%end

