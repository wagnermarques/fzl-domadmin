#!/bin/bash

#if /media/wgn/d4ae1cfc-8228-4bec-a0cc-c6b7345e29bd/PROGSATIVOS/ides/VSCode-linux-x64/
 echo "@... dev-ides.sh"

 VSCODE_EXTERNAL_DISK="$PROGSATIVOS_DIR/ides/VSCode-linux-x64/"
 VSCODE_HOST_DISK="/home/wgn/PROGSATIVOS/VSCode-linux-x64/"

 function fzl-intellij-start(){
     cd $PROGSATIVOS_DIR/Ides/intellij/idea-IU-243.24978.46/bin
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
  
#db front ends
function fzl-squirrelsql-start(){
  fzl-java-se
  java -jar "$PROGSATIVOS_DIR/db-ides/squirrelsql-4.6.0-optional/squirrel-sql.jar"
}
export -f fzl-squirrelsql-start


function fzl-scenebuilder-start(){
    "$PROGSATIVOS_DIR/java-ides/JavaFXSceneBuilder2.0/JavaFXSceneBuilder2.0"
}


