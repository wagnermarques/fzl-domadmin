#!/bin/bash

source screencast-config.sh

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

echo "Starting screencast recording..."
echo "Output file: ${FULL_PATH}"
echo "Press 'q' in the terminal to stop recording."

# --- Corrected FFmpeg Command ---
# -vaapi_device: Specifies the GPU render node for VAAPI.
# -f x11grab ... -i $DISPLAY_NUM: Captures the screen from the specified X11 display.
# -f alsa ... -i $AUDIO_INPUT: Captures audio from the specified ALSA device.
# -vf 'format=nv12,hwupload': This is the crucial fix.
#   1. 'format=nv12': Converts the video stream's pixel format to nv12 (on the CPU).
#   2. 'hwupload': Uploads the now-compatible nv12 frames to the GPU.
# -c:v $VIDEO_CODEC: Uses the VAAPI hardware encoder for H.264 video.
ffmpeg -vaapi_device /dev/dri/renderD128 \
       -f "$VIDEO_INPUT" -s "$RESOLUTION" -r "$FRAME_RATE" -i "$DISPLAY_NUM" \
       -f alsa -i "$AUDIO_INPUT" \
       -vf 'format=nv12,hwupload' \
       -c:v "$VIDEO_CODEC" -b:v "$VIDEO_BITRATE" \
       -c:a "$AUDIO_CODEC" -b:a "$AUDIO_BITRATE" -ac "$AUDIO_CHANNELS" \
       -y "$FULL_PATH"

if [ $? -eq 0 ]; then
    echo "Screencast recording finished successfully."
    echo "File saved to: ${FULL_PATH}"
else
    echo "Conversion failed! Please check the FFmpeg output above for errors."
fi
