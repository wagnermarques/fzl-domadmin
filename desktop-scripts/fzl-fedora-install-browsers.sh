#!/bin/bash
#
# This script installs Google Chrome, Microsoft Edge, and Chromium on Fedora.
# It automatically installs dnf-plugins-core if it's missing.

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Colors for output ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# --- Prerequisite: Install DNF Core Plugins ---
# This provides the 'config-manager' functionality needed for adding repositories.
echo -e "${YELLOW}Ensuring DNF core plugins are installed...${NC}"
sudo dnf install -y dnf-plugins-core

# --- Update System ---
echo -e "\n${YELLOW}Updating system packages...${NC}"
sudo dnf update -y

# --- Install Chromium ---
# Chromium is available in the default Fedora repositories.
echo -e "\n${GREEN}Installing Chromium Browser...${NC}"
sudo dnf install -y chromium

# --- Install Google Chrome ---
echo -e "\n${GREEN}Installing Google Chrome Stable...${NC}"
echo -e "${YELLOW}Adding Google Chrome repository...${NC}"
# Create the repository file
sudo tee /etc/yum.repos.d/google-chrome.repo > /dev/null <<'EOF'
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF
# Install the package
sudo dnf install -y google-chrome-stable

# --- Install Microsoft Edge ---
echo -e "\n${GREEN}Installing Microsoft Edge Stable...${NC}"
echo -e "${YELLOW}Adding Microsoft Edge repository...${NC}"
# Import the Microsoft GPG key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
# Add the repository using dnf's config-manager
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge/microsoft-edge.repo
# Install the package
sudo dnf install -y microsoft-edge-stable

# --- Final Message ---
echo -e "\n${GREEN}Installation complete! ✅${NC}"
echo "You can now find Chrome, Edge, and Chromium in your applications menu."
