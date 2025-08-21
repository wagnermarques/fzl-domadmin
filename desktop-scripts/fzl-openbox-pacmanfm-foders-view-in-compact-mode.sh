#!/bin/bash

# This script configures PCManFM to use the compact view mode by default.

# The most common configuration file path for PCManFM-Qt (used in LXQt)
CONFIG_FILE="$HOME/.config/pcmanfm-qt/lxqt/settings.conf"

# A fallback path for the GTK version (used in LXDE)
FALLBACK_CONFIG_FILE="$HOME/.config/pcmanfm/default/pcmanfm.conf"

# Determine which configuration file exists
if [ -f "$CONFIG_FILE" ]; then
    echo "Found PCManFM-Qt configuration file."
else
    if [ -f "$FALLBACK_CONFIG_FILE" ]; then
        CONFIG_FILE="$FALLBACK_CONFIG_FILE"
        echo "Found PCManFM (GTK) configuration file."
    else
        echo "Error: Could not find a PCManFM configuration file."
        exit 1
    fi
fi

# The setting we want to apply
DESIRED_SETTING="view_mode=compact"

# Check if the view_mode line already exists in the file
if grep -q "^view_mode=" "$CONFIG_FILE"; then
    # If it exists, replace its value with 'compact'
    sed -i "s/^view_mode=.*/$DESIRED_SETTING/" "$CONFIG_FILE"
    echo "Updated existing view_mode to 'compact'."
else
    # If it doesn't exist, add the line to the end of the file
    echo "$DESIRED_SETTING" >> "$CONFIG_FILE"
    echo "Added 'view_mode=compact' to the configuration."
fi

echo "Configuration complete!"
echo "Please restart PCManFM for the changes to take effect."
