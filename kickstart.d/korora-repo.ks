# REPOS

# KP - production repositories
#repo --name="Adobe Systems Incorporated" --baseurl=http://linuxdownload.adobe.com/linux/$basearch/ --cost=1000
# We need 32bit for 64bit images also
#repo --name="Adobe Systems Incorporated - 32bit" --baseurl=http://linuxdownload.adobe.com/linux/i386/ --cost=1000

repo --name="Fedora $releasever - $basearch" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/releases/$releasever/Everything/$basearch/os/ --cost=1000
repo --name="Fedora $releasever - $basearch - Updates" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/updates/$releasever/$basearch/ --cost=1000
#repo --name="Fedora $releasever - $basearch - Updates Testing" --baseurl=http://download.fedoraproject.org/pub/fedora/linux/updates/testing/$releasever/$basearch/ --cost=1000

# KORORA REPOS, set to remote for release, local for testing
repo --name="Korora $releasever - Local Release" --baseurl=%%KP_REPOSITORY%%/releases/$releasever/$basearch/ --cost=10
#repo --name="Korora $releasever" --baseurl=http://dl.kororaproject.org/pub/korora/releases/$releasever/$basearch/ --cost=100

repo --name="RPMFusion Free" --baseurl=http://download1.rpmfusion.org/free/fedora/releases/$releasever/Everything/$basearch/os/ --cost=1000
repo --name="RPMFusion Free - Updates" --baseurl=http://download1.rpmfusion.org/free/fedora/updates/$releasever/$basearch/ --cost=1000

repo --name="RPMFusion Non-Free" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/$releasever/Everything/$basearch/os/ --cost=1000
repo --name="RPMFusion Non-Free - Updates" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/updates/$releasever/$basearch/ --cost=1000
