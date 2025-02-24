#!/bin/bash
#after install brightnessctl
#ps -ef | grep Xorg

brightnessctl set $1

#sudo xbacklight -d /sys/class/backlight/amdgpu_bl0 -set $1
#xbacklight does not worked
