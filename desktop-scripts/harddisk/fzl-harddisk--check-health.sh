#!/bin/bash

# This script checks the health of the hard disk using smartctl.
# It requires the smartmontools package to be installed.
# Usage: ./fzl-harddisk--check-health.sh [device]
# Example: ./fzl-harddisk--check-health.sh /dev/sda

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or use sudo."
    exit 1
fi

# Check if smartctl is installed
if ! command -v smartctl &> /dev/null; then
    echo "smartctl is not installed. Please install smartmontools package."
    echo "Run: sudo dnf install smartmontools"
    exit 1
fi

# Function to list available disks
list_disks() {
    echo "Available disks:"
    lsblk -d -o NAME,SIZE,TYPE,MODEL | grep -E 'disk|nvme'
}

# Check if a device is provided as an argument
if [ -z "$1" ]; then
    list_disks
    read -p "Enter the device name (e.g., /dev/sda, /dev/nvme0n1): " device
else
    device="$1"
fi

# Validate device input (remove partition numbers if present)
if [[ "$device" =~ ^/dev/[a-z]+[0-9]+$ ]]; then
    base_device=$(echo "$device" | sed 's/[0-9]*$//')
    echo "Note: SMART data is for entire disks. Using $base_device instead of $device."
    device=$base_device
fi

# Check if the device exists
if [ ! -b "$device" ]; then
    echo "Device $device does not exist."
    list_disks
    exit 1
fi

# Check if device supports SMART
if ! smartctl -i "$device" | grep -q "SMART support is:"; then
    echo "Device $device does not support SMART."
    exit 1
fi

# Check the health of the hard disk
echo -e "\nChecking health of $device..."
health_output=$(smartctl -H "$device")
echo "$health_output" | grep -i "test result\|health"

# Check the SMART attributes of the hard disk
echo -e "\nChecking important SMART attributes of $device..."
smartctl -A "$device" | grep -iE "reallocated|pending|offline|uncorrectable|errors|temperature|power_on_hours"

# Run a short test and show progress
echo -e "\nRunning short SMART self-test..."
smartctl -t short "$device"

# Get test progress
echo -e "\nTest progress (check again later with: smartctl -l selftest $device):"
smartctl -l selftest "$device" | grep -A 1 "Self-test execution status"

# Show remaining life for SSDs if available
if smartctl -i "$device" | grep -q "Solid State Device"; then
    echo -e "\nSSD specific information:"
    smartctl -A "$device" | grep -iE "wear_leveling|percent_lifetime_remaining|media_wearout_indicator"
fi
