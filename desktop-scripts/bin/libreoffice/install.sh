#!/bin/bash

# LibreOffice Tarball Installer Script
# This script downloads, installs, and configures LibreOffice from a tarball

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "[./bin/libreoffice/install] running..."

function echoerr() { echo "$RED $@" 1>&2; }
function echoout() { echo "$GREN [./bin/libreoffice/install] | $@"; }

echo .
echoout "===== Setup paths and source utils ====="

# get this script path
_THIS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo _THIS_PATH=$_THIS_PATH


echoout "===== Configuration variables ====="
LIBREOFFICE_VERSION="24.2.4"
ARCH="x86-64"
DOWNLOAD_BASE="https://download.documentfoundation.org/libreoffice/stable"
PROGSATIVOS_DIR="/run/media/wgn/libvirt_btrfs/progsativos"
INSTALL_DIR="$PROGSATIVOS_DIR/libreoffice"
DESKTOP_ENTRIES_DIR="$HOME/.local/share/applications"
BIN_DIR="$HOME/bin"

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}
