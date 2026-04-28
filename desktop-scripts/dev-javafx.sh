#!/bin/bash

#https://gluonhq.com/products/javafx/
#https://www.oracle.com/java/technologies/javafxscenebuilder-1x-archive-downloads.html
#https://www.oracle.com/java/technologies/javafxscenebuilder-1x-archive-downloads.html#license-lightbox

SCENEBUILDER_JAR="${SCENEBUILDER_JAR:-$PROGSATIVOS_DIR/javafx/scenebuilder-kit/current}"
SCENEBUILDER_HOME="${SCENEBUILDER_HOME:-$PROGSATIVOS_DIR/javafx/scenebuilder/current}"
JAVAFX_SDK_HOME="${JAVAFX_SDK_HOME:-$PROGSATIVOS_DIR/javafx/sdk/current}"

#starts javafx scenebuilder
function fzl-javafx-scenebuilder-start(){
    if [ -x "$SCENEBUILDER_HOME/JavaFXSceneBuilder2.0" ]; then
        "$SCENEBUILDER_HOME/JavaFXSceneBuilder2.0"
    else
        "$SCENEBUILDER_HOME"
    fi
}

function fzl-javafx-scenebuilder-install-from-jar(){
    #TODO: implement this function
    #extracts scenebuilder jar to $PROGSATIVOS_DIR/java-ides
    fzl-jar -tf "$SCENEBUILDER_JAR"
}

export -f fzl-javafx-scenebuilder-start
