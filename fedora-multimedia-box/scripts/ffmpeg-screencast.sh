#!/bin/bash

outFileNameWithExtension=$1
videoSize=1024x768
frameRate=25
videoDevice=x11grab #https://ffmpeg.org/ffmpeg-devices.html#x11grab
videoInput=:0.0+100,200
audioInput=hw:0
audioDevice=alsa
ffmpeg -video_size "$videoSize" \
       -framerate "$frameRate" \
       -f "$videoDevice" \
       -s $(xrandr | grep '\*\+' | awk '{print $1}') \
       -i "$input" \
       -f "$audioDevice" \
       -ac 2 \
       -i "$audioInput"  \
       "$outFileNameWithExtension"
