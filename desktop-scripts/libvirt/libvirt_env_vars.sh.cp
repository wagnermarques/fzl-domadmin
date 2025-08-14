#!/bin/bash

# ==============================================================================
# Libvirt Alpine VM Creation Script
#
# Description:
# This script automates the creation of an Alpine Linux virtual machine
# using virt-install and libvirt. Customize the VM by changing the
# variables in the section below.
#
# Prerequisites:
# - libvirt and KVM installed and running.
# - virt-install (from the virt-manager or virtinst package) installed.
# - An Alpine Linux ISO image downloaded to your local machine.
#
# ==============================================================================

echo " ###> --- Configuration Variables (Customize these settings) --- "
echo " ###> Defining libvirt env vars"
source ./libvirt_env_vars.sh
echo "VAR_LIB_LIBVIRT_IMAGES=${VAR_LIB_LIBVIRT_IMAGES}"
echo "ISO_PATH_HOME=${ISO_PATH_HOME}"
echo .
echo .

# VM Definition
VM_NAME="alpine-vm"         # Name for the new virtual machine
VCPUS="1"                   # Number of virtual CPUs
RAM_MB="1024"               # Amount of RAM in Megabytes (e.g., 1024 for 1GB)

# Storage Configuration
# Directory to store the virtual disk.
# Ensure this path exists and has correct permissions.
DISK_PATH=${VAR_LIB_LIBVIRT_IMAGES} 
DISK_FILENAME="${VM_NAME}.qcow2"    # The filename for the virtual disk.
DISK_SIZE_GB="10"                   # Size of the virtual disk in Gigabytes.

# Installation Media
# IMPORTANT: Update this path to point to your downloaded Alpine ISO file.
ISO_PATH="${ISO_PATH_HOME}/alpine-extended-3.22.1-x86_64.iso"

# Networking
# Connects the VM to the default libvirt bridge.
# Use 'virsh net-list --all' to see available networks.
#NETWORK_BRIDGE="virbr0"
NETWORK_NAME="vm-network"


# --- End of Configuration ---


# --- Script Logic ---

# Function to print error messages and exit
function error_exit {
    echo "ERROR: $1" >&2
    exit 1
}

echo "--- Starting Alpine VM Creation Script ---"

# 1. Prerequisite Checks
echo "[INFO] Checking for required tools (virt-install)..."
command -v virt-install >/dev/null 2>&1 || error_exit "'virt-install' is not installed. Please install the 'virt-inst' or a similar package."

echo "[INFO] Checking if ISO file exists at: ${ISO_PATH}"
if [ ! -f "$ISO_PATH" ]; then
    error_exit "Alpine ISO not found at '${ISO_PATH}'. Please update the ISO_PATH variable in this script."
fi

echo "[INFO] Checking if disk storage path exists: ${DISK_PATH}"
if [ ! -d "$DISK_PATH" ]; then
    error_exit "Disk storage directory '${DISK_PATH}' does not exist. Please create it or change the DISK_PATH variable."
fi

FULL_DISK_PATH="${DISK_PATH}/${DISK_FILENAME}"
echo "[INFO] Checking if a disk already exists at: ${FULL_DISK_PATH}"
if [ -f "$FULL_DISK_PATH" ]; then
    error_exit "A disk file already exists at '${FULL_DISK_PATH}'. Please remove it or change the VM_NAME."
fi


# 2. Create the Virtual Disk Image
echo "[ACTION] Creating a new virtual disk..."
echo "         - Path: ${FULL_DISK_PATH}"
echo "         - Size: ${DISK_SIZE_GB}G"
qemu-img create -f qcow2 "${FULL_DISK_PATH}" "${DISK_SIZE_GB}G"
if [ $? -ne 0 ]; then
    error_exit "Failed to create the qcow2 disk image."
fi
echo "[SUCCESS] Virtual disk created successfully."


# 3. Run virt-install to create the VM
echo "[ACTION] Starting VM installation with virt-install..."
virt-install \
    --name "${VM_NAME}" \
    --vcpus "${VCPUS}" \
    --ram "${RAM_MB}" \
    --disk path="${FULL_DISK_PATH}",format=qcow2,bus=virtio \
    --network network="${NETWORK_NAME}",model=virtio \
    --os-variant alpinelinux3.18 \
    --graphics none \
    --console pty,target_type=serial \
    --cdrom "${ISO_PATH}" \
    --boot cdrom,hd,menu=on

# Check if virt-install succeeded
if [ $? -ne 0 ]; then
    error_exit "virt-install command failed. The VM may not have been created."
fi

echo "--- VM Creation Process Initiated ---"
echo "[SUCCESS] The installer has started. A console window should appear for you to complete the Alpine Linux installation."
echo "          Once installation is complete, the VM will reboot from the virtual hard disk."
echo "          You can connect to the console later using: 'virsh console ${VM_NAME}'"

exit 0
