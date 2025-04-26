
KERN=${1:-$(ls /usr/src/kernels | head --lines=1)}
MOK_KEY=${2:-/var/lib/dkms/mok.key}
MOK_DER=${3:-/var/lib/dkms/mok.der }

set -e

echo "Installing RPM FUsion"
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

echo "Installing Virtualbox"
dnf install -y VirtualBox

echo "Building virtualbox kmod for $KERN"
akmods --force --kernels $KERN --akmod VirtualBox


echo "Listing vbox modules:"
ls -l /usr/lib/modules/$KERN/extra/VirtualBox

# echo "Signing kmod"
# echo "MOK_KEY: $MOK_KEY"
# echo "MOK_DER: $MOK_DER"

# find "/usr/lib/modules/$KERN/extra/VirtualBox/" -type f | xargs -n1 \
#     /usr/src/kernels/$KERN/scripts/sign-file sha256 $MOK_KEY $MOK_DER

echo "Removing rpmfusion"
dnf remove -y rpmfusion-free-release