#!/bin/bash

#$_FZL_EMACS_HOME is defined in setup_desktop.sh script

function fzl-emacs-start(){
    cd $_FZL_EMACS_HOME 
    cd ./main/src/lispsite/ #needs entering in the directory to load the init.el file
    $_EMACS_EXECUTABLE -q -l init.el &
}
export -f fzl-emacs-start

