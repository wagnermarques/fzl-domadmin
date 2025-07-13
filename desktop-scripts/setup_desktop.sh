#!/bin/bash

declare -A _defaults=(
    ["javaJdkVersion"]="21" 
    ["tomcatVersion"]="9")


# #### RESOLVING PATHS #####

#DETECT THIS SCRIPT PATH
FZL_DESKTOP_SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PATH=$PATH:$FZL_DESKTOP_SCRIPT_PATH


#ALGUNS OS SCRIPTS FAZEM USO DESTES DIRETORIOS
PROGSATIVOS_DIR="/run/media/wgn/d4ae1cfc-8228-4bec-a0cc-c6b7345e29bd/PROGSATIVOS"

# caminho pra algumas ides
_FZL_EMACS_HOME="/run/media/wgn/EnvsBk/__devenv__/fzl-emacs"
VSCODE_EXTERNAL_DISK="$PROGSATIVOS_DIR/ides/VSCode-linux-x64/"
VSCODE_HOST_DISK="/home/wgn/PROGSATIVOS/VSCode-linux-x64/"

_ECLIPSE_JAVA_HOME=$PROGSATIVOS_DIR/java-ides/eclipse-java-2023-06-R-linux-gtk-x86_64/eclipse
_ECLIPSE_MODELLING_HOME=$PROGSATIVOS_DIR/Ides/eclipse/eclipse-modeling-2025-06-R-linux-gtk-x86_64/eclipse

#caminhos para alguns outros aplicativos desktop
ZOTERO_HOME="$PROGSATIVOS_DIR/Research/Zotero_linux-x86_64"
TELEGRAM_HOME="$PROGSATIVOS_DIR/Telegram/Telegram"


function fzl-add-to-path(){
    export PATH=$PATH:$1
}
export -f fzl-add-to-path


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
    multimedia-scripts.sh 
    docker.sh docker-containers.sh 
    
    dev-servers.sh dev-android.sh dev-nodejs.sh bash-config.sh convert-files.sh 
     
    fzl-emacs.sh)

# add in array if gnome are in use by the user
if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
    echo .
    echo " ===> GNOME detected, sourcing some gnome scripts"
    sources_files+=(
        #gnome_screenshots_shortcuts.sh
    )
fi


for file in ${sources_files[@]}; do
    source $FZL_DESKTOP_SCRIPT_PATH/$file
done


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
