#!/bin/bash

function fzl-touchpad-enable-click-ou-tap(){
    # Find the touchpad ID
    touchpad_id=$(xinput list | grep -i touchpad | grep -o 'id=[0-9]*' | cut -d= -f2)
    
    # Find the property ID for "libinput Tapping Enabled"
    prop_id=$(xinput list-props "$touchpad_id" | grep "Tapping Enabled (" | grep -o '([0-9]*)' | tr -d '()')
    
    # Enable tap-to-click
    xinput set-prop "$touchpad_id" "$prop_id" 1
}
export -f fzl-touchpad-enable-click-ou-tap
