#!/bin/bash

xrandr --output "eDP" --auto --output "HDMI-A-0" --same-as "eDP"

#xrandr --output  --auto

#xrandr | awk '/ connected/{print $1}' | while read output;
#do
#  if [ "$(xrandr | awk '/ connected/{print $1}' | wc -l)" -eq 1 ]; then
#    xrandr --output "$output" --auto
#  else
#    xrandr --output "$output" --auto --primary --output "$(xrandr | awk '/ connected/{print $1}' | tail -n 1)" --auto --
