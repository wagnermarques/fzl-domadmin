#!/bin/bash

# Create output file with timestamp
OUTPUT_FILE="fedora41_multimedia_report_$(date +%Y%m%d_%H%M%S).txt"

{
echo "=============================================="
echo " Fedora 41 Multimedia Production System Report"
echo " Generated: $(date)"
echo "=============================================="
echo ""

echo "===== 1. SYSTEM OVERVIEW ====="
echo "--- OS Information ---"
cat /etc/os-release
echo ""
echo "--- Kernel Version ---"
uname -a
echo ""
echo "--- Hostname ---"
hostnamectl
echo ""
echo "--- Uptime ---"
uptime
echo ""

echo "===== 2. GRAPHICS & DISPLAY ====="
echo "--- GPU Information ---"
lspci -k | grep -A 3 -i "VGA\|3D"
echo ""
echo "--- OpenGL Renderer ---"
glxinfo | grep "OpenGL renderer"
echo ""
echo "--- Vulkan Support ---"
if command -v vulkaninfo &> /dev/null; then
    vulkaninfo | grep "GPU id" | head -n 1
else
    echo "vulkaninfo not installed (sudo dnf install vulkan-tools)"
fi
echo ""
echo "--- Display Configuration ---"
if command -v xrandr &> /dev/null; then
    xrandr --current
else
    echo "xrandr not available (X11 not running?)"
fi
echo ""

echo "===== 3. AUDIO CONFIGURATION ====="
echo "--- Audio Devices ---"
if command -v pactl &> /dev/null; then
    pactl list sinks | grep -E "Description:|Name:"
    echo ""
    pactl list sources | grep -E "Description:|Name:"
else
    echo "pactl not available"
fi
echo ""
echo "--- ALSA Devices ---"
aplay -l 2>/dev/null || echo "aplay command failed"
arecord -l 2>/dev/null || echo "arecord command failed"
echo ""

echo "===== 4. PERFORMANCE CAPABILITIES ====="
echo "--- CPU Flags (look for AVX, AVX2) ---"
lscpu | grep -i "flags" | fold -w 80
echo ""
echo "--- Memory Information ---"
free -h
echo ""
echo "--- Memory Speed ---"
sudo dmidecode --type 17 | grep -i "speed" 2>/dev/null || echo "Requires sudo privileges"
echo ""
echo "--- Disk Information ---"
lsblk -o NAME,ROTA,SCHED,SIZE,RO,MODEL
echo ""
echo "--- Mount Options ---"
findmnt -lo TARGET,FS-OPTIONS | grep -v snap
echo ""

echo "===== 5. VIDEO ENCODING/DECODING ====="
echo "--- VA-API Support ---"
if command -v vainfo &> /dev/null; then
    vainfo | grep -i "driver" | head -n 2
else
    echo "vainfo not installed (sudo dnf install libva-utils)"
fi
echo ""
echo "--- FFmpeg Capabilities ---"
if command -v ffmpeg &> /dev/null; then
    echo "Encoders:"
    ffmpeg -hide_banner -encoders 2>&1 | grep -i "vaapi\|nvenc\|qsv" | head -n 5
    echo ""
    echo "Decoders:"
    ffmpeg -hide_banner -decoders 2>&1 | grep -i "vaapi\|nvenc\|qsv" | head -n 5
else
    echo "ffmpeg not installed (sudo dnf install ffmpeg)"
fi
echo ""

echo "===== 6. TEMPERATURE MONITORING ====="
if command -v sensors &> /dev/null; then
    sensors | grep -i "temp\|fan" | head -n 5
else
    echo "lm_sensors not installed (sudo dnf install lm_sensors)"
fi
echo ""

echo "===== 7. SCREENCAST CAPABILITIES ====="
echo "--- Video4Linux Devices ---"
v4l2-ctl --list-devices 2>/dev/null || echo "v4l2-ctl not available"
echo ""
echo "--- Screen Capture Options ---"
if command -v ffmpeg &> /dev/null; then
    ffmpeg -hide_banner -f avfoundation -list_devices true -i "" 2>&1 | grep "Screen" || \
    echo "Could not list screen capture devices"
else
    echo "ffmpeg not available for device listing"
fi
echo ""

echo "===== 8. RECOMMENDED CONFIGURATIONS ====="
echo "1. Set swappiness to 10 for better performance:"
echo "   echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf"
echo ""
echo "2. Mount video storage with noatime option in /etc/fstab:"
echo "   Example: UUID=your-uuid /media/video ext4 defaults,noatime 0 2"
echo ""
echo "3. For OBS Studio screencasting:"
echo "   - Enable VA-API in Settings > Output"
echo "   - Use 'Advanced' output mode for best control"
echo ""
echo "4. For video editing performance:"
echo "   - Configure your editor to use GPU acceleration"
echo "   - Use a dedicated SSD for cache/scratch files"
echo ""
echo "5. For low-latency audio:"
echo "   - Ensure pipewire is running: sudo systemctl enable --now pipewire pipewire-pulse"
echo "   - Configure your DAW with appropriate buffer sizes"

} | tee "$OUTPUT_FILE"

echo ""
echo "Report generated and saved to: $OUTPUT_FILE"