#!/bin/bash

#https://gluonhq.com/products/javafx/
#https://www.oracle.com/java/technologies/javafxscenebuilder-1x-archive-downloads.html
#https://www.oracle.com/java/technologies/javafxscenebuilder-1x-archive-downloads.html#license-lightbox

SCENEBUILDER_JAR=$PROGSATIVOS_DIR/java-ides/scenebuilder-kit-23.0.1.jar
SCENEBUILDER_HOME=/media/wgn/d4ae1cfc-8228-4bec-a0cc-c6b7345e29bd/PROGSATIVOS/javafx/JavaFXSceneBuilder2.0
JAVAFX_SDK_HOME=$PROGSATIVOS_DIR/javafx/javafx-sdk-23.0.1

#starts javafx scenebuilder
function fzl-javafx-scenebuilder-start(){
    $SCENEBUILDER_HOME/JavaFXSceneBuilder2.0
    }

function fzl-javafx-scenebuilder-install-from-jar(){
    #TODO: implement this function
    #extracts scenebuilder jar to $PROGSATIVOS_DIR/java-ides
    fzl-jar -tf $SCENEBUILDER_JAR
}

export -f fzl-javafx-scenebuilder-start