#repo --name=fedora --mirrorlist=http://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch
repo --name=fedora --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/development/$releasever/Everything/$basearch/os/
#repo --name=updates --mirrorlist=http://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch
repo --name=updates --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/updates/$releasever/$basearch
#repo --name=updates-testing --mirrorlist=http://mirrors.fedoraproject.org/metalink?repo=updates-testing-f$releasever&arch=$basearch
repo --name=updates-testing --baseurl=http://dl.fedoraproject.org/pub/fedora/linux/updates/testing/$releasever/$basearch
