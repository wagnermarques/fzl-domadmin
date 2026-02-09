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


PROGSATIVOS_DIR_EXT4_PARTITION_REDHAT_LIKE_DISTROS="/run/media/wgn/ext4/progsativos"
PROGSATIVOS_DIR_EXT4_PARTITION_DEBIAN_LIKE_DISTROS="/media/wgn/ext4/progsativos"

PROGSATIVOS_DIR_BTRFS400G_PARTITION_DEBIAN_LIKE_DISTROS="/media/wgn/btrfs400G/PROGSATIVOS"
PROGSATIVOS_DIR_BTRFS400G_PARTITION_REDHAR_LIKE_DISTROS="/run/media/wgn/btrfs400G/PROGSATIVOS"


#usando a particao ext4 como padrao, por enquanto
PROGSATIVOS_DIR="$PROGSATIVOS_DIR_EXT4_PARTITION_REDHAT_LIKE_DISTROS"


### change PROGSATIVOS DIRECTORY TO
### THE PARTITION YOU USE OR CUSTOMIZE ID HERE
### PROGSATIVOS DIRECTORY IS THE BASE DIRECTORY FOR ALL PROGSATIVOS FILES, INCLUDING IDES, RESEARCH, JAVA SDKS, AND OTHER TOOLS
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


echoout1 "GLOBAL VARIABLES: IDES"
echoout2 "GLOBAL VARIABLES: compiled emacs executable depends on the OS type debian like or redhat like"
# detect if os is debian like or redhat like

OS_FAMILY=$(fzl-os-utils-detect-os --family)
OS_ID=$(fzl-os-utils-detect-os --id)


if [ "$OS_FAMILY" == "debian" ]; then
    echoout "OS is debian like"
elif [ "$OS_FAMILY" == "rhel" ]; then
    echoout "OS is redhat like"
else
    echo "[ERROR] OS type not supported: $OS_FAMILY"
fi
echo OS_ID=$OS_ID
echo OS_FAMILY=$OS_FAMILY
echo .
echo .
# use
# /media/wgn/btrfs400G/PROGSATIVOS/ides/emacs/emacs-30.2/src/emacs in debian like
# and
#/run/media/wgn/ext4/progsativos/ides/emacs/emacs-30.2/src/emacs-fed-41 in redhat like

if [ "$OS_FAMILY" == "debian" ] || [ "$OS_ID" == "ubuntu" ]; then
    export _EMACS_EXECUTABLE="$PROGSATIVOS_DIR_BTRFS400G_PARTITION_DEBIAN_LIKE_DISTROS/ides/emacs/emacs-30.2/src/emacs"
elif [ "$OS_FAMILY" == "fedora" ] || [ "$OS_FAMILY" == "rhel" ]; then
    export _EMACS_EXECUTABLE="$PROGSATIVOS_DIR_BTRFS400G_PARTITION_REDHAR_LIKE_DISTROS/ides/emacs/emacs-30.2/src/emacs-fed-41"
else
    echo "[ERROR] OS type not supported: $OS_ID"
fi

_FZL_EMACS_HOME="$_PROJECTS_SRCS_DESKTOP/fzl-emacs" #fzl-emacs-start command

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
