#!/bin/bash

#deps
#libvdpau-va-gl.x86_64 : VDPAU driver with OpenGL/VAAPI back-end
#libvdpau : Wrapper library for the Video Decode and Presentation API


outputFileName=$1;

function record_audio(){
    echo "[Capturing for screencast..."
    #ffmpeg -f alsa -i hw:1 -r 30 -f x11grab -s $(xdpyinfo | grep 'dimensions:'|awk '{print $2}') -i $DISPLAY -c:v libx264rgb -crf 0 -preset:v ultrafast -c:a pcm_s16le -af aresample=async=1:first_pts=0
    ffmpeg -f alsa -ac 2 -i hw:1 \
           -f x11grab -r 30 -s $(xdpyinfo | grep dimensions | awk '{print $2}') -i :0.0 \
           -acodec pcm_s16le \
           -vcodec libx264 \
           -preset ultrafast -crf 0 -threads 0 output.mkv
}

record_audio
 


