#!/bin/bash

#if /media/wgn/d4ae1cfc-8228-4bec-a0cc-c6b7345e29bd/PROGSATIVOS/ides/VSCode-linux-x64/
echo "@... dev-ides.sh"

PROGSATIVOS_inLibvirt_disk=/run/media/wgn/libvirt/PROGSATIVOS

function fzl-intellij-start(){
    cd $PROGSATIVOS_inLibvirt_disk/ides/intellij/idea-IC-252.27397.103/bin
    ./idea.sh
    cd -
}
export -f fzl-intellij-start


function fzl-vscode-setup-chrome-sandbox(){
  if [ -d $VSCODE_EXTERNAL_DISK ]; 
    then
      cd $VSCODE_EXTERNAL_DISK
      sudo chown root:root chrome-sandbox
      sudo chmod 4755 chrome-sandbox
      cd -
    else 
      cd $VSCODE_HOST_DISK
      sudo chown root:root chrome-sandbox
      sudo chmod 4755 chrome-sandbox
      cd -
  fi;
}
export -f fzl-vscode-setup-chrome-sandbox           


function fzl-vscode-start(){  
  if [ -d $VSCODE_EXTERNAL_DISK ]; 
    then
      cd $VSCODE_EXTERNAL_DISK
      ./code $1 --no-sandbox
      cd -
    else 
      cd $VSCODE_HOST_DISK
      ./code $1
      cd -
  fi;
}
export -f fzl-vscode-start


# the theia have appImage.home dir outside of host to make it portable
function fzl-theia-start(){
    pgrep -f "TheiaIDE\.AppImage"    
    cd $PROGSATIVOS_inLibvirt_disk/ides/eclipse-theia
    chmod +x TheiaIDE.AppImage
    ls -la TheiaIDE.AppImage
    echo $@
    #execute TheiaIDE.AppImage with args
    #TheiaIDE.AppImage --appimage-home    
    $PROGSATIVOS_inLibvirt_disk/ides/eclipse-theia/TheiaIDE.AppImage $@ &
}
export -f fzl-theia-start


#db front ends
function fzl-squirrelsql-start(){
  fzl-java-se
  java -jar "$PROGSATIVOS_DIR/db-ides/squirrelsql-4.8.0-optional/squirrel-sql.jar"
}
export -f fzl-squirrelsql-start


function fzl-scenebuilder-start(){
    "$PROGSATIVOS_DIR/java-ides/JavaFXSceneBuilder2.0/JavaFXSceneBuilder2.0"
}


