#!/bin/bash


# Exit immediately if a command exits with a non-zero status.
set -e


###
### INSTALL SOME FONTS FROM RPM packages
###
function install_mscorefonts(){
    sudo dnf upgrade --refresh

    # install some dependencies to be able to install another fonts
    # specially microsoft fonts
    sudo dnf install curl cabextract xorg-x11-font-utils fontconfig

    # install from rpm
    sudo rpm -i --nodigest https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

    # rrefreh font cache
    fc-cache -fv

    # shows intalled fonts
    fc-list | grep -i "Arial\|Times\|Verdana\|Courier"
}
#install_mscorefonts





# system fonts dir ( for all users )
FONT_INSTALLATION_DIR="/usr/local/share/fonts"
sudo mkdir -p $FONT_INSTALLATION_DIR


# Define the temporary directory for download and extraction
TEMP_DIR=$(mktemp -d)
DOWNLOAD_DIR="/run/media/wgn/ext4/SHARED_FILES/fonts-downloaded"

declare -A fonts_to_be_installed
fonts_to_be_installed["FiraCode"]="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip"
fonts_to_be_installed["BigBlueTerminal"]="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/BigBlueTerminal.zip"

###
### INSTALL NERD FONTS
###
function install_nerdfonts(){

    #downloading fonts
    #https://docs.fedoraproject.org/en-US/quick-docs/fonts/
    for f in ${!fonts_to_be_installed[@]}; do        
        fontZipFileName="$f.zip"
        fontUrl=${fonts_to_be_installed[$f]}
        echo $fontZipFileName
        echo $fontUrl

        wget --quiet --show-progress  -O "$DOWNLOAD_DIR/$fontZipFileName" "$fontUrl"

        sudo mkdir -p "$FONT_INSTALLATION_DIR/$f"
        sudo unzip -q "$DOWNLOAD_DIR/$fontZipFileName" -d "$FONT_INSTALLATION_DIR/$f"
        sudo chown -R root: "$FONT_INSTALLATION_DIR/$f"
        sudo chmod 644 -R "$FONT_INSTALLATION_DIR/$f/" 
        sudo restorecon -vFr "$FONT_INSTALLATION_DIR/$f"
    done;
}
install_nerdfonts
sudo fc-cache -v

fc-list | grep -i "fira"

