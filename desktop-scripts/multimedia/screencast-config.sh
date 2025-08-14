#!/bin/bash

# Define variables for the screencast
OUTPUT_DIR="$HOME/Fzl/Screencasts"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILENAME="screencast_${TIMESTAMP}.mp4"
FULL_PATH="${OUTPUT_DIR}/${OUTPUT_FILENAME}"

# --- Video Settings ---
VIDEO_INPUT="x11grab"
DISPLAY_NUM=":1.0"
RESOLUTION="1920x1080"
VIDEO_CODEC="h264_vaapi"
VIDEO_BITRATE="4M"
FRAME_RATE="30"

# --- Audio Settings ---
AUDIO_INPUT="hw:1,0" 
AUDIO_CODEC="aac"
AUDIO_BITRATE="128k"
AUDIO_CHANNELS="2"
