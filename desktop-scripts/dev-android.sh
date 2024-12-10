#!/bin/bash

#ANDROID
_ANDROID_STUDIO_IDE_HOME_JAVA_HOME=$PROGSATIVOS_DIR/Android/android-studio-koala/android-studio
_ANDROID_STUDIO_SDK_HOME_JAVA_HOME="$PROGSATIVOS_DIR/Android/Sdk"
export ANDROID_SDK_ROOT=$PROGSATIVOS_DIR/Android/Sdk
export ANDROID_HOME=$PROGSATIVOS_DIR/Android/Sdk

export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$ANDROID_SDK_ROOT/cmdline-tools/platform-tools

function fzl-android-studio-koala-start(){
      bash $_ANDROID_STUDIO_IDE_HOME_JAVA_HOME/bin/studio.sh &
}
export -f fzl-android-studio-koala-start

function fzl-android-device-list(){
    adb devices
}
export -f fzl-android-device-list

function fzl-android-emulator-list(){
    emulator -list-avds
}
export -f fzl-android-emulator-list

function fzl-android-emulator-start(){
    (cd $ANDROID_SDK_ROOT/emulator && emulator -avd $1)    
}
export -f fzl-android-emulator-start