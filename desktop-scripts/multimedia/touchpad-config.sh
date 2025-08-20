#!/bin/bash

# --- My Touchpad Settings ---

# Set the device name from your xinput list output
DEVICE_NAME="ASUE1200:00 04F3:3288 Touchpad"

# Enable Tap to Click (1 = enabled, 0 = disabled)
xinput set-prop "$DEVICE_NAME" "libinput Tapping Enabled" 1

# Optional: Enable Natural (Reverse) Scrolling
# xinput set-prop "$DEVICE_NAME" "libinput Natural Scrolling Enabled" 1
