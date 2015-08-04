# REPOS

# KP - production repositories
#repo --name="Adobe Systems Incorporated" --baseurl=http://linuxdownload.adobe.com/linux/%%KP_BASEARCH%%/ --cost=1000
# We need 32bit for 64bit images also
#repo --name="Adobe Systems Incorporated - 32bit" --baseurl=http://linuxdownload.adobe.com/linux/i386/ --cost=1000

repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%%" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/releases/%%KP_VERSION%%/Everything/%%KP_BASEARCH%%/os/ --cost=1000
repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%% - Updates" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/updates/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000
#repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%% - Updates Testing" --baseurl=http://download.fedoraproject.org/pub/fedora/linux/updates/testing/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000

# KORORA REPOS, set to remote for release, local for testing
repo --name="Korora %%KP_VERSION%% - Local Release" --baseurl=%%KP_REPOSITORY%%/releases/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=10
#repo --name="Korora %%KP_VERSION%%" --baseurl=http://dl.kororaproject.org/pub/korora/releases/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=100

repo --name="RPMFusion Free" --baseurl=http://download1.rpmfusion.org/free/fedora/releases/%%KP_VERSION%%/Everything/%%KP_BASEARCH%%/os/ --cost=1000
repo --name="RPMFusion Free - Updates" --baseurl=http://download1.rpmfusion.org/free/fedora/updates/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000

repo --name="RPMFusion Non-Free" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/%%KP_VERSION%%/Everything/%%KP_BASEARCH%%/os/ --cost=1000
repo --name="RPMFusion Non-Free - Updates" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/updates/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000
