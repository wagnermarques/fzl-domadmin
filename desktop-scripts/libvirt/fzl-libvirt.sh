#!/bin/bash
fzl-virsh-net-list() {
    # List all defined networks
    sudo virsh net-list --all
}
export -f fzl-virsh-net-list


fzl-virsh-net-info() {
    # Check if network name is provided
    if [ -z "$1" ]; then
        echo "Usage: fzl-virsh-net-info <network-name>"
        return 1
    fi

    # Get network information
    sudo virsh net-info "$1"
}
export -f fzl-virsh-net-info
