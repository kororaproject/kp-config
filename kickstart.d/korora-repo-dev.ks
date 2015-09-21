# DEV REPOS

repo --name="Fedora $releasever - $basearch" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/releases/$releasever/Everything/$basearch/os/ --cost=1000
repo --name="Fedora $releasever - $basearch - Updates" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/updates/$releasever/$basearch/ --cost=1000
#repo --name="Fedora $releasever - $basearch - Updates Testing" --baseurl=http://download.fedoraproject.org/pub/fedora/linux/updates/testing/$releasever/$basearch/ --cost=1000

# KORORA REPOS, set to remote for release, local for testing
repo --name="Korora $releasever - Local Release" --baseurl=%%KP_REPOSITORY%%/releases/$releasever/$basearch/ --cost=10
#repo --name="Korora $releasever - Local Testing" --baseurl=%%KP_REPOSITORY%%/testing/$releasever/$basearch/ --cost=10
#repo --name="Korora $releasever" --baseurl=http://dl.kororaproject.org/pub/korora/releases/$releasever/$basearch/ --cost=100
#repo --name="Korora $releasever - Testing" --baseurl=http://dl.kororaproject.org/pub/korora/testing/$releasever/$basearch/ --cost=100

#
# KP - development repositories
repo --name="Fedora $releasever - $basearch" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/development/$releasever/$basearch/os/ --cost=1000

#repo --name="Fedora $releasever - $basearch Updates Released" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/updates/$releasever/$basearch/ --cost=1000
#repo --name="Fedora $releasever - $basearch Updates Testing" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/updates/testing/$releasever/$basearch/ --cost=1000

#repo --name="RPMFusion Free - Development" --baseurl=http://download1.rpmfusion.org/free/fedora/development/$releasever/$basearch/os/ --cost=1000
#repo --name="RPMFusion Non-Free - Development" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/development/$releasever/$basearch/os/ --cost=1000

# RAWHIDE - use when RPM Fusion has not yet branched (usually because fedora is still pre-beta)
repo --name="RPMFusion Free - Development" --baseurl=http://download1.rpmfusion.org/free/fedora/development/rawhide/$basearch/os/ --cost=1000
repo --name="RPMFusion Non-Free - Development" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/development/rawhide/$basearch/os/ --cost=1000

