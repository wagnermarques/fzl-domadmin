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
echo "Detecting audio sources..."

MIC_LIST=()
MIC_PATHS=()
SYSTEM_MONITOR=""

# 1. Identify Default Sink Monitor (for Desktop Audio / YouTube)
# Try to find the default sink (marked with *) in the Sinks section
# We look for the line with '*' under 'Sinks:' and extract the ID
DEFAULT_SINK_ID=$(wpctl status | sed -n '/Sinks:/,/^$/p' | grep '^[[:space:]]*│*[[:space:]]*\*' | grep -E '[0-9]+\.' | head -n 1 | sed -E 's/.*[^0-9]([0-9]+)\..*/\1/')

if [ -n "$DEFAULT_SINK_ID" ]; then
    # Get the monitor source name for this sink
    # Usually it is <node.name>.monitor
    SINK_NAME=$(wpctl inspect "$DEFAULT_SINK_ID" | grep "node.name =" | awk -F'"' '{print $2}')
    if [ -n "$SINK_NAME" ]; then
        SYSTEM_MONITOR="${SINK_NAME}.monitor"
    fi
fi

# 2. Collect Microphones (Sources)
if command -v pactl &> /dev/null; then
    # ... (pactl logic kept as fallback) ...
    echo "Using pactl for robust device detection..."
    while read -r line; do
        name=$(echo "$line" | awk '{print $2}')
        if [[ "$name" == *".monitor" ]] || [[ "$name" == *"v4l2"* ]]; then continue; fi
        desc=$(pactl list sources | grep -A 20 "Name: $name" | grep "Description:" | head -n 1 | cut -d: -f2- | sed 's/^[[:space:]]*//')
        label="$desc"
        [[ "$name" == *"usb"* ]] && label="[USB] $label"
        MIC_LIST+=("$label")
        MIC_PATHS+=("$name")
    done < <(pactl list sources short)
elif command -v wpctl &> /dev/null; then
    echo "Using wpctl for detection..."
    
    # 1. Capture the full status output once
    STATUS_OUTPUT=$(wpctl status)
    
    # 2. Extract the "Audio" -> "Sources" block strictly
    # We look for "Sources:" under "Audio", then read until the next blank line
    SOURCES_BLOCK=$(echo "$STATUS_OUTPUT" | sed -n '/Audio/,/^$/p' | sed -n '/Sources:/,/^$/p')
    
    # 3. Extract IDs only from this block. 
    # Valid lines look like: "│      53. Family 17h..." or " *   53. Family..."
    # We strip decorative chars and get the first number.
    mapfile -t CANDIDATE_IDS < <(echo "$SOURCES_BLOCK" | grep -E '[0-9]+\.' | sed -E 's/^[[:space:]│*]*//' | cut -d. -f1 | sort -u)
    
    for id in "${CANDIDATE_IDS[@]}"; do
        # Inspect each candidate ID safely
        if ! info=$(wpctl inspect "$id" 2>/dev/null); then
            continue
        fi
        
        # Check media.class is correct
        class=$(echo "$info" | grep "media.class =" | awk -F'"' '{print $2}')
        
        if [[ "$class" == "Audio/Source" ]]; then
            name=$(echo "$info" | grep "node.name =" | awk -F'"' '{print $2}')
            
            # Skip monitors explicitly
            if [[ "$name" == *".monitor" ]]; then continue; fi
            
            desc=$(echo "$info" | grep "node.description =" | awk -F'"' '{print $2}')
            api=$(echo "$info" | grep "device.api =" | awk -F'"' '{print $2}')
            
            # Construct a user-friendly label
            label="${desc:-$name}"
            
            # Add [USB] prefix if applicable
            if [[ "$name" == *"usb"* ]] || [[ "$name" == *"USB"* ]] || [[ "$label" == *"USB"* ]]; then
                label="[USB] $label"
            fi
            
            MIC_LIST+=("$label")
            MIC_PATHS+=("$id")
        fi
    done
fi

# 3. Selection UI
SELECTED_MIC_ID=""
SELECTED_MIC_NAME=""
if [ ${#MIC_LIST[@]} -eq 0 ]; then
    echo "No physical microphones detected."
    SELECTED_MIC_ID="none"
elif [ ${#MIC_LIST[@]} -eq 1 ]; then
    echo "Using the only available microphone: ${MIC_LIST[0]}"
    SELECTED_MIC_ID="${MIC_PATHS[0]}"
else
    echo "Multiple microphones found. Please select one:"
    select opt in "${MIC_LIST[@]}" "No Microphone (Mute)"; do
        if [ "$opt" == "No Microphone (Mute)" ]; then
            SELECTED_MIC_ID="none"
            break
        elif [ -n "$opt" ]; then
            for i in "${!MIC_LIST[@]}"; do
                if [[ "${MIC_LIST[$i]}" == "$opt" ]]; then
                    SELECTED_MIC_ID="${MIC_PATHS[$i]}"
                    break 2
                fi
            done
        else
            echo "Invalid selection."
        fi
    done
fi

# 4. Desktop Audio (YouTube) Option
RECORD_SYSTEM="n"
if [ -n "$SYSTEM_MONITOR" ]; then
    echo ""
    echo "System Audio (Monitor) detected: $SYSTEM_MONITOR"
    read -p "Do you want to record System Audio (YouTube/Music) as well? (y/N): " ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        RECORD_SYSTEM="y"
        echo "System audio recording enabled."
    fi
fi

# 5. Build FFmpeg Audio Arguments
AUDIO_INPUT_ARGS=""
AUDIO_MAPPING=""

# Resolve ID to Name for FFmpeg (if using wpctl ID)
# FFmpeg pulse input usually takes the name (e.g. alsa_input.pci-...) or the number?
# Pulse/Pipewire via FFmpeg pulse backend usually expects the NAME.
# If we have an ID from wpctl, we should resolve it to the node.name.

if [ "$SELECTED_MIC_ID" != "none" ] && [ -n "$SELECTED_MIC_ID" ]; then
    if command -v wpctl &> /dev/null && [[ "$SELECTED_MIC_ID" =~ ^[0-9]+$ ]]; then
        # Resolve ID to Name
        SELECTED_MIC_NAME=$(wpctl inspect "$SELECTED_MIC_ID" | grep "node.name =" | awk -F'"' '{print $2}')
        
        # Ensure volume is up
        wpctl set-volume "$SELECTED_MIC_ID" 1.0
        wpctl set-mute "$SELECTED_MIC_ID" 0
    else
        SELECTED_MIC_NAME="$SELECTED_MIC_ID"
        # Pactl volume logic handled earlier or separate
    fi
fi

if [ "$SELECTED_MIC_ID" != "none" ] && [ -n "$SELECTED_MIC_NAME" ] && [ "$RECORD_SYSTEM" == "y" ]; then
    echo "Configuring Mix: Microphone + System Audio"
    AUDIO_INPUT_ARGS="-thread_queue_size 1024 -f pulse -i $SELECTED_MIC_NAME -thread_queue_size 1024 -f pulse -i $SYSTEM_MONITOR"
    AUDIO_MAPPING="-filter_complex [1:a][2:a]amix=inputs=2:duration=longest[aout] -map 0:v -map [aout]"
elif [ "$SELECTED_MIC_ID" != "none" ] && [ -n "$SELECTED_MIC_NAME" ]; then
    echo "Configuring: Microphone Only"
    AUDIO_INPUT_ARGS="-thread_queue_size 1024 -f pulse -i $SELECTED_MIC_NAME"
    AUDIO_MAPPING="-map 0:v -map 1:a"
elif [ "$RECORD_SYSTEM" == "y" ]; then
    echo "Configuring: System Audio Only"
    AUDIO_INPUT_ARGS="-thread_queue_size 1024 -f pulse -i $SYSTEM_MONITOR"
    AUDIO_MAPPING="-map 0:v -map 1:a"
else
    echo "Configuring: No Audio"
    AUDIO_MAPPING="-map 0:v"
fi

# ... Rest of script ...

# --- Define Audio Codec Settings ---
AUDIO_CODEC="aac"
AUDIO_BITRATE="128k"
AUDIO_CHANNELS="2"

# --- Print settings to user ---
echo "Resolution: ${RESOLUTION}"
echo "Video Source: ${DISPLAY_NUM}"
echo "Output file: ${FULL_PATH}"
echo "Video Bitrate: ${VIDEO_BITRATE}"
echo "Frame Rate: ${FRAME_RATE}"
echo ""
echo "Press 'q' in the terminal to stop recording."

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# --- Attempt Recording ---
echo "Starting recording... Press 'q' to stop."

# 1. Try Hardware Encoding (VAAPI)
ffmpeg -vaapi_device /dev/dri/renderD128 \
       -hide_banner -loglevel info \
       -thread_queue_size 1024 -f "$VIDEO_INPUT_FORMAT" -s "$RESOLUTION" -r "$FRAME_RATE" -i "$DISPLAY_NUM" \
       $AUDIO_INPUT_ARGS \
       -vf 'format=nv12,hwupload' \
       -c:v "$VIDEO_CODEC_HW" -b:v "$VIDEO_BITRATE" \
       -c:a "$AUDIO_CODEC" -b:a "$AUDIO_BITRATE" -ac "$AUDIO_CHANNELS" \
       $AUDIO_MAPPING \
       -y "$FULL_PATH"

FFMPEG_RET=$?

# 2. Handle Retries
# Exit codes: 0 (q), 255 (q), 130 (Ctrl+C) are considered "normal stops" by user.
if [ $FFMPEG_RET -ne 0 ] && [ $FFMPEG_RET -ne 255 ] && [ $FFMPEG_RET -ne 130 ]; then
    echo "Hardware encoding failed or crashed (Exit code: $FFMPEG_RET). Retrying with software encoding..."
    ffmpeg -hide_banner -loglevel info \
           -thread_queue_size 1024 -f "$VIDEO_INPUT_FORMAT" -s "$RESOLUTION" -r "$FRAME_RATE" -i "$DISPLAY_NUM" \
           $AUDIO_INPUT_ARGS \
           -c:v "$VIDEO_CODEC_SW" -preset fast -crf 23 \
           -c:a "$AUDIO_CODEC" -b:a "$AUDIO_BITRATE" -ac "$AUDIO_CHANNELS" \
           $AUDIO_MAPPING \
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
