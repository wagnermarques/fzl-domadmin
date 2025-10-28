#!/bin/bash

# This script adds custom keyboard shortcuts to an Openbox configuration
# for an LXQt session (typically found on Fedora).
# It handles screenshots and launching applications/commands.

# --- Configuration ---
# The path to your Openbox configuration file.
CONFIG_FILE="$HOME/.config/openbox/lxqt-rc.xml"
# The backup file name.
BACKUP_FILE="$HOME/.config/openbox/lxqt-rc.xml.bak.$(date +%F-%T)"

# --- Dependency Check ---
# We need 'spectacle' for screenshots and 'xmlstarlet' to safely edit the XML config.
if ! command -v spectacle &> /dev/null || ! command -v xmlstarlet &> /dev/null; then
    echo "Some dependencies are missing."
    echo "This script requires 'spectacle' for screenshots and 'xmlstarlet' for safe configuration editing."
    read -p "Would you like to install them now? (y/N) " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        sudo dnf install spectacle xmlstarlet
    else
        echo "Installation aborted. Please install the dependencies and run the script again."
        exit 1
    fi
fi

# --- Safety First: Backup Configuration ---
if [ -f "$CONFIG_FILE" ]; then
    echo "Found configuration file. Creating backup at: $BACKUP_FILE"
    cp "$CONFIG_FILE" "$BACKUP_FILE"
else
    echo "Error: Configuration file not found at $CONFIG_FILE"
    exit 1
fi

# --- Function to Add a Keybind ---
# This function prevents adding duplicate shortcuts.
# Usage: add_keybind "KEY_COMBO" "COMMAND_TO_RUN"
add_keybind() {
    local key_combo="$1"
    local command_to_run="$2"
    local keybind_xml="<keybind key=\"$key_combo\"><action name=\"Execute\"><command>$command_to_run</command></action></keybind>"

    # Check if the keybind already exists
    if xmlstarlet sel -t -c "//keyboard/keybind[@key='$key_combo']" "$CONFIG_FILE" | grep -q key; then
        echo "Shortcut for '$key_combo' already exists. Skipping."
    else
        echo "Adding shortcut: '$key_combo' -> '$command_to_run'"
        # Add the new keybind just before the closing </keyboard> tag
        xmlstarlet ed --inplace --subnode "/openbox_config/keyboard" --type elem -n "keybind" \
            -v "" "$CONFIG_FILE"
        xmlstarlet ed --inplace --update "/openbox_config/keyboard/keybind[last()]" \
            --type attr -n "key" -v "$key_combo" "$CONFIG_FILE"
        xmlstarlet ed --inplace --subnode "/openbox_config/keyboard/keybind[@key='$key_combo']" \
            --type elem -n "action" -v "" "$CONFIG_FILE"
        xmlstarlet ed --inplace --update "/openbox_config/keyboard/keybind[@key='$key_combo']/action" \
            --type attr -n "name" -v "Execute" "$CONFIG_FILE"
        xmlstarlet ed --inplace --subnode "/openbox_config/keyboard/keybind[@key='$key_combo']/action" \
            --type elem -n "command" -v "$command_to_run" "$CONFIG_FILE"
    fi
}

# --- Define and Add Shortcuts ---
echo "--- Processing Shortcuts ---"

# Screenshot Shortcuts using Spectacle
# -f: fullscreen, -a: active window, -r: region
# -b: run in background, -n: no notification (spectacle's own)
add_keybind "Print" "spectacle -f -b -n"
add_keybind "A-Print" "spectacle -a -b -n"
add_keybind "S-Print" "spectacle -r -b -n"

# Application and Command Shortcuts
# W is the "Super" or "Windows" key.
add_keybind "W-t" "qterminal"
add_keybind "W-r" "bash -c 'notify-send \"Disk Usage\" \"$(df -h / | tail -n 1)\"'"

# --- Apply Changes ---
echo "--- Applying Configuration ---"
openbox --reconfigure

echo "🎉 Success! Your new shortcuts have been added and applied."
echo "Your original configuration was saved to $BACKUP_FILE"
