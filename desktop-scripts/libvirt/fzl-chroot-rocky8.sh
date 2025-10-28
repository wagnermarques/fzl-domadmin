#!/bin/bash

# Stop execution if any command fails
set -e

#ensure this script must be run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi


# Define variables
rocky8chroot_rootdir=/root/chroot_rocky8


echo "Creating mount point directories if needed"
mkdir -p "$rocky8chroot_rootdir"/{dev,proc,sys,tmp,usr/share/terminfo}

cd "$rocky8chroot_rootdir"


echo "Mounting chroot directories"
mount -o rbind /dev dev
mount -t proc none proc
mount -o bind /sys sys
mount -o bind /tmp tmp

# Fix term info issues
mount --bind -o ro /usr/share/terminfo usr/share/terminfo

# Make network work
echo "Copying DNS configuration"
cp /etc/resolv.conf etc/resolv.conf

echo "Entering chroot environment"
chroot . /bin/bash -l

echo "Cleaning up mounts"
umount -l dev proc sys tmp usr/share/terminfo 2>/dev/null || true
