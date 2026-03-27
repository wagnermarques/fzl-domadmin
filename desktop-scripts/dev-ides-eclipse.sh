#!/bin/bash

function fzl-sts-start(){
    "$PROGSATIVOS_DIR/java-ides/sts-4.22.0.RELEASE/SpringToolSuite4"
}
export -f fzl-sts-start

function fzl-eclipse-modelling-start(){
    echo .
    echo "[DEV-IDES-ECLIPSE] function fzl-eclipse-modelling-start(){...."
    echo "[DEV-IDES-ECLIPSE] Using Java JDK version: ${_defaults["javaJdkVersion"]}"
    echo "[DEV-IDES-ECLIPSE] _ECLIPSE_MODELLING_HOME = $_ECLIPSE_MODELLING_HOME"    
    "$_ECLIPSE_MODELLING_HOME/eclipse"
}
export -f fzl-eclipse-modelling-start


function fzl-eclipse-jee-start(){
    echo .
    echo "[DEV-IDES-ECLIPSE] function fzl-eclipse-jee-start(){...."
    echo "[DEV-IDES-ECLIPSE] Using Java JDK version: ${_defaults["javaJdkVersion"]}"
    echo "[DEV-IDES-ECLIPSE] _ECLIPSE_JEE_HOME = $_ECLIPSE_JEE_HOME"    
    "$_ECLIPSE_JEE_HOME/eclipse"
}
export -f fzl-eclipse-jee-start


function fzl-eclipse-embedcpp-start(){
    echo .
    "$_ECLIPSE_EMBEDCPP_HOME/eclipse"
}
export -f fzl-eclipse-embedcpp-start


function fzl-eclipse-php-start(){
    echo .
    "$_ECLIPSE_PHP_HOME/eclipse"
}
export -f fzl-eclipse-php-start

