# REPOS

# KP - production repositories

# Korora
# For local testing:
#repo --name="Korora %%KP_VERSION%% - Local" --baseurl=%%KP_REPOSITORY%%/releases/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=10
# For release:
repo --name="Korora %%KP_VERSION%%" --baseurl=http://dl.kororaproject.org/pub/korora/releases/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=10

# Fedora
repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%%" --baseurl=https://dl.fedoraproject.org/pub/fedora/linux/releases/%%KP_VERSION%%/Everything/%%KP_BASEARCH%%/os/ --cost=1000
repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%% - Updates" --baseurl=https://dl.fedoraproject.org/pub/fedora/linux/updates/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000
#repo --name="Fedora %%KP_VERSION%% - %%KP_BASEARCH%% - Updates Testing" --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/updates/testing/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000

# Cisco
repo --name="Fedora %%KP_VERSION%% openh264 (From Cisco) - %%KP_BASEARCH%%" --baseurl=https://codecs.fedoraproject.org/openh264/%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=100

# RPMFusion
repo --name="RPMFusion Free" --baseurl=http://download1.rpmfusion.org/free/fedora/releases/%%KP_VERSION%%/Everything/%%KP_BASEARCH%%/os --cost=1000
repo --name="RPMFusion Free - Updates" --baseurl=http://download1.rpmfusion.org/free/fedora/updates/%%KP_VERSION%%/%%KP_BASEARCH%% --cost=1000
repo --name="RPMFusion Non-Free" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/%%KP_VERSION%%/Everything/%%KP_BASEARCH%%/os --cost=1000
repo --name="RPMFusion Non-Free - Updates" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/updates/%%KP_VERSION%%/%%KP_BASEARCH%% --cost=1000

#url --baseurl=https://dl.fedoraproject.org/pub/fedora/linux/releases/%%KP_VERSION%%/Everything/%%KP_BASEARCH%%/os/
