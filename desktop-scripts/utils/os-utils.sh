#!/bin/bash

# ==============================================================================
# OS Detection Utilities
# Function: fzl-os-utils-detect-os
# Description: Detects the operating system and returns standardized OS identifiers
# Usage: fzl-os-utils-detect-os [option]
# Options:
#   --id       : Returns OS ID (ubuntu, debian, centos, etc.) [DEFAULT]
#   --name     : Returns OS full name (Ubuntu, Debian GNU/Linux, etc.)
#   --version  : Returns OS version (20.04, 11, 8, etc.)
#   --family   : Returns OS family (debian, rhel, arch, etc.)
#   --all      : Returns all OS info as key-value pairs
#   --json     : Returns OS info in JSON format
# ==============================================================================

function fzl-os-utils-detect-os() {
    local option="${1:---id}"
    local os_id="unknown"
    local os_name="Unknown"
    local os_version=""
    local os_family="unknown"
    local os_codename=""
    local os_like=""
    
    # Detect OS details
    if [ -f /etc/os-release ]; then
        # Source the os-release file
        . /etc/os-release
        
        os_id="$ID"
        os_name="$NAME"
        os_version="$VERSION_ID"
        os_codename="$VERSION_CODENAME"
        os_like="$ID_LIKE"
        
        # Determine OS family based on ID_LIKE or ID
        if [[ "$ID_LIKE" == *"debian"* ]] || [[ "$ID" == "ubuntu" ]] || [[ "$ID" == "debian" ]]; then
            os_family="debian"
        elif [[ "$ID_LIKE" == *"rhel"* ]] || [[ "$ID_LIKE" == *"fedora"* ]] || 
             [[ "$ID" == "centos" ]] || [[ "$ID" == "rhel" ]] || [[ "$ID" == "fedora" ]]; then
            os_family="rhel"
        elif [[ "$ID" == "arch" ]] || [[ "$ID_LIKE" == *"arch"* ]]; then
            os_family="arch"
        elif [[ "$ID" == "opensuse"* ]] || [[ "$ID_LIKE" == *"suse"* ]]; then
            os_family="suse"
        else
            os_family="$ID"
        fi
        
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        os_id="${DISTRIB_ID,,}"  # Convert to lowercase
        os_name="$DISTRIB_DESCRIPTION"
        os_version="$DISTRIB_RELEASE"
        os_codename="$DISTRIB_CODENAME"
        [[ "$os_id" == "ubuntu" ]] && os_family="debian"
        
    elif [ -f /etc/debian_version ]; then
        os_id="debian"
        os_name="Debian GNU/Linux"
        os_version=$(cat /etc/debian_version)
        os_family="debian"
        
    elif [ -f /etc/redhat-release ]; then
        os_id="rhel"
        os_name=$(cat /etc/redhat-release | sed 's/ release.*//')
        os_version=$(cat /etc/redhat-release | sed 's/.*release //; s/ .*//')
        os_family="rhel"
        
    elif [ -f /etc/arch-release ]; then
        os_id="arch"
        os_name="Arch Linux"
        os_family="arch"
        
    elif [ "$(uname -s)" = "Darwin" ]; then
        os_id="macos"
        os_name="macOS"
        os_version=$(sw_vers -productVersion)
        os_family="macos"
        
    elif [ "$(uname -s)" = "FreeBSD" ]; then
        os_id="freebsd"
        os_name="FreeBSD"
        os_version=$(uname -r)
        os_family="freebsd"
        
    else
        # Fallback to uname
        os_id=$(uname -s | tr '[:upper:]' '[:lower:]')
        os_name=$(uname -s)
        os_version=$(uname -r)
    fi
    
    # Output based on option
    case "$option" in
        --id)
            echo "$os_id"
            ;;
        --name)
            echo "$os_name"
            ;;
        --version)
            echo "$os_version"
            ;;
        --family)
            echo "$os_family"
            ;;
        --codename)
            echo "$os_codename"
            ;;
        --all)
            echo "ID: $os_id"
            echo "Name: $os_name"
            echo "Version: $os_version"
            echo "Family: $os_family"
            [ -n "$os_codename" ] && echo "Codename: $os_codename"
            [ -n "$os_like" ] && echo "ID_LIKE: $os_like"
            ;;
        --json)
            local json="{"
            json+="\"id\":\"$os_id\","
            json+="\"name\":\"$os_name\","
            json+="\"version\":\"$os_version\","
            json+="\"family\":\"$os_family\""
            [ -n "$os_codename" ] && json+=",\"codename\":\"$os_codename\""
            [ -n "$os_like" ] && json+=",\"id_like\":\"$os_like\""
            json+="}"
            echo "$json"
            ;;
        --help|-h)
            echo "Usage: fzl-os-utils-detect-os [OPTION]"
            echo "Options:"
            echo "  --id       : Returns OS ID (ubuntu, debian, centos, etc.)"
            echo "  --name     : Returns OS full name"
            echo "  --version  : Returns OS version"
            echo "  --family   : Returns OS family (debian, rhel, arch, etc.)"
            echo "  --codename : Returns OS codename (focal, bullseye, etc.)"
            echo "  --all      : Returns all OS info"
            echo "  --json     : Returns OS info in JSON format"
            echo "  --help     : Shows this help message"
            ;;
        *)
            echo "Unknown option: $option" >&2
            echo "Use --help for usage information" >&2
            return 1
            ;;
    esac
}
export -f fzl-os-utils-detect-os


# ==============================================================================
# Example usage and integration
# ==============================================================================

# Example 1: Simple detection in your script
#if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
#    # Script is being run directly
#    OS_TYPE=$(fzl-os-utils-detect-os --id)
#    
#    case "$OS_TYPE" in
#        ubuntu|debian|linuxmint|pop)
#            echo "Debian-based system detected"
#            # Your Debian/Ubuntu specific commands
#            ;;
#        centos|rhel|fedora|rocky|almalinux)
#            echo "RHEL-based system detected"
#            # Your RHEL/CentOS specific commands
#            ;;
#        arch|manjaro)
#            echo "Arch Linux based system detected"
#            # Arch specific commands
#            ;;
#        macos)
#            echo "macOS detected"
#            # macOS specific commands
#            ;;
#        opensuse*)
#            echo "openSUSE/SLES detected"
#            # SUSE specific commands
#            ;;
#        *)
#            echo "Unsupported OS: $OS_TYPE"
#            # Show full info for debugging
#            fzl-os-utils-detect-os --all
#            exit 1
#            ;;
#    esac
#fi

# Example 2: Using in another script
# Just source this file and call the function:
# source os-utils.sh
# 
# if [[ $(fzl-os-utils-detect-os --family) == "debian" ]]; then
#     apt-get update
# elif [[ $(fzl-os-utils-detect-os --family) == "rhel" ]]; then
#     yum update
# fi
