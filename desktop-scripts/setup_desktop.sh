#!/bin/bash

declare -A _defaults=(
    ["javaJdkVersion"]="21" 
    ["tomcatVersion"]="9")


#DETECT THIS SCRIPT PATH
FZL_DESKTOP_SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PATH=$PATH:$FZL_DESKTOP_SCRIPT_PATH


#ALGUNS OS SCRIPTS FAZEM USO DESTES DIRETORIOS
PROGSATIVOS_DIR="/media/wgn/d4ae1cfc-8228-4bec-a0cc-c6b7345e29bd/PROGSATIVOS"
_FZL_EMACS_HOME="/media/wgn/EnvsBk1/__devenv__/fzl-emacs"


#PATH OPERACIONS SUPPORT 
function fzl-add-to-path(){
    export PATH=$PATH:$1
}
export -f fzl-add-to-path


###### SOURCING SCRIPTS FOR ACTIVE FEATURES #######
#array of files names to be sourced
sources_files=(
    dev-java.sh 
    dev-javafx.sh
    dev-ides.sh 
    dev-ides-eclipse.sh
    
    compare-files-and-dirs.sh
    
    ffmpeg.sh 
    DotEnv.sh 
    fzl-ambiente-dev-php-fpm-moodle-joomla.sh 
    screencast-scripts.sh 
    multimedia-scripts.sh 
    docker.sh docker-containers.sh 
    
    dev-servers.sh dev-android.sh dev-nodejs.sh bash-config.sh convert-files.sh 
     
    fzl-emacs.sh)



for file in ${sources_files[@]}; do
    source $FZL_DESKTOP_SCRIPT_PATH/$file
done


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
