#!/bin/bash

# fzl-harddisk--check-health.sh - Comprehensive storage device health and performance checker
# Version 2.1 - Fixed IOPS formatting and improved output

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run as root or use sudo.${NC}"
    exit 1
fi

# Verify dependencies
check_deps() {
    local missing=()
    for cmd in smartctl hdparm; do
        command -v "$cmd" &> /dev/null || missing+=("$cmd")
    done
    
    if [ ${#missing[@]} -gt 0 ]; then
        echo -e "${RED}Missing required: ${missing[*]}${NC}"
        echo "Install with: sudo dnf install smartmontools hdparm"
        exit 1
    fi
}
check_deps


# List disks with improved formatting
list_disks() {
    echo -e "\n${YELLOW}Available storage devices:${NC}"
    lsblk -d -o NAME,SIZE,TYPE,MODEL,ROTA | awk '
    BEGIN {printf "%-8s %-8s %-6s %-20s\n", "DEVICE", "SIZE", "TYPE", "MODEL"}
    $3 ~ /disk|nvme/ {
        type = ($5 == "1") ? "HDD" : "SSD";
        printf "%-8s %-8s %-6s %-20s\n", "/dev/"$1, $2, type, $4
    }'
}


# Device selection
if [ -z "$1" ]; then
    list_disks
    echo -e "\n${YELLOW}Note: Select the base device (e.g., /dev/sda, /dev/nvme0n1)${NC}"
    read -p "Enter device to check: " device
else
    device="$1"
fi


# Validate device
if [[ "$device" =~ ^/dev/[a-z]+[0-9]+$ ]]; then
    base_device="${device%%[0-9]*}"
    echo -e "${YELLOW}Note: Using base device ${base_device}${NC}"
    device="$base_device"
fi

[ -b "$device" ] || {
    echo -e "${RED}Error: Device $device not found${NC}"
    list_disks
    exit 1
}


# SMART check with better error handling
check_smart() {
    echo -e "\n${YELLOW}=== SMART Status Check ===${NC}"
    
    if ! smartctl -i "$device" | grep -q "SMART support is:"; then
        echo -e "${YELLOW}SMART not supported. Continuing with performance tests.${NC}"
        return 1
    fi

    # Enable SMART if disabled
    if smartctl -i "$device" | grep -q "SMART support is:.*Disabled"; then
        echo -e "${YELLOW}Enabling SMART...${NC}"
        smartctl -s on "$device"
    fi

    # Health status
    echo -e "\n${GREEN}SMART Health:${NC}"
    smartctl -H "$device" | grep -i "test result\|health"

    # Critical attributes
    echo -e "\n${GREEN}Critical Attributes:${NC}"
    smartctl -A "$device" | awk '/Reallocated|Pending|Offline|Uncorrectable|Errors|Temperature|Power_On/ {print}'

    # Run short test
    echo -e "\n${YELLOW}Running short self-test...${NC}"
    smartctl -t short "$device"
    echo -e "Check results later with: smartctl -l selftest $device"

    # SSD-specific
    if smartctl -i "$device" | grep -q "Solid State Device"; then
        echo -e "\n${GREEN}SSD Health:${NC}"
        smartctl -A "$device" | awk '/Wear_Leveling|Percent_Lifetime|Media_Wearout/ {print}'
    fi
}


# Performance tests with fixed IOPS formatting
run_perf_tests() {
    echo -e "\n${YELLOW}=== Performance Tests ===${NC}"
    
    # Clear caches
    echo -e "${YELLOW}Clearing caches...${NC}"
    sync && echo 3 > /proc/sys/vm/drop_caches

    # Read tests
    echo -e "\n${GREEN}Sequential Read:${NC}"
    hdparm -t --direct "$device" | awk '/Timing/ {print $5,$6}'

    echo -e "\n${GREEN}Cached Read:${NC}"
    hdparm -T "$device" | awk '/Timing/ {print $5,$6}'

    # SSD IOPS test with fixed formatting
    if [[ $(smartctl -i "$device" | grep -c "Solid State Device") -gt 0 ]]; then
        if command -v fio &> /dev/null && command -v jq &> /dev/null; then
            echo -e "\n${GREEN}Random IOPS (4K reads):${NC}"
            local iops=$(fio --name=random_read --filename="$device" --rw=randread \
                --bs=4k --iodepth=32 --runtime=5s --size=256m --ioengine=libaio \
                --direct=1 --gtod_reduce=1 --output-format=json 2>/dev/null | \
                jq -r '.jobs[0].read.iops_mean')
            
            # Format IOPS number properly
            if [[ $iops =~ ^[0-9.]+$ ]]; then
                printf "Average IOPS: ${YELLOW}%'.0f${NC}\n" "$iops"
            else
                echo -e "${RED}Error measuring IOPS${NC}"
            fi
        else
            echo -e "${YELLOW}Install fio and jq for IOPS testing:"
            echo "sudo dnf install fio jq"
        fi
    fi
}


# Main execution
echo -e "\n${YELLOW}=== Testing $device ===${NC}"
check_smart
run_perf_tests
echo -e "\n${YELLOW}=== Completed ===${NC}"
