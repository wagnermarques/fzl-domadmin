#!/bin/bash

#stops execution if any command fails
set -e


#Define variables
rocky8chroot_dir=/mnt/rocky8_mnt
rocky8chroot_rootdir=/root/chroot_rocky8
rocky8Img_home_dir=/run/media/wgn/ext4/Projects-Srcs-Desktop/fzl-domadmin/shared/virt/
rocky8Img=Rocky-8-GenericCloud-Base.latest.x86_64.qcow2



# Create root chroot directory if it doesn't exist
# If it exists, clear its contents to ensure a fresh copy
echo "=>Mounting (if not mounted) Rocky Img in $rocky8chroot_dir "

if grep -q " $rocky8chroot_dir " /proc/mounts; then
    echo "=>Unmounting existing mount at $rocky8chroot_dir"
    sudo LIBGUESTFS_BACKEND=direct guestunmount "$rocky8chroot_dir" || sudo umount "$rocky8chroot_dir"
fi

# Create mount point if it doesn't exist
if [ ! -d "$rocky8chroot_dir" ]; then
    echo "=>Creating mount point $rocky8chroot_dir"
    sudo mkdir -p "$rocky8chroot_dir"
else
    echo "=>Mount point $rocky8chroot_dir already exists"
    # Clear any leftover files
    sudo rm -rf "$rocky8chroot_dir"/*
fi



echo "=>Making rock8Img_home_dir accessible"
sudo chmod o+rx -R $rocky8Img_home_dir
sudo chmod 644 "$rocky8Img_home_dir/$rocky8Img"  


echo "=>Mounting Rocky 8 img chroot environment at $rocky8chroot_dir"
# I've installed libvirt, LIBGUESTFS_BACKEND=direct is needed to avoid error:
sudo LIBGUESTFS_BACKEND=direct guestmount -a "$rocky8Img_home_dir/$rocky8Img" -i --ro "$rocky8chroot_dir"


echo "=>Copying Img Rocky 8 chroot environment to $rokcy8chroot_rootdir"
sudo rsync -auvp "$rocky8chroot_dir/" "$rocky8chroot_rootdir/"
