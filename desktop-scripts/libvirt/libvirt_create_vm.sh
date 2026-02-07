#!/bin/bash
echo '###> Libvirt Alpine VM Creation Script - System Mode'

# ==============================================================================
# Libvirt Alpine VM Creation Script - System Mode (Fixed)
#
# Description:
# This script automates the creation of an Alpine Linux virtual machine
# using virt-install and libvirt in system mode for better network integration.
# Customize the VM by changing the variables in the section below.
#
# Prerequisites:
# - libvirt and KVM installed and running.
# - virt-install (from the virt-manager or virtinst package) installed.
# - An Alpine Linux ISO image downloaded to your local machine.
# - A libvirt network named 'vm-sys-network' created in system mode.
#
# ==============================================================================



# --- Load Environment Variables ---
# This section assumes you have a 'libvirt_env_vars.sh' file in the same
# directory to define your custom paths.
if [ -f "./libvirt_env_vars.sh" ]; then
    echo "###> Loading environment variables from libvirt_env_vars.sh"
    source ./libvirt_env_vars.sh
else
    echo "###> [WARNING]: libvirt_env_vars.sh not found. Using default paths."
    # Define default paths if the file is missing
    VAR_LIB_LIBVIRT_IMAGES="/var/lib/libvirt/images"
    ISO_PATH_HOME="/var/lib/libvirt/boot"
fi



##### VM CONFIGURATION VARIABLES #####
#ISO_PATH="${ISO_PATH_HOME}/alpine-extended-3.22.1-x86_64.iso"
#VM_NAME="alpine-vm"         # Name for the new virtual machine


ISO_PATH="${ISO_PATH_HOME}/lubuntu-24.04.3-desktop-amd64.iso"
VM_NAME="alpine-vm"         # Name for the new virtual machine


VCPUS="1"                   # Number of virtual CPUs
RAM_MB="1024"               # Amount of RAM in Megabytes (e.g., 1024 for 1GB)

# Disk Configuration
DISK_PATH=${VAR_LIB_LIBVIRT_IMAGES}
DISK_FILENAME="${VM_NAME}.qcow2"    # The filename for the virtual disk.
DISK_SIZE_GB="10"                   # Size of the virtual disk in Gigabytes.


# Networking
# Connects the VM to a pre-defined system network.
NETWORK_NAME="vm-sys-network"



# --- Script Logic ---
# Function to print error messages and exit
function error_exit {
    echo "ERROR: $1" >&2
    exit 1
}


#echo .
#echo .
#echo '1. VERIFY PRE-REQUISITES AND ENVIRONMENT'
#echo '[INFO] Checking for required tools (sudo, virt-install)...'
#command -v sudo >/dev/null 2>&1 || error_exit "'sudo' is not installed or not in your PATH."
#command -v sudo virt-install >/dev/null 2>&1 || error_exit "'virt-install' is not installed. Please install the 'virt-inst' package."


echo "[INFO] Checking if ISO file exists at: ${ISO_PATH}"
if [ ! -f "$ISO_PATH" ]; then
    error_exit "Alpine ISO not found at '${ISO_PATH}'. Please check the path."
fi

echo "[INFO] Checking if disk storage path exists: ${DISK_PATH}"
if [ ! -d "$DISK_PATH" ]; then
    error_exit "Disk storage directory '${DISK_PATH}' does not exist. Please create it or change the path."
fi

echo "[INFO] Checking if network '${NETWORK_NAME}' exists in system mode..."
if ! sudo virsh net-info "${NETWORK_NAME}" >/dev/null 2>&1; then
    error_exit "Network '${NETWORK_NAME}' not found in system mode. Please create it first."
fi

#echo "[INFO] Checking if network '${NETWORK_NAME}' is active..."
if ! sudo virsh net-is-active "${NETWORK_NAME}" >/dev/null 2>&1; then
    echo "[ACTION] Network is not active. Starting '${NETWORK_NAME}'..."
    sudo virsh net-start "${NETWORK_NAME}" || error_exit "Failed to start network '${NETWORK_NAME}'"
    echo "[SUCCESS] Network started."
else
    echo "[INFO] Network '${NETWORK_NAME}' is already active."
fi



FULL_DISK_PATH="${DISK_PATH}/${DISK_FILENAME}"
echo "[INFO] Checking if a disk file already exists at: ${FULL_DISK_PATH}"
if [ -f "$FULL_DISK_PATH" ]; then
    error_exit "A disk file already exists at '${FULL_DISK_PATH}'. Please remove it or change the VM_NAME."
fi

echo "[INFO] Checking if VM '${VM_NAME}' is already defined..."
if sudo virsh dominfo "${VM_NAME}" >/dev/null 2>&1; then
    error_exit "VM '${VM_NAME}' is already defined. Please remove it first with: sudo virsh undefine ${VM_NAME} --nvram"
fi



echo .
echo .

echo "[ACTION] Creating a new virtual disk..."
echo "         - Path: ${FULL_DISK_PATH}"
echo "         - Size: ${DISK_SIZE_GB}G"
sudo qemu-img create -f qcow2 "${FULL_DISK_PATH}" "${DISK_SIZE_GB}G"
if [ $? -ne 0 ]; then
    error_exit "Failed to create the qcow2 disk image."
fi
echo "[SUCCESS] Virtual disk created successfully."

echo .
echo .
echo '# 3. Run virt-install to create the VM (System Mode)'
echo '[ACTION] Starting VM installation with virt-install (system mode)...'
# NOTE: Using 'e1000e' model for the network card to ensure compatibility with the Alpine installer.
#     --network network="${NETWORK_NAME}",model=virtio \
#     --extra-args 'console=ttyS0,115200n8 serial' \    
sudo virt-install \
    --connect qemu:///system \
    --name "${VM_NAME}" \
    --vcpus "${VCPUS}" \
    --ram "${RAM_MB}" \
    --disk path="${FULL_DISK_PATH}",format=qcow2,bus=virtio \
    --network network="${NETWORK_NAME}",model=e1000e \
    --os-variant alpinelinux3.18 \
    --graphics none \
    --console pty,target_type=serial \
    --cdrom "${ISO_PATH}" \
    --boot cdrom,hd,menu=on

# Check if virt-install succeeded
if [ $? -ne 0 ]; then
    error_exit 'virt-install command failed. The VM may not have been created.'
fi

echo ' '
echo '--- VM Creation Process Initiated ---'
echo '[SUCCESS] The installer has started. A console window should appear for you to complete the Alpine Linux installation.'
echo ' '
echo '[POST-INSTALLATION] After completing Alpine setup:'
echo '          - Connect to console: sudo virsh console ${VM_NAME}'
echo '          - Start VM: sudo virsh start ${VM_NAME}'
echo '          - Stop VM: sudo virsh shutdown ${VM_NAME}'

exit 0
