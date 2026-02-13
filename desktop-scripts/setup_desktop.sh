#!/bin/bash

echo "[setup_desktop.sh] running..."

function echoerr()  { echo "$@" 1>&2; }
function echoout()  { echo "$@"; }
function echoout1() { echo " ############### " "$@" " ###############"; }
function echoout2() { echo "----- " "$@"; }

echo .
echoout1 "Setup paths and source utils"

echoout2 "Config PATH environment variable"
_THIS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echoout _THIS_PATH=$_THIS_PATH

source "$_THIS_PATH/utils/path_utils.sh"
source "$_THIS_PATH/utils/params_utils.sh"
source "$_THIS_PATH/utils/os-utils.sh"

fzl-add-to-path "$_THIS_PATH"/bin
fzl-add-to-path "$_THIS_PATH"/lsp
fzl-add-to-path "$_THIS_PATH"/multimedia
fzl-add-to-path "$_THIS_PATH"/samba
fzl-add-to-path "$_THIS_PATH"/libvirt


echo .
echoout2 "Machine specific setup..."
# some specific setup for different machines
# without machine name, it will use "desktop" as default
echoout 'if machine name is "cdep", it will mount /dev/sda4 to ~/'
machine_name_from_params=$(get_param "machine_name")
echo "[setup_desktop.sh] machine_name_from_params=$machine_name_from_params"
echo .


if [ -z "$machine_name_from_params" ]; then
    echo "[setup_desktop.sh] machine_name_from_params is empty, setting default value"
    set_param "machine_name" "desktop"
else

    # perform some actions based on the machine name
    echo "[setup_desktop.sh] machine_name_from_params is not empty, using it:"
    if [ "$1" == "cdep" ]; then
        echo "[setup_desktop.sh] machine_name_from_params is cdep, mounting /dev/sda4 to ~/projs"
        sudo mount /dev/sda4 ~/projs
    fi
fi


#wait for the mount to be ready
sleep 2


echo .
echo .
echoout1 "Declaring some default properties"
declare -A _defaults=(
    ["javaJdkVersion"]="21" 
    ["tomcatVersion"]="9")
echoout "javaJdkVersion ${_defaults[javaJdkVersion]}"
echoout "tomcatVersion ${_defaults[tomcatVersion]}"



echo .
echo .
echoout1 "GLOBAL VARIABLES"

# I've been using two different partitions to store my files, one is ext4 and other is btrfs,
# so I need to declare the paths for both of them, and then use the one that is correct for the current machine
# but the final purpose to this script runs it to define
# PROGSATIVOS_DIR variable, which is the base directory for all progsativos files, including ides, research, java sdks, and other tools
# Beside that, I also use ZorinOs and Fedora in different machines,
# so I need to declare the paths for both of them, and then use the one that is correct for the current machine

OS_FAMILY=$(fzl-os-utils-detect-os --family)
OS_ID=$(fzl-os-utils-detect-os --id)

PROGSATIVOS_DIR_EXT4_PARTITION_REDHAT_LIKE_DISTROS="/run/media/wgn/ext4/progsativos"
PROGSATIVOS_DIR_EXT4_PARTITION_DEBIAN_LIKE_DISTROS="/media/wgn/ext4/progsativos"

PROGSATIVOS_DIR_BTRFS400G_PARTITION_DEBIAN_LIKE_DISTROS="/media/wgn/btrfs400G/PROGSATIVOS"
PROGSATIVOS_DIR_BTRFS400G_PARTITION_REDHAR_LIKE_DISTROS="/run/media/wgn/btrfs400G/PROGSATIVOS"

if [ "$OS_FAMILY" == "debian" ] || [ "$OS_ID" == "ubuntu" ]; then
    PROGSATIVOS_DIR="$PROGSATIVOS_DIR_BTRFS400G_PARTITION_DEBIAN_LIKE_DISTROS"
    _EMACS_EXECUTABLE="$PROGSATIVOS_DIR/ides/emacs/emacs-30.2/src/emacs/src/emacs"
    _PROJECTS_SRCS_DESKTOP=/media/wgn/btrfs400G/Projects-Srcs-Desktop
elif [ "$OS_FAMILY" == "fedora" ] || [ "$OS_FAMILY" == "rhel" ]; then
     PROGSATIVOS_DIR="$PROGSATIVOS_DIR_BTRFS400G_PARTITION_REDHAT_LIKE_DISTROS"
    _EMACS_EXECUTABLE="$PROGSATIVOS_DIR/ides/emacs/emacs-30.2/src/emacs/src/emacs-fed-41"
    _PROJECTS_SRCS_DESKTOP=/run/media/wgn/btrfs400G/Projects-Srcs-Desktop
else
    echo "[ERROR] OS type not supported: $OS_ID"
fi

echoout1 "GLOBAL VARIABLES"
echoout1 "GLOBAL VARIABLES => IDES"
echoout2 "Emacs"
_FZL_EMACS_HOME="$_PROJECTS_SRCS_DESKTOP/fzl-emacs" #fzl-emacs-start command


echoout2 "Android platform (Android Studio, Android SDK and scrcpy)"
ANDROID_STUDIO_HOME="$PROGSATIVOS_DIR/ides/android/android-studio-panda1-linux/android-studio"
ANDROID_SDK_HOME="$PROGSATIVOS_DIR/android-sdk"
export ANDROID_SDK_ROOT=$ANDROID_SDK_HOME
export ANDROID_HOME=$ANDROID_SDK_HOME

fzl-add-to-path $ANDROID_SDK_ROOT/platform-tools
fzl-add-to-path $ANDROID_SDK_ROOT/tools
fzl-add-to-path $ANDROID_SDK_ROOT/tools/bin
fzl-add-to-path $ANDROID_SDK_ROOT/emulator
fzl-add-to-path $ANDROID_SDK_ROOT/cmdline-tools/tools/bin

#scrcpy
#https://github.com/Genymobile/scrcpy/blob/master/doc/linux.mdhttps://github.com/Genymobile/scrcpy
#sudo apt install ffmpeg libsdl2-2.0-0 adb wget \
#                 gcc git pkg-config meson ninja-build libsdl2-dev \
#                 libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev \
#                 libswresample-dev libusb-1.0-0 libusb-1.0-0-dev
_SCRCPY_HOME=$PROGSATIVOS_DIR/android-tools/scrcpy-linux-x86_64-v3.3.4
fzl-add-to-path $_SCRCPY_HOME
echoout "_SCRCPY_HOME=$_SCRCPY_HOME"


_JAVA_HOME=$PROGSATIVOS_DIR/ides/eclipse.org/eclipse-java-2025-06-R-linux-gtk-x86_64
echoout "_ECLIPSE_JAVA_HOME=$PROGSATIVOS_DIR/ides/eclipse.org/eclipse-java-2025-06-R-linux-gtk-x86_64"

_ECLIPSE_MODELLING_HOME=$PROGSATIVOS_DIR/ides/eclipse.org/eclipse-modeling-2025-06-R-linux-gtk-x86_64
echoout "_ECLIPSE_MODELLING_HOME=$PROGSATIVOS_DIR/ides/eclipse.org/eclipse-modeling-2025-06-R-linux-gtk-x86_64"

_INTELLIJ_HOME=$PROGSATIVOS_DIR/ides/idea-IU-252.23892.409
echoout _INTELLIJ_HOME=$PROGSATIVOS_DIR/ides/idea-IU-252.23892.409

#https://www.jetbrains.com/webstorm/download/download-thanks.html
#https://www.jetbrains.com/clion/download/?section=linux
#https://www.jetbrains.com/pycharm/download/?section=linux
#https://www.jetbrains.com/webstorm/download/download-thanks.html
#https://www.jetbrains.com/clion/download/?section=linux
#https://www.jetbrains.com/pycharm/download/?section=linux




_BRUNO_AppImage="/run/media/wgn/ext4/progsativos/bruno/bruno_2.12.0_x86_64_linux.AppImage"
echoout "_BRUNO_AppImage=\"/media/wgn/ext4/progsativos/bruno/bruno_2.12.0_x86_64_linux.AppImage\""

ZOTERO_HOME="$PROGSATIVOS_DIR/research/Zotero_linux-x86_64"
echoout "ZOTERO_HOME=\"$PROGSATIVOS_DIR/research/Zotero_linux-x86_64\""

TELEGRAM_HOME="$PROGSATIVOS_DIR/Telegram"
echoout "TELEGRAM_HOME=\"$PROGSATIVOS_DIR/Telegram\""

JAVA_21_TEMURIM_HOME="$PROGSATIVOS_DIR/javasdks/temurim/jdk-21.0.8+9"
echoout "JAVA_21_TEMURIM_HOME=\"$PROGSATIVOS_DIR/javasdks/temurim/jdk-21.0.8+9\""

JAVA_17_TEMURIM_HOME="$PROGSATIVOS_DIR/javasdks/temurim/jdk-17.0.16+8"
echoout "JAVA_17_TEMURIM_HOME=\"$PROGSATIVOS_DIR/javasdks/temurim/jdk-17.0.16+8\""

JAVA_11_TEMURIM_HOME="$PROGSATIVOS_DIR/javasdks/temurim/jdk-11.0.28+6"
echoout "JAVA_11_TEMURIM_HOME=\"$PROGSATIVOS_DIR/javasdks/temurim/jdk-11.0.28+6\""

export _SQUIRREL_SQL_HOME="$PROGSATIVOS_DIR/ides-dbs/SQuirreLSQL/squirrelsql-5.0.0-optional"
echoout "_SQUIRREL_SQL_HOME=\"$PROGSATIVOS_DIR/ides-dbs/SQuirreLSQL/squirrelsql-5.0.0-optional\""

echo "[INFO] Using Java JDK version: ${_defaults["javaJdkVersion"]}"
if [ ${_defaults["javaJdkVersion"]} == "21" ]; then    
    JAVA_HOME=$JAVA_21_TEMURIM_HOME
elif [ ${_defaults["javaJdkVersion"]} == "17" ]; then
    JAVA_HOME=$JAVA_17_TEMURIM_HOME
elif [ ${_defaults["javaJdkVersion"]} == "11" ]; then
    JAVA_HOME=$JAVA_11_TEMURIM_HOME
else
    echo "[ERROR]: Java JDK version not supported: ${_defaults["javaJdkVersion"]}"     
fi  

fzl-add-to-path $JAVA_HOME/bin
fzl-add-to-path $_THIS_PATH
chmod +x $_THIS_PATH/*.sh

echo "[info] jdk version"
java -version


# ### Install Nerd fonts ###



###### SOURCING SCRIPTS FOR ACTIVATE ITS FEATURES #######
#array of files names to be sourced
sources_files=(
    sync-files.sh
    dev-android.sh 
    dev-java.sh 
    dev-javafx.sh
    dev-ides.sh 
    dev-ides-eclipse.sh
    dev-ides-intellij.sh
    
    compare-files-and-dirs.sh
    
    ffmpeg.sh 
    DotEnv.sh 
    fzl-ambiente-dev-php-fpm-moodle-joomla.sh 
    screencast-scripts.sh 
    ./multimedia/multimedia-scripts.sh
    ./devices/fzl-touchpad-enable-click-on-tap.sh
    ./samba/fzl-smb-criar-pasta-compartilhada-publica.sh
    ./libvirt/fzl-libvirt.sh 
    docker.sh docker-containers.sh 
    
    dev-servers.sh dev-android.sh dev-nodejs.sh bash-config.sh convert-files.sh 
     
    fzl-emacs.sh)

for file in ${sources_files[@]}; do
    source $_THIS_PATH/$file
done


### Battery info
function fzl-battery-info(){
    upower -i $(upower -e | grep 'BAT') | grep --color=never -E "state|to\ full|percentage"
}
export -f fzl-battery-info

function fzl-battery-info-verbose(){
    upower -i $(upower -e | grep 'BAT')
}
export -f fzl-battery-info-verbose

### Multimedia commands
function fzl-ffmpeg-screencast-record(){
    echo "Starting screen recording with ffmpeg..."
    echo "Running command: bash $_THIS_PATH/multimedia/ffmpeg-screencast-record.sh"
    echo "Output file will be saved in ~/GRAVACOES-ffmpeg/ with a timestamped name."
    bash $_THIS_PATH/multimedia/ffmpeg-screencast-record.sh
}



### Functions to starts some apps
function fzl-bruno-start(){
    chmod +x $_BRUNO_AppImage
    $_BRUNO_AppImage
}
export -f fzl-bruno-start

function fzl-zotero-start(){
    "$ZOTERO_HOME/zotero" &
}

function fzl-telegram-start(){
    "$TELEGRAM_HOME/Telegram" &
}

function fzl-google-drive-start(){
    google-drive-ocamlfuse ~/GDrive/
}

function fzl-ansible--setup-ansible-cfg(){    
    export ANSIBLE_CONFIG=$PROGSATIVOS_DIR/setup-progsativos-scripts/ansible.cfg
}
export -f fzl-ansible--setup-ansible-cfg

#servers
export -f fzl-google-drive-start

#desktop apps
export -f fzl-telegram-start


#devs sdks
export -f fzl-zotero-start

#utils
export -f fzl-show-env-vars
