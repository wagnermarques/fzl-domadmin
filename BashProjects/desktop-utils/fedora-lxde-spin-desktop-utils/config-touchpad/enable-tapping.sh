#!/bin/bash
#needs dnf install xinput
#xinput list will list devices names
#xinput list-props <devide-name> will list device properties
#xinput set-prop "device-name" "property name" propValue
xinput set-prop "DELL0AB4:00 04F3:3147 Touchpad" "libinput Tapping Enabled" 1
