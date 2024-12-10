#!/bin/bash

#DETECT THIS SCRIPT PATH
FZL-DESKTOP_SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PATH=$PATH:$FZL-DESKTOP_SCRIPT_PATH

# the soureced srcipts uses this previouse variables
source setup-progsativos-scripts/ffmpeg.sh
source setup-progsativos-scripts/DotEnv.sh
source setup-progsativos-scripts/fzl-ambiente-dev-php-fpm-moodle-joomla.sh
source setup-progsativos-scripts/screencast-scripts.sh
source setup-progsativos-scripts/multimedia-scripts.sh
source setup-progsativos-scripts/docker.sh
source setup-progsativos-scripts/docker-containers.sh
source setup-progsativos-scripts/dev-java.sh #
source setup-progsativos-scripts/dev-ides.sh #
source setup-progsativos-scripts/dev-ides-eclipse.sh #
source setup-progsativos-scripts/dev-servers.sh #

source setup-progsativos-scripts/dev-android.sh #
source setup-progsativos-scripts/dev-nodejs.sh # 


source setup-progsativos-scripts/bash-config.sh # 
source setup-progsativos-scripts/convert-files.sh #

source setup-progsativos-scripts/fzl-emacs.sh

function fzl-vscode-start--at-progsativos(){
    cd $PROGSATIVOS_DIR/VisualStudioCode-linux-x64/ && ./code &
}
export -f fzl-vscode-start--at-progsativos



ZOTERO_HOME="$PROGSATIVOS_DIR/Research/Zotero_linux-x86_64"
function fzl-zotero-start(){
    "$ZOTERO_HOME/zotero" &
}

function fzl-telegram-start(){
    "$PROGSATIVOS_DIR/Telegram/Telegram/Telegram" &
}

function fzl-google-drive-start(){
    google-drive-ocamlfuse ~/GDrive/
}

function fzl-show-env-vars(){
    echo "JAVA_HOME=$JAVA_HOME"
    echo "GRADLE_HOME=$GRADLE_HOME"
    echo "M2_HOME=$M2_HOME"
    echo "ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT"
    echo "ANDROID_HOME=$ANDROID_HOME"
    echo "ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT"
    echo "ZOTERO_HOME=$ZOTERO_HOME"
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
