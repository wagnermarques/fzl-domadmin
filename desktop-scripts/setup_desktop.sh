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
source "$_THIS_PATH/utils/progsativos_utils.sh"
source "$_THIS_PATH/utils/params_utils.sh"
source "$_THIS_PATH/utils/os-utils.sh"
source "$_THIS_PATH/utils/fzl-env-vars-utils.sh"

# Load .env if present to override defaults (variables in KEY=VAL form)
if [ -f "$_THIS_PATH/.env" ]; then
  # export all variables from .env into environment temporarily
  set -o allexport
  source "$_THIS_PATH/.env"
  set +o allexport
fi

# Provide sensible defaults when variables are not set
: ${_BASE_PATH:="/home/wgn/WORKING"}
: ${_PROGSATIVOS_DIR:="${_BASE_PATH}/progsativos"}

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
export FZL_BASE_PATH="${_BASE_PATH:-/home/wgn/WORKING}"
export FZL_PROGSATIVOS_DIR="${FZL_BASE_PATH:-/home/wgn/WORKING}"

# app images depends of sudo dnf install libfuse2
fzl-export-path _BRUNO_AppImage \
    "$_PROGSATIVOS_DIR/tools/bruno/current" \
    "$_PROGSATIVOS_DIR/tools/bruno/current.AppImage" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/tools/bruno" "*.AppImage")" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/tools" "bruno*.AppImage")"
function fzl-bruno-start(){ "$_BRUNO_AppImage" & }
export -f fzl-bruno-start
echoout _BRUNO_AppImage=$_BRUNO_AppImage

fzl-export-path ZOTERO_HOME \
    "$_PROGSATIVOS_DIR/research/zotero/current" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/research/zotero" "*")" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/research" "Zotero*")" \
    "$_PROGSATIVOS_DIR/research/Zotero_linux-x86_64"
echoout "ZOTERO_HOME=\"$ZOTERO_HOME\""

fzl-export-path TELEGRAM_HOME \
    "$_PROGSATIVOS_DIR/communication/telegram/current" \
    "$_PROGSATIVOS_DIR/Telegram"
echoout "TELEGRAM_HOME=\"$TELEGRAM_HOME\""

fzl-export-path JAVA_21_TEMURIM_HOME \
    "$_PROGSATIVOS_DIR/java/temurin/21/current" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/javasdks/temurim" "jdk-21*")" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/javasdks/temurin" "jdk-21*")"
echoout "JAVA_21_TEMURIM_HOME=\"$JAVA_21_TEMURIM_HOME\""

fzl-export-path JAVA_17_TEMURIM_HOME \
    "$_PROGSATIVOS_DIR/java/temurin/17/current" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/javasdks/temurim" "jdk-17*")" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/javasdks/temurin" "jdk-17*")"
echoout "JAVA_17_TEMURIM_HOME=\"$JAVA_17_TEMURIM_HOME\""

fzl-export-path JAVA_11_TEMURIM_HOME \
    "$_PROGSATIVOS_DIR/java/temurin/11/current" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/javasdks/temurim" "jdk-11*")" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/javasdks/temurin" "jdk-11*")"
echoout "JAVA_11_TEMURIM_HOME=\"$JAVA_11_TEMURIM_HOME\""

fzl-export-path _SQUIRREL_SQL_HOME \
    "$_PROGSATIVOS_DIR/db/squirrelsql/current" \
    "$_PROGSATIVOS_DIR/ides-dbs/SQuirreLSQL/current" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/ides-dbs/SQuirreLSQL" "squirrelsql*")"
echoout "_SQUIRREL_SQL_HOME=\"$_SQUIRREL_SQL_HOME\""

fzl-export-path _DBEAVER_HOME \
    "$_PROGSATIVOS_DIR/db/dbeaver/current" \
    "$_PROGSATIVOS_DIR/ides/ides-dbs/dbeaver" \
    "$_PROGSATIVOS_DIR/ides-dbs/dbeaver"
echoout "_DBEAVER_HOME=\"$_DBEAVER_HOME\""

fzl-export-path _STS_HOME \
    "$_PROGSATIVOS_DIR/ide/sts/current" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/java-ides" "sts-*")"
echoout "_STS_HOME=\"$_STS_HOME\""

fzl-export-path _VSCODE_HOME \
    "$_PROGSATIVOS_DIR/ide/vscode/current" \
    "$_PROGSATIVOS_DIR/ides/vscode/current" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/ides" "VSCode-linux-*")" \
    "$(fzl-first-matching-path "$_PROGSATIVOS_DIR/ide" "VSCode-linux-*")"
echoout "_VSCODE_HOME=\"$_VSCODE_HOME\""

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


fzl-add-to-path "$JAVA_HOME/bin"
fzl-add-to-path "$_THIS_PATH"
chmod +x "$_THIS_PATH"/*.sh

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

# TODO: ajustar path do ansible
function fzl-ansible--setup-ansible-cfg(){    
    local ansible_cfg

    ansible_cfg="$(fzl-first-existing-path \
        "$_PROGSATIVOS_DIR/automation/ansible/current/ansible.cfg" \
        "$_PROGSATIVOS_DIR/setup-progsativos-scripts/ansible.cfg")"

    if [ -n "$ansible_cfg" ]; then
        export ANSIBLE_CONFIG="$ansible_cfg"
    else
        export ANSIBLE_CONFIG="$_PROGSATIVOS_DIR/automation/ansible/current/ansible.cfg"
    fi
}
export -f fzl-ansible--setup-ansible-cfg

#servers
export -f fzl-google-drive-start

#desktop apps
export -f fzl-telegram-start


#devs sdks
export -f fzl-zotero-start
export -f fzl-dbeaver-start

