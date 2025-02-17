#!/bin/bash

_ECLIPSE_JAVA_HOME=$PROGSATIVOS_DIR/java-ides/eclipse-java-2023-06-R-linux-gtk-x86_64/eclipse
_ECLIPSE_MODELLING_HOME=$PROGSATIVOS_DIR/java-ides/eclipse-modeling-2024-03-R-linux-gtk-x86_64

#nao consegui fazer funcionar o muldisigner statndalone, mas com p2 funciona
function fzl-umldesigner-start(){
    source fzl-java-jdk-11
    bash "$PROGSATIVOS_DIR/java-ides/umldesigner/umldesigner"
}
export -f fzl-umldesigner-start

function fzl-eclipse-java-start(){
    java -version
    bash $_ECLIPSE_JAVA_HOME/eclipse &
}
export -f fzl-eclipse-java-start

function fzl-sts-start(){
  "$PROGSATIVOS_DIR/java-ides/sts-4.22.0.RELEASE/SpringToolSuite4"
}
export -f fzl-sts-start

function fzl-eclipse-modelling-start(){
    "$_ECLIPSE_MODELLING_HOME/eclipse"
}
export -f fzl-eclipse-modelling-start




