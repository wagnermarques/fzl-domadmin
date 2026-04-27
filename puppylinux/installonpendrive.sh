#!/bin/bash

# --- CONFIGURATION ---
# The target partition 
TARGET_DEV="/dev/sda1"
LABEL="PuppyDrive"

# FIXED: Using absolute path to avoid sudo/root path issues
ISO_PATH="/home/wgn/Downloads/TrixiePup32-Retro-2508-260401.iso"

INSTALL_DIR="trixiepup"
MNT_ISO="/mnt/pup_iso"
MNT_TARGET="/mnt/pup_target"

# 1. Check for root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)."
   exit 1
fi

# 2. Verify ISO exists before starting
if [[ ! -f "$ISO_PATH" ]]; then
    echo "ERROR: ISO not found at $ISO_PATH"
    echo "Please check if the filename or path is correct."
    exit 1
fi

echo "WARNING: This will format $TARGET_DEV and erase ALL data."
read -p "Are you sure you want to proceed? (y/N): " CONFIRM
if [[ $CONFIRM != "y" ]]; then
    echo "Aborted."
    exit 1
fi

# 3. Unmount and Format
echo "Unmounting $TARGET_DEV..."
umount $TARGET_DEV 2>/dev/null

echo "Formatting $TARGET_DEV to ext4..."
mkfs.ext4 -F -L "$LABEL" "$TARGET_DEV"

# 4. Create mount points and mount
echo "Mounting sources and targets..."
mkdir -p "$MNT_ISO" "$MNT_TARGET"

# Added error checking for the mount command
if ! mount -o loop "$ISO_PATH" "$MNT_ISO"; then
    echo "ERROR: Failed to mount ISO. Check if loop module is loaded."
    exit 1
fi

mount "$TARGET_DEV" "$MNT_TARGET"

# 5. Create the installation directory
echo "Creating directory /$INSTALL_DIR on the drive..."
mkdir -p "$MNT_TARGET/$INSTALL_DIR"

# 6. Copy the Puppy files
echo "Copying files to $TARGET_DEV..."
cp "$MNT_ISO/vmlinuz" "$MNT_TARGET/$INSTALL_DIR/"
cp "$MNT_ISO/initrd.gz" "$MNT_TARGET/$INSTALL_DIR/"
cp "$MNT_ISO/"*.sfs "$MNT_TARGET/$INSTALL_DIR/"

# 7. Clean up
echo "Syncing and unmounting..."
sync
umount "$MNT_ISO"
umount "$MNT_TARGET"

echo "-----------------------------------------------------------"
echo "DONE! Puppy Linux files are now on /dev/sda1."
echo "Your persistence (Save Folder) will be created on first boot."
echo "-----------------------------------------------------------"
