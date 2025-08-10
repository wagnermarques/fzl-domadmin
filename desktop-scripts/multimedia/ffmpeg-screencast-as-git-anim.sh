x#!/bin/bash

DEFAULT_OUTPUT="screencast.gif"
OUTPUT_FILE=$DEFAULT_OUTPUT
OUTPUT_DIR=$(pwd)
DURATION=10  # Default duration in seconds

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -o|--output-dir)
      OUTPUT_DIR="$2"
      shift 2
      ;;
    -d|--duration)
      DURATION="$2"
      shift 2
      ;;
    *)
      OUTPUT_FILE="$1"
      shift
      ;;
  esac
done

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# Full path to the output file
FULL_OUTPUT_PATH="$OUTPUT_DIR/$OUTPUT_FILE"

# Record screencast
ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i :0.0 -c:v libx264 -preset ultrafast -t "$DURATION" "$FULL_OUTPUT_PATH.mp4"

# Convert the MP4 to GIF
ffmpeg -i "$FULL_OUTPUT_PATH.mp4" -vf "fps=10,scale=1280:-1:flags=lanczos" -c:v pam -f image2pipe - | \
convert -delay 5 -layers optimize -loop 0 - "$FULL_OUTPUT_PATH"

# Clean up the intermediate MP4 file
#rm "$FULL_OUTPUT_PATH.mp4"

echo "Screencast saved as $FULL_OUTPUT_PATH"
