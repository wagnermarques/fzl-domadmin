#!/bin/bash

_ECLIPSE_JAVA_HOME=$PROGSATIVOS_DIR/java-ides/eclipse-java-2023-06-R-linux-gtk-x86_64/eclipse

function fzl-eclipse-java-start(){
	  bash $_ECLIPSE_JAVA_HOME/eclipse &
}

function fzl-sts-start(){
  "$PROGSATIVOS_DIR/java-ides/sts-4.22.0.RELEASE/SpringToolSuite4"
}

export -f fzl-sts-start
export -f fzl-eclipse-java-start