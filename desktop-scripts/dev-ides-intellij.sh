#!/bin/bash

function fzl-intellij-idea-start(){
    java -version
    bash "$_INTELLIJ_HOME/bin/idea.sh" &
}
export -f fzl-intellij-idea-start
