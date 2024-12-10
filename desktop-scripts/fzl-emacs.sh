#!/bin/bash

function fzl-emacs-start(){        
    cd $PROGSATIVOS_DIR
    cd ./fzl-emacs    
    cd ./main/src/lispsite/
    emacs -q -l init.el &
}
export -f fzl-emacs-start

