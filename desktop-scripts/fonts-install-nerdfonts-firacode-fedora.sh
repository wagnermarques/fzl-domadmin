#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Define the download URL for the FiraMono Nerd Font.
# This URL is the one you provided.
FONT_URL="https://release-assets.githubusercontent.com/github-production-release-asset/27574418/f66c1095-97c5-4093-84f4-927c7cfb982c?sp=r&sv=2018-11-09&sr=b&spr=https&se=2025-08-11T12%3A59%3A30Z&rscd=attachment%3B+filename%3DFiraMono.zip&rsct=application%2Foctet-stream&skoid=96c2d410-5711-43a1-aedd-ab1947aa7ab0&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skt=2025-08-11T11%3A59%3A03Z&ske=2025-08-11T12%3A59%3A30Z&sks=b&skv=2018-11-09&sig=YsyEbxYrO7byQo4R9PgmKFixySsth6zZt39nWgs6eso%3D&jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmVsZWFzZS1hc3NldHMuZ2l0aHVidXNlcmNvbnRlbnQuY29tIiwia2V5Ijoia2V5MSIsImV4cCI6MTc1NDkxNDEwNCwibmJmIjoxNzU0OTEzODA0LCJwYXRoIjoicmVsZWFzZWFzc2V0cHJvZHVjdGlvbi5ibG9iLmNvcmUud2luZG93cy5uZXQifQ.0sXNJH90pxYSlMG_VyFKvde1Ah_V9npk0hTe6M1VqSE&response-content-disposition=attachment%3B%20filename%3DFiraMono.zip&response-content-type=application%2Foctet-stream"

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
