#!/bin/bash

echo "[setup_desktop.sh] running..."




# get this script path
_THIS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo _THIS_PATH=$_THIS_PATH

source "$_THIS_PATH/utils/path_utils.sh"
source "$_THIS_PATH/utils/params_utils.sh"
fzl-add-to-path "$_THIS_PATH"/bin




# some specific setup for different machines
# without machine name, it will use "desktop" as default
# if machine name is "cdep", it will mount /dev/sda4 to ~/
machine_name_from_params=$(get_param "machine_name")
echo "[setup_desktop.sh] machine_name_from_params=$machine_name_from_params"
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
sleep 10


# common actions for all machines
PROGSATIVOS_DIR="/run/media/wgn/libvirt_ext4/progsativos"



# ===== caminho pra algumas ides  =====
_ECLIPSE_JAVA_HOME=$PROGSATIVOS_DIR/java-ides/eclipse-java-2023-06-R-linux-gtk-x86_64/eclipse
_ECLIPSE_MODELLING_HOME=$PROGSATIVOS_DIR/Ides/eclipse/eclipse-modeling-2025-06-R-linux-gtk-x86_64/eclipse

_FZL_EMACS_HOME="/run/media/wgn/libvirt_ext4/Projects-Srcs-Desktop/fzl-emacs"



#caminhos para alguns outros aplicativos desktop
ZOTERO_HOME="$PROGSATIVOS_DIR/research/Zotero_linux-x86_64"
TELEGRAM_HOME="$PROGSATIVOS_DIR/Telegram"



# ===== programming languages sdks =====
# Java JDKs
declare -A _defaults=(
    ["javaJdkVersion"]="21" 
    ["tomcatVersion"]="9")

JAVA_21_TEMURIM_HOME="$PROGSATIVOS_DIR/javasdks/temurim/jdk-21.0.8+9"
JAVA_17_TEMURIM_HOME="$PROGSATIVOS_DIR/javasdks/temurim/jdk-17.0.16+8"
JAVA_11_TEMURIM_HOME="$PROGSATIVOS_DIR/javasdks/temurim/jdk-11.0.28+6"

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
    
    compare-files-and-dirs.sh
    
    ffmpeg.sh 
    DotEnv.sh 
    fzl-ambiente-dev-php-fpm-moodle-joomla.sh 
    screencast-scripts.sh 
    ./multimedia/multimedia-scripts.sh
    ./devices/fzl-touchpad-enable-click-on-tap.sh
    docker.sh docker-containers.sh 
    
    dev-servers.sh dev-android.sh dev-nodejs.sh bash-config.sh convert-files.sh 
     
    fzl-emacs.sh)

for file in ${sources_files[@]}; do
    source $_THIS_PATH/$file
done






### Multimedia commands
function fzl-ffmpeg-screencast-record(){
    bash ./multimedia/ffmpeg-screencast-record.sh
}

### Funcoes
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
