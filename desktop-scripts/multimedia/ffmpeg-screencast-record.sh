#!/bin/bash

echo "------------------------------"
echo "starting.. fzl-ffmpeg-screencast-record..."
echo "------------------------------"

# --- Define output file with timestamp ---
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
# Use .mkv for crash-safe recording.
OUTPUT_FILENAME="screencast_${TIMESTAMP}.mkv"
OUTPUT_DIR="$HOME/GRAVACOES-ffmpeg"
FULL_PATH="${OUTPUT_DIR}/${OUTPUT_FILENAME}"

# --- Auto-detect Video Settings ---
VIDEO_INPUT_FORMAT="x11grab"
DISPLAY_NUM="$DISPLAY"
if [ -z "$DISPLAY_NUM" ]; then
    DISPLAY_NUM=":0"
fi
RESOLUTION=$(xrandr | grep '*' | head -n 1 | awk '{print $1}')

# Check for Wayland
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    echo "WARNING: You are running on a Wayland session."
    echo "FFmpeg's x11grab might only capture XWayland windows or a black screen."
    echo "If recording fails or is black, please log in with 'GNOME on Xorg'."
    echo "------------------------------------------------------------------"
fi

# --- Define Video Codec Settings ---
VIDEO_CODEC_HW="h264_vaapi"
VIDEO_CODEC_SW="libx264"
VIDEO_BITRATE="4M"
FRAME_RATE="30"

# --- Auto-detect and Select Audio Source ---
echo "Detecting microphone sources..."

AUDIO_INPUT=""
MIC_NAME=""

if command -v wpctl &> /dev/null; then
    echo "Using wpctl (PipeWire) for detection..."
    
    # Robustly extract IDs from the "Sources" section of wpctl status
    # This ignores decorative characters like │ and picks up the number before the dot
    mapfile -t MIC_IDS < <(wpctl status | \
        sed -n '/Sources:/,/^$/p' | \
        grep -E '[0-9]+\.' | \
        sed -E 's/.*[^0-9]([0-9]+)\..*/\1/')
    
    if [ ${#MIC_IDS[@]} -gt 0 ]; then
        MIC_NAMES=()
        MIC_DESCS=()
        VALID_IDS=()
        for id in "${MIC_IDS[@]}"; do
            # Extract internal name and user-friendly description
            name=$(wpctl inspect "$id" 2>/dev/null | grep "node.name =" | awk -F'"' '{print $2}')
            desc=$(wpctl inspect "$id" 2>/dev/null | grep "node.description =" | awk -F'"' '{print $2}')
            if [ -n "$name" ]; then
                MIC_NAMES+=("$name")
                MIC_DESCS+=("${desc:-$name}")
                VALID_IDS+=("$id")
            fi
        done
        
        if [ ${#MIC_NAMES[@]} -eq 1 ]; then
            AUDIO_INPUT="${MIC_NAMES[0]}"
            MIC_NAME="${MIC_DESCS[0]}"
            SELECTED_ID="${VALID_IDS[0]}"
            echo "Using the only available microphone: $MIC_NAME"
        elif [ ${#MIC_NAMES[@]} -gt 1 ]; then
            echo "Multiple microphones found. Please select one:"
            PS3="Select microphone (number): "
            select opt in "${MIC_DESCS[@]}"; do
                if [ -n "$opt" ]; then
                    for i in "${!MIC_DESCS[@]}"; do
                        if [[ "${MIC_DESCS[$i]}" == "$opt" ]]; then
                            AUDIO_INPUT="${MIC_NAMES[$i]}"
                            MIC_NAME="${MIC_DESCS[$i]}"
                            SELECTED_ID="${VALID_IDS[$i]}"
                            break 2
                        fi
                    done
                else
                    echo "Invalid selection."
                fi
            done
        fi
        
        if [ -z "$AUDIO_INPUT" ] && [ ${#MIC_NAMES[@]} -gt 0 ]; then
            # Default to first if selection failed
            AUDIO_INPUT="${MIC_NAMES[0]}"
            MIC_NAME="${MIC_DESCS[0]}"
            SELECTED_ID="${VALID_IDS[0]}"
        fi

        if [ -n "$SELECTED_ID" ]; then
            # Set Volume to 100% and UNMUTE
            wpctl set-volume "$SELECTED_ID" 1.0
            wpctl set-mute "$SELECTED_ID" 0
        fi
    fi
fi

# Fallback to pactl (legacy/pulse)
if [ -z "$AUDIO_INPUT" ] && command -v pactl &> /dev/null; then
    echo "Using pactl (PulseAudio) for detection..."
    mapfile -t MIC_SOURCES < <(pactl list sources short | grep 'alsa_input' | grep -v '.monitor' | awk '{print $2}')
    if [ ${#MIC_SOURCES[@]} -gt 0 ]; then
        if [ ${#MIC_SOURCES[@]} -eq 1 ]; then
            AUDIO_INPUT=${MIC_SOURCES[0]}
            MIC_NAME=$AUDIO_INPUT
        else
            echo "Please select the microphone to use:"
            select choice in "${MIC_SOURCES[@]}"; do
                if [[ -n "$choice" ]]; then
                    AUDIO_INPUT=$choice
                    MIC_NAME=$choice
                    break
                fi
            done
        fi
        pactl set-source-volume "$AUDIO_INPUT" 100%
        pactl set-source-mute "$AUDIO_INPUT" 0
    fi
fi

# Final fallback
if [ -z "$AUDIO_INPUT" ]; then
    echo "No specialized microphone detected. Falling back to system 'default'."
    AUDIO_INPUT="default"
    MIC_NAME="Default Audio Source"
else
    echo "Selected audio source: $MIC_NAME (Name: $AUDIO_INPUT)"
fi

# --- Define Audio Codec Settings ---
AUDIO_CODEC="aac"
AUDIO_BITRATE="128k"
AUDIO_CHANNELS="2"

# --- Print settings to user ---
echo "Resolution: ${RESOLUTION}"
echo "Audio Source: ${AUDIO_INPUT}"
echo "Video Source: ${DISPLAY_NUM}"
echo "Output file: ${FULL_PATH}"
echo "Video Bitrate: ${VIDEO_BITRATE}"
echo "Frame Rate: ${FRAME_RATE}"
echo "Audio Codec: ${AUDIO_CODEC}"
echo "Audio Bitrate: ${AUDIO_BITRATE}"
echo "Audio Channels: ${AUDIO_CHANNELS}"
echo ""
echo "Press 'q' in the terminal to stop recording."

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# --- Attempt Recording ---
echo "Starting recording... Press 'q' to stop."

# 1. Try Hardware Encoding (VAAPI)
# Added -thread_queue_size and increased probesize for better stability
ffmpeg -vaapi_device /dev/dri/renderD128 \
       -hide_banner -loglevel info \
       -thread_queue_size 1024 -f "$VIDEO_INPUT_FORMAT" -s "$RESOLUTION" -r "$FRAME_RATE" -i "$DISPLAY_NUM" \
       -thread_queue_size 1024 -f pulse -i "$AUDIO_INPUT" \
       -vf 'format=nv12,hwupload' \
       -c:v "$VIDEO_CODEC_HW" -b:v "$VIDEO_BITRATE" \
       -c:a "$AUDIO_CODEC" -b:a "$AUDIO_BITRATE" -ac "$AUDIO_CHANNELS" \
       -y "$FULL_PATH"

FFMPEG_RET=$?

# 2. Handle Retries
# Exit codes: 0 (q), 255 (q), 130 (Ctrl+C) are considered "normal stops" by user.
if [ $FFMPEG_RET -ne 0 ] && [ $FFMPEG_RET -ne 255 ] && [ $FFMPEG_RET -ne 130 ]; then
    echo "Hardware encoding failed or crashed (Exit code: $FFMPEG_RET). Retrying with software encoding..."
    ffmpeg -hide_banner -loglevel info \
           -thread_queue_size 1024 -f "$VIDEO_INPUT_FORMAT" -s "$RESOLUTION" -r "$FRAME_RATE" -i "$DISPLAY_NUM" \
           -thread_queue_size 1024 -f pulse -i "$AUDIO_INPUT" \
           -c:v "$VIDEO_CODEC_SW" -preset fast -crf 23 \
           -c:a "$AUDIO_CODEC" -b:a "$AUDIO_BITRATE" -ac "$AUDIO_CHANNELS" \
           -y "$FULL_PATH"
    FFMPEG_RET=$?
fi

if [ $FFMPEG_RET -eq 0 ] || [ $FFMPEG_RET -eq 255 ] || [ $FFMPEG_RET -eq 130 ]; then
    echo ""
    echo "Screencast recording finished."
    echo "File saved to: ${FULL_PATH}"
else
    echo ""
    echo "Recording failed with error code: $FFMPEG_RET"
fi
