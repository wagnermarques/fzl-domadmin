#!/bin/bash

# Android Studio and SDK Home Directories
ANDROID_STUDIO_HOME="$PROGSATIVOS_DIR/android/android-studio"
ANDROID_SDK_HOME="$PROGSATIVOS_DIR/Android/Sdk"

# Set Android-related environment variables
export ANDROID_SDK_ROOT=$ANDROID_SDK_HOME
export ANDROID_HOME=$ANDROID_SDK_HOME
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$ANDROID_SDK_ROOT/cmdline-tools/platform-tools

# Start Android Studio
function fzl-android-studio-start(){
    bash $ANDROID_STUDIO_HOME/bin/studio.sh &
}
export -f fzl-android-studio-start

# List available AVDs (Android Virtual Devices)
function fzl-android-avd-list(){
    emulator -list-avds
}
export -f fzl-android-avd-list

# Start an Android emulator
function fzl-android-emulator-start(){
    if [ -z "$1" ]; then
        echo "Please provide an AVD name"
        return 1
    fi
    (cd $ANDROID_SDK_ROOT/emulator && emulator -avd "$1")
}
export -f fzl-android-emulator-start

# List connected Android devices
function fzl-android-device-list(){
    adb devices -l
}
export -f fzl-android-device-list

# Enter shell of a specific device
function fzl-android-device-shell(){
    if [ -z "$1" ]; then
        echo "Please provide a device serial number"
        return 1
    fi
    adb -s "$1" shell
}
export -f fzl-android-device-shell

# List installed applications on a device
function fzl-android-app-list(){
    if [ -z "$1" ]; then
        echo "Please provide a device serial number"
        return 1
    fi
    adb -s "$1" shell pm list packages
}
export -f fzl-android-app-list

# Upload a file to device's SD card
function fzl-android-upload-file(){
    if [ $# -ne 3 ]; then
        #echo "Usage: fzl-android-upload-file <device_serial> <local_file_path> <remote_sdcard_path>"
        return 1
    fi
    adb -s "$1" push "$2" "$3"
}
export -f fzl-android-upload-file

# Turn off a specific device
function fzl-android-device-off(){
    if [ -z "$1" ]; then
        echo "Please provide a device serial number"
        return 1
    fi
    adb -s "$1" shell reboot -p
}
export -f fzl-android-device-off

# Bonus: Kill all running emulators
function fzl-android-kill-emulators(){
    pkill -f "emulator"
}
export -f fzl-android-kill-emulators
