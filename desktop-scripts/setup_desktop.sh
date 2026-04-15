#!/bin/bash

echo "[setup_desktop.sh] running..."

function echoerr()  { echo "$@" 1>&2; }
function echoout()  { echo "$@"; }
function echoout1() { echo " ############### " "$@" " ###############"; }
function echoout2() { echo "----- " "$@"; }

echo .
echoout1 "Setup paths and source utils scripts"

echoout2 "Config PATH environment variable"
_THIS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echoout _THIS_PATH=$_THIS_PATH

source "$_THIS_PATH/utils/path_utils.sh"
source "$_THIS_PATH/utils/params_utils.sh"
source "$_THIS_PATH/utils/os-utils.sh"

# Load .env if present to override defaults (variables in KEY=VAL form)
if [ -f "$_THIS_PATH/.env" ]; then
  # export all variables from .env into environment temporarily
  set -o allexport
  source "$_THIS_PATH/.env"
  set +o allexport
fi

# Provide sensible defaults when variables are not set
: ${_BASE_PATH:="/home/wgn/WORKING"}
: ${_PROGSATIVOS_DIR:="${_BASE_PATH}/Progsativos"}
: ${_FZL_EMACS_HOME:="${_BASE_PATH}/Projects-Srcs/Projects-Srcs-Desktop/fzl-emacs"}

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

OS_FAMILY=$(fzl-os-utils-detect-os --family)
OS_ID=$(fzl-os-utils-detect-os --id)

# Base path: prefer value from .env or earlier defaults
export _BASE_PATH="${_BASE_PATH:-/home/wgn/WORKING}"
echoout "_BASE_PATH=$_BASE_PATH"

# my applications
export _PROGSATIVOS_DIR="${_PROGSATIVOS_DIR:-$_BASE_PATH/Progsativos}"

# emacs customization
export _FZL_EMACS_HOME="${_FZL_EMACS_HOME:-$_BASE_PATH/Projects-Srcs/Projects-Srcs-Desktop/fzl-emacs}"
echoout "_FZL_EMACS_HOME=$_FZL_EMACS_HOME"

echo .
echoout2 "Android platform (Android Studio, Android SDK and scrcpy)"
ANDROID_STUDIO_HOME="$_PROGSATIVOS_DIR/ides/android/android-studio-panda1-linux/android-studio"
ANDROID_SDK_HOME="$_PROGSATIVOS_DIR/android-sdk"

export ANDROID_SDK_ROOT=$ANDROID_SDK_HOME
export ANDROID_HOME=$ANDROID_SDK_HOME

fzl-add-to-path $ANDROID_SDK_ROOT/platform-tools
fzl-add-to-path $ANDROID_SDK_ROOT/tools
fzl-add-to-path $ANDROID_SDK_ROOT/tools/bin
fzl-add-to-path $ANDROID_SDK_ROOT/emulator
fzl-add-to-path $ANDROID_SDK_ROOT/cmdline-tools/tools/bin


echo .
#scrcpy
#https://github.com/Genymobile/scrcpy/blob/master/doc/linux.mdhttps://github.com/Genymobile/scrcpy
#sudo apt install ffmpeg libsdl2-2.0-0 adb wget \
#                 gcc git pkg-config meson ninja-build libsdl2-dev \
#                 libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev \
#                 libswresample-dev libusb-1.0-0 libusb-1.0-0-dev
_SCRCPY_HOME=$_PROGSATIVOS_DIR/Android/scrcpy-linux-x86_64-v3.3.4
#we will create fzl-scrcpy functions to work with scrcpy
#because add it to path will conflict with android platfroms added before
#fzl-add-to-path $_SCRCPY_HOME  
echoout "_SCRCPY_HOME=$_SCRCPY_HOME"


echo .
echoout2 "Eclipse ides..."
export _ECLIPSE_JEE_HOME=$_PROGSATIVOS_DIR/ides/eclipse/eclipse-jee-2026-03-R-linux-gtk-x86_64
echoout "_ECLIPSE_JEE_HOME=$_ECLIPSE_JEE_HOME"

export _ECLIPSE_EMBEDCPP_HOME=$_PROGSATIVOS_DIR/ides/eclipse/eclipse-embedcpp-2026-03-R-linux-gtk-x86_64
echoout "_ECLIPSE_EMBEDCPP_HOME=$_ECLIPSE_EMBEDCPP_HOME"

export _ECLIPSE_PHP_HOME=$_PROGSATIVOS_DIR/ides/eclipse/eclipse-php-2026-03-R-linux-gtk-x86_64
echoout "_ECLIPSE_PHP_HOME=$_ECLIPSE_PHP_HOME"

export _ECLIPSE_MODELLING_HOME=$_PROGSATIVOS_DIR/ides/eclipse/eclipse-modeling-2026-03-R-linux-gtk-x86_64
echoout "_ECLIPSE_MODELLING_HOME=$_ECLIPSE_MODELLING_HOME"


echo .
echoout2 "Jetbrains ides..."
export _INTELLIJ_HOME=$_PROGSATIVOS_DIR/ides/idea-IU-252.23892.409
echoout _INTELLIJ_HOME=$_PROGSATIVOS_DIR/ides/idea-IU-252.23892.409

#https://www.jetbrains.com/webstorm/download/download-thanks.html
#https://www.jetbrains.com/clion/download/?section=linux
#https://www.jetbrains.com/pycharm/download/?section=linux
#https://www.jetbrains.com/webstorm/download/download-thanks.html
#https://www.jetbrains.com/clion/download/?section=linux
#https://www.jetbrains.com/pycharm/download/?section=linux



# app images depends of sudo dnf install libfuse2
export _BRUNO_AppImage="$_PROGSATIVOS_DIR/tools/bruno_3.2.0_x86_64_linux.AppImage"
function fzl-bruno-start(){ bash $_BRUNO_AppImage; } 
export -f fzl-bruno-start
echoout _BRUNO_AppImage=$_BRUNO_AppImage

ZOTERO_HOME="$_PROGSATIVOS_DIR/research/Zotero_linux-x86_64"
echoout "ZOTERO_HOME=\"$_PROGSATIVOS_DIR/research/Zotero_linux-x86_64\""

TELEGRAM_HOME="$_PROGSATIVOS_DIR/Telegram"
echoout "TELEGRAM_HOME=\"$_PROGSATIVOS_DIR/Telegram\""

JAVA_21_TEMURIM_HOME="$_PROGSATIVOS_DIR/javasdks/temurim/jdk-21.0.8+9"
echoout "JAVA_21_TEMURIM_HOME=\"$_PROGSATIVOS_DIR/javasdks/temurim/jdk-21.0.8+9\""

JAVA_17_TEMURIM_HOME="$_PROGSATIVOS_DIR/javasdks/temurim/jdk-17.0.16+8"
echoout "JAVA_17_TEMURIM_HOME=\"$_PROGSATIVOS_DIR/javasdks/temurim/jdk-17.0.16+8\""

JAVA_11_TEMURIM_HOME="$_PROGSATIVOS_DIR/javasdks/temurim/jdk-11.0.28+6"
echoout "JAVA_11_TEMURIM_HOME=\"$_PROGSATIVOS_DIR/javasdks/temurim/jdk-11.0.28+6\""

export _SQUIRREL_SQL_HOME="$_PROGSATIVOS_DIR/ides-dbs/SQuirreLSQL/squirrelsql-5.0.0-optional"
echoout "_SQUIRREL_SQL_HOME=\"$_PROGSATIVOS_DIR/ides-dbs/SQuirreLSQL/squirrelsql-5.0.0-optional\""

export _DBEAVER_HOME="$_PROGSATIVOS_DIR/ides/ides-dbs/dbeaver"
echoout "_DBEAVER_HOME=\"$_DBEAVER_HOME\""

echo "[INFO] Using Java JDK version: ${_defaults["javaJdkVersion"]}"
if [ "${_defaults[javaJdkVersion]}" == "21" ]; then    
    JAVA_HOME=$JAVA_21_TEMURIM_HOME
elif [ "${_defaults[javaJdkVersion]}" == "17" ]; then
    JAVA_HOME=$JAVA_17_TEMURIM_HOME
elif [ "${_defaults[javaJdkVersion]}" == "11" ]; then
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
export -f fzl-dbeaver-start

#utils
export -f fzl-show-env-vars
