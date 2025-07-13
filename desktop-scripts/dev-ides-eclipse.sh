#!/bin/bash

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




