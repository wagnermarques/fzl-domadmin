#!/bin/bash

# the scrcpy installation and path config is in the setup_desktop.sh
function fzl-scrcpy-start(){
    echo #(which scrcpy)
    scrcpy
}
export -f fzl-scrcpy-start


# Start Android Studio (robust lookup)
function fzl-android-studio-start(){
    echo "Starting Android Studio..."
    echo "Configured Android Studio path: $ANDROID_STUDIO_HOME"

    local candidates=()
    # prefer explicit env var
    if [ -n "$ANDROID_STUDIO_HOME" ]; then
        candidates+=("$ANDROID_STUDIO_HOME/bin/studio.sh" "$ANDROID_STUDIO_HOME/studio.sh")
    fi
    # common places under _PROGSATIVOS_DIR
    if [ -n "${_PROGSATIVOS_DIR:-}" ]; then
        candidates+=("${_PROGSATIVOS_DIR}/ides/android/android-studio/bin/studio.sh")
    fi

    # probe the candidate list for an executable studio.sh
    for c in "${candidates[@]}"; do
        [ -z "$c" ] && continue
        if [ -x "$c" ]; then
            echo "Found Android Studio launcher: $c"
            nohup "$c" >/dev/null 2>&1 &
            disown
            return 0
        fi
    done

    # fallback: try to find any studio.sh inside typical locations (fast search)
    local found
    found=$(find "${ANDROID_STUDIO_HOME:-$HOME}" "${_PROGSATIVOS_DIR:-/home/$USER/WORKING/Progsativos}" /opt -type f -name 'studio.sh' -perm /111 -maxdepth 5 2>/dev/null | head -n1 || true)
    if [ -n "$found" ] && [ -x "$found" ]; then
        echo "Found Android Studio via search: $found"
        nohup "$found" >/dev/null 2>&1 &
        disown
        return 0
    fi

    # final fallback: try JetBrains toolbox/idea launcher variants
    if command -v idea.sh >/dev/null 2>&1; then
        echo "Starting idea.sh as fallback"
        nohup idea.sh >/dev/null 2>&1 &
        disown
        return 0
    fi

    echo "Android Studio launcher not found. Set ANDROID_STUDIO_HOME correctly or install Android Studio." >&2
    return 2
}
export -f fzl-android-studio-start


# Helper: find Android tool (adb, emulator) preferring PATH, then multiple SDK locations
_android_tool(){
    local tool="$1"
    # check PATH
    if command -v "$tool" >/dev/null 2>&1; then
        command -v "$tool"
        return 0
    fi
    # list of candidate SDK roots to check
    local candidates=()
    # prefer explicit vars
    [ -n "$ANDROID_SDK_ROOT" ] && candidates+=("$ANDROID_SDK_ROOT")
    [ -n "$ANDROID_HOME" ] && candidates+=("$ANDROID_HOME")
    [ -n "$ANDROID_SDK_HOME" ] && candidates+=("$ANDROID_SDK_HOME")
    # common defaults
    candidates+=("$HOME/Android/Sdk" "/opt/android-sdk" "/usr/lib/android-sdk" "/usr/local/android-sdk")

    for sdk in "${candidates[@]}"; do
        [ -z "$sdk" ] && continue
        if [ -x "$sdk/platform-tools/$tool" ]; then
            echo "$sdk/platform-tools/$tool"; return 0
        fi
        if [ -x "$sdk/emulator/$tool" ]; then
            echo "$sdk/emulator/$tool"; return 0
        fi
        if [ -x "$sdk/tools/bin/$tool" ]; then
            echo "$sdk/tools/bin/$tool"; return 0
        fi
    done

    # Last resort: search common directories (HOME, /opt, /usr) for the binary (fast heuristics)
    for d in "$HOME" /opt /usr /usr/local; do
        if [ -d "$d" ]; then
            local found
            found=$(find "$d" -type f -name "$tool" -perm /111 -maxdepth 6 2>/dev/null | head -n1 || true)
            if [ -n "$found" ]; then
                echo "$found"
                return 0
            fi
        fi
    done

    return 1
}

# List available AVDs (Android Virtual Devices)
function fzl-android-avd-list(){
    local em=$( _android_tool emulator ) || true
    if [ -z "$em" ]; then
        echo "emulator binary not found. Ensure Android SDK emulator is installed and ANDROID_SDK_ROOT or ANDROID_HOME is set, or add emulator to PATH." >&2
        return 2
    fi
    "$em" -list-avds
}
export -f fzl-android-avd-list

# Start an Android emulator
function fzl-android-emulator-start(){
    local avd="$1"
    local em=$( _android_tool emulator ) || true
    if [ -z "$em" ]; then
        echo "emulator binary not found. Check ANDROID_SDK_ROOT/emulator or ANDROID_HOME/emulator." >&2
        return 2
    fi
    if [ -z "$avd" ]; then
        # try to pick the first available AVD
        avd=$("$em" -list-avds 2>/dev/null | head -n1 | tr -d '\r')
        if [ -z "$avd" ]; then
            echo "Please provide an AVD name (no AVDs found)." >&2
            return 1
        fi
        echo "No AVD specified; using first available: $avd"
    fi
    # start from emulator dir so relative resources resolve
    (cd "$(dirname "$em")" && "$em" -avd "$avd") &
}
export -f fzl-android-emulator-start

# List connected Android devices
function fzl-android-device-list(){
    local adb=$( _android_tool adb ) || true
    if [ -z "$adb" ]; then
        echo "adb not found. Ensure platform-tools are installed and ANDROID_SDK_ROOT/platform-tools is in PATH or set ANDROID_SDK_ROOT/ANDROID_HOME." >&2
        return 2
    fi
    "$adb" devices -l
}
export -f fzl-android-device-list

# Enter shell of a specific device
function fzl-android-device-shell(){
    if [ -z "$1" ]; then
        echo "Please provide a device serial number"
        return 1
    fi
    local adb=$( _android_tool adb ) || true
    if [ -z "$adb" ]; then
        echo "adb not found." >&2; return 2
    fi
    "$adb" -s "$1" shell
}
export -f fzl-android-device-shell

# List installed applications on a device
function fzl-android-app-list(){
    if [ -z "$1" ]; then
        echo "Please provide a device serial number"
        return 1
    fi
    local adb=$( _android_tool adb ) || true
    if [ -z "$adb" ]; then
        echo "adb not found." >&2; return 2
    fi
    "$adb" -s "$1" shell pm list packages
}
export -f fzl-android-app-list

# Upload a file to device's SD card
function fzl-android-upload-file(){
    if [ $# -ne 3 ]; then
        echo "Usage: fzl-android-upload-file <device_serial> <local_file_path> <remote_sdcard_path>" >&2
        return 1
    fi
    local adb=$( _android_tool adb ) || true
    if [ -z "$adb" ]; then
        echo "adb not found." >&2; return 2
    fi
    "$adb" -s "$1" push "$2" "$3"
}
export -f fzl-android-upload-file

# Turn off a specific device
function fzl-android-device-off(){
    if [ -z "$1" ]; then
        echo "Please provide a device serial number"
        return 1
    fi
    local adb=$( _android_tool adb ) || true
    if [ -z "$adb" ]; then
        echo "adb not found." >&2; return 2
    fi
    "$adb" -s "$1" shell reboot -p
}
export -f fzl-android-device-off

# Bonus: Kill all running emulators
function fzl-android-kill-emulators(){
    # Prefer emulator binary if present
    local em=$( _android_tool emulator ) || true
    if [ -n "$em" ]; then
        pkill -f "$(basename "$em")"
    else
        pkill -f "emulator" || true
    fi
}
export -f fzl-android-kill-emulators

# Diagnostic: show resolved tool locations and key env vars
function fzl-android-info(){
    echo "ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT"
    echo "ANDROID_HOME=$ANDROID_HOME"
    echo "ANDROID_SDK_HOME=$ANDROID_SDK_HOME"
    echo "Resolved adb: $( _android_tool adb || true )"
    echo "Resolved emulator: $( _android_tool emulator || true )"
    echo "Resolved scrcpy: $( command -v scrcpy || true )"
}
export -f fzl-android-info
