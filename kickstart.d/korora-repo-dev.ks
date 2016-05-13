# DEV REPOS

#repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%%" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/releases/%%KP_VERSION%%/Everything/%%KP_BASEARCH%%/os/ --cost=1000
#repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%% - Updates" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/updates/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000
#repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%% - Updates Testing" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/updates/testing/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000

# KORORA REPOS, set to remote for release, local for testing
#repo --name="Korora %%KP_VERSION%% - Local Release" --baseurl=%%KP_REPOSITORY%%/releases/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=10
repo --name="Korora %%KP_VERSION%% - Local Testing" --baseurl=%%KP_REPOSITORY%%/testing/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=10
#repo --name="Korora %%KP_VERSION%%" --baseurl=http://dl.kororaproject.org/pub/korora/releases/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=100
#repo --name="Korora %%KP_VERSION%% - Testing" --baseurl=http://dl.kororaproject.org/pub/korora/testing/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=100

# Cisco
repo --name="Fedora %%KP_VERSION%% openh264 (From Cisco) - %%KP_BASEARCH%%" --baseurl=https://codecs.fedoraproject.org/openh264/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=100

#
# KP - development repositories
#repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%%" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/development/%%KP_VERSION%%/%%KP_BASEARCH%%/os/ --cost=1000

#repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%% Updates Released" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/updates/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000
#repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%% Updates Testing" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/updates/testing/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000

#repo --name="RPMFusion Free - Development" --baseurl=http://download1.rpmfusion.org/free/fedora/development/%%KP_VERSION%%/%%KP_BASEARCH%%/os/ --cost=1000
#repo --name="RPMFusion Non-Free - Development" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/development/%%KP_VERSION%%/%%KP_BASEARCH%%/os/ --cost=1000

# RAWHIDE - use when RPM Fusion has not yet branched (usually because fedora is still pre-beta)
repo --name="RPMFusion Free - Development" --baseurl=http://download1.rpmfusion.org/free/fedora/development/rawhide/%%KP_BASEARCH%%/os/ --cost=1000
repo --name="RPMFusion Non-Free - Development" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/development/rawhide/%%KP_BASEARCH%%/os/ --cost=1000

