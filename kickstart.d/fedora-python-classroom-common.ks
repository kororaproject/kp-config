# Maintained by the Fedora Python SIG:
# http://fedoraproject.org/wiki/SIGs/Python
# mailto:python-devel@lists.fedoraproject.org

# Common packages of all Python Classroom images

%packages
@python-classroom
@python-science
nano
openssh-clients
vim-enhanced
wget

# Remove Pythons possibly recommended by tox
-python26
-python33
-python34
-python35
-pypy

%end
