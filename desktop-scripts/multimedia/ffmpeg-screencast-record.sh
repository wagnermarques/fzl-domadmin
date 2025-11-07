#!/bin/bash

echo "------------------------------"
echo "starting.. fzl-ffmpeg-screencast-record..."
echo "------------------------------"

# --- Define output file with timestamp ---
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
# Use .mkv for crash-safe recording.
OUTPUT_FILENAME="screencast_${TIMESTAMP}.mkv"
OUTPUT_DIR="$HOME/Screencasts"
FULL_PATH="${OUTPUT_DIR}/${OUTPUT_FILENAME}"

# --- Auto-detect Video Settings ---
VIDEO_INPUT_FORMAT="x11grab"  # This is the correct format for X11
DISPLAY_NUM="$DISPLAY"        # This gets your current display (e.g., :0)
RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')

# --- Define Video Codec Settings ---
VIDEO_CODEC="h264_vaapi"
VIDEO_BITRATE="4M"
FRAME_RATE="30"

# --- Auto-detect and Select Audio Source ---
echo "Detecting microphone sources..."

# Get a list of microphone sources, excluding monitors
mapfile -t MIC_SOURCES < <(pactl list sources short | grep 'alsa_input' | grep -v '.monitor' | awk '{print $2}')

if [ ${#MIC_SOURCES[@]} -eq 0 ]; then
    echo "No microphone sources found. Exiting."
    exit 1
elif [ ${#MIC_SOURCES[@]} -eq 1 ]; then
    # Only one mic found, use it automatically
    AUDIO_INPUT=${MIC_SOURCES[0]}
    echo "Using the only available microphone: $AUDIO_INPUT"
else
    # Multiple mics found, present a selection menu
    echo "Please select the microphone to use:"
    select choice in "${MIC_SOURCES[@]}"; do
        if [[ -n "$choice" ]]; then
            AUDIO_INPUT=$choice
            break
        else
            echo "Invalid selection. Please try again."
        fi
    done
fi

echo "Selected audio source: $AUDIO_INPUT"

# --- Set Mic Volume to 100% ---
pactl set-source-volume "$AUDIO_INPUT" 100%

# --- Define Audio Codec Settings ---
AUDIO_CODEC="aac"
AUDIO_BITRATE="128k"
AUDIO_CHANNELS="2"

# --- Print settings to user ---
echo "Resolution: ${RESOLUTION}"
echo "Audio Source: ${AUDIO_INPUT}"
echo "Video Source: ${DISPLAY_NUM}"
echo "Output file: ${FULL_PATH}"
echo "Video Codec: ${VIDEO_CODEC}"
echo "Video Bitrate: ${VIDEO_BITRATE}"
echo "Frame Rate: ${FRAME_RATE}"
echo "Audio Codec: ${AUDIO_CODEC}"
echo "Audio Bitrate: ${AUDIO_BITRATE}"
echo "Audio Channels: ${AUDIO_CHANNELS}"
echo ""
echo "Press 'q' in the terminal to stop recording."

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# --- Corrected FFmpeg Command ---
# -vaapi_device: Specifies the GPU render node for VAAPI.
# -f x11grab ... -i $DISPLAY_NUM: Captures the screen from the specified X11 display.
# -f pulse ... -i $AUDIO_INPUT: Captures audio from the specified PulseAudio/PipeWire source.
# -vf 'format=nv12,hwupload':
#     1. 'format=nv12': Converts the pixel format to nv12 (CPU).
#     2. 'hwupload': Uploads the compatible frames to the GPU for encoding.
# -c:v $VIDEO_CODEC: Uses the VAAPI hardware encoder for H.264 video.
ffmpeg -vaapi_device /dev/dri/renderD128 \
       -f "$VIDEO_INPUT_FORMAT" -s "$RESOLUTION" -r "$FRAME_RATE" -i "$DISPLAY_NUM" \
       -f pulse -i "$AUDIO_INPUT" \
       -vf 'format=nv12,hwupload' \
       -c:v "$VIDEO_CODEC" -b:v "$VIDEO_BITRATE" \
       -c:a "$AUDIO_CODEC" -b:a "$AUDIO_BITRATE" -ac "$AUDIO_CHANNELS" \
       -y "$FULL_PATH"

if [ $? -eq 0 ]; then
    echo ""
    echo "Screencast recording finished successfully."
    echo "File saved to: ${FULL_PATH}"
else
    echo ""
    echo "Conversion failed! Please check the FFmpeg output above for errors."
fi
