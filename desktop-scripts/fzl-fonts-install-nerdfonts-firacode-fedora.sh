#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Define the download URL for the FiraMono Nerd Font.
# This URL is the one you provided.
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip"

# Define the installation directory
FONT_DIR="$HOME/.local/share/fonts"

# Define the temporary directory for download and extraction
TEMP_DIR=$(mktemp -d)

echo "===> Installing Nerd Font"

# Create the fonts directory if it doesn't exist
echo "  • Creating font directory: $FONT_DIR"
mkdir -p "$FONT_DIR"

# Download the font file
echo "  • Downloading font from URL..."
wget -O "$TEMP_DIR/FiraMono.zip" "$FONT_URL"

# Unzip the font files
echo "  • Unzipping font files to $FONT_DIR"
unzip "$TEMP_DIR/FiraMono.zip" -d "$FONT_DIR"

# Clean up the temporary directory
echo "  • Cleaning up temporary files"
rm -rf "$TEMP_DIR"

# Update the font cache
echo "  • Updating font cache..."
fc-cache -fv

# Verify the installation (optional)
echo "  • Verifying FiraMono installation..."
fc-list | grep -i "FiraMono"

echo "===> Nerd Font installation complete!"
