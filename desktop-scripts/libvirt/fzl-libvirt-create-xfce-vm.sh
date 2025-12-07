#!/bin/bash
set -e

#================================================================
# CREATE LIGHTWEIGHT DEBIAN 12 + XFCE VIRTUAL MACHINE
#
# This script uses virt-install to create a new Debian 12 VM
# with the XFCE desktop environment.
#
# It is configured to support running Docker inside the VM
# by enabling nested virtualization.
#
# Author: Gemini
# Date: 2025-11-21
#================================================================

# --- Configuration ---
# --- Feel free to change these values ---

# VM and OS Details
VM_NAME="debian-xfce-docker"
OS_VARIANT="debian12" # Use 'virsh osinfo-query os' to see options

# VM Resources
VCPUS="2"
RAM_MB="4096" # 4 GB
DISK_SIZE_GB="30"

# Paths and Storage
# An up-to-date Debian "netinst" ISO is recommended.
# You can find the latest URL here: https://www.debian.org/distrib/netinst
ISO_PATH="/var/lib/libvirt/images/debian-13.2.0-amd64-netinst.iso" 
DISK_POOL_PATH="/var/lib/libvirt/images/${VM_NAME}"
DISK_PATH="${DISK_POOL_PATH}/${VM_NAME}.qcow2"

# Shared Folder
# This directory will be created on your HOST machine and shared with the GUEST.
SHARED_FOLDER_HOST_PATH="${HOME}/shared/${VM_NAME}"
# This is the tag the guest OS will use to identify the share.
SHARED_FOLDER_GUEST_TAG="host_share"

# --- End of Configuration ---


# --- Pre-flight Checks ---
echo "--- Running Pre-flight Checks ---"

# Check for required commands
for cmd in virt-install virsh qemu-img; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: '$cmd' command not found. Please install libvirt-client and qemu-img."
        exit 1
    fi
done

# Check for libvirt group membership
if ! groups | grep -q '\blibvirt\b'; then
    echo "Warning: You are not in the 'libvirt' group."
    echo "You may need to run this script with 'sudo' or add your user to the group:"
    echo "  sudo usermod -aG libvirt $(whoami)"
    echo "  (You will need to log out and back in for the group change to take effect)"
fi

# Check for ISO file
if [ ! -f "$ISO_PATH" ]; then
    echo "Error: ISO file not found at '$ISO_PATH'."
    echo "Please download the Debian 12 netinst ISO and place it there, or update the ISO_PATH variable."
    echo "Download from: https://www.debian.org/distrib/netinst"
    exit 1
fi

echo "All checks passed."
echo ""


# --- Setup ---
echo "--- Setting up Host Directories ---"

# Create directories for the disk and shared folder
mkdir -p "$DISK_POOL_PATH"
mkdir -p "$SHARED_FOLDER_HOST_PATH"

echo "Created disk pool directory: $DISK_POOL_PATH"
echo "Created shared folder on host: $SHARED_FOLDER_HOST_PATH"
echo ""


# --- VM Creation ---
echo "--- Starting VM Installation ---"
echo "This will launch the Debian installer in a new window."
echo "See the post-installation instructions printed below."
echo ""

virt-install \
    --name "${VM_NAME}" \
    --os-variant "${OS_VARIANT}" \
    --vcpus "${VCPUS}" \
    --ram "${RAM_MB}" \
    --disk path="${DISK_PATH}",size="${DISK_SIZE_GB}",format=qcow2,bus=virtio \
    --network network=default,model=virtio \
    --graphics spice,listen=none \
    --video virtio \
    --channel spicevmc \
    --sound ich9 \
    --controller type=usb,model=ehci \
    --cdrom "${ISO_PATH}" \
    # Crucial for running Docker/KVM inside the VM
    --cpu host-passthrough \
    # Filesystem sharing configuration
    --filesystem source="${SHARED_FOLDER_HOST_PATH}",target="${SHARED_FOLDER_GUEST_TAG}",type=mount,accessmode=passthrough \
    --noautoconsole \
    --wait -1

# --- Post-Installation Instructions ---
echo "------------------------------------------------------------------"
echo "--- VM Installation Started ---"
echo "------------------------------------------------------------------"
echo ""
echo "A virt-viewer window should have opened with the Debian installer."
echo "If not, open it manually: virt-viewer --connect qemu:///system --wait ${VM_NAME}"
echo ""
echo "Follow these steps to complete the setup:"
echo ""
echo "1.  **Complete the Debian Installation:**"
echo "    - Proceed through the standard installation."
echo "    - At the 'Software selection' screen, DE-SELECT 'Debian desktop environment' and 'GNOME'."
echo "    - SELECT 'Xfce' and 'SSH server'."
echo ""
echo "2.  **First Boot into XFCE:**"
echo "    - Log in to your new XFCE desktop."
echo "    - Open a terminal for the next steps."
echo ""
echo "3.  **Install Guest Tools:**"
echo "    - For better performance, clipboard sharing, and dynamic resizing:"
echo "    sudo apt update"
echo "    sudo apt install -y spice-vdagent"
echo ""
echo "4.  **Mount the Shared Folder:**"
echo "    - Create a mount point in the guest VM:"
echo "    sudo mkdir -p /mnt/host"
echo ""
echo "    - Add the following line to '/etc/fstab' in the guest VM to auto-mount on boot:"
echo "    echo '${SHARED_FOLDER_GUEST_TAG} /mnt/host 9p trans=virtio,version=9p2000.L,msize=104857600 0 0' | sudo tee -a /etc/fstab"
echo ""
echo "    - Mount it now:"
echo "    sudo mount /mnt/host"
echo "    - You can now access your host's '${SHARED_FOLDER_HOST_PATH}' directory from '/mnt/host' in the VM."
echo ""
echo "5.  **Install Docker in the VM:**"
echo "    - Follow the official Docker guide for Debian:"
echo "    https://docs.docker.com/engine/install/debian/"
echo ""
echo "------------------------------------------------------------------"
echo "Script finished. Your VM is being created."
echo "------------------------------------------------------------------"
