#!/bin/bash

_FZL_EMACS_HOME="/media/wgn/EnvsBk/__devenv__/fzl-emacs"
function fzl-emacs-start(){        
    cd $_FZL_EMACS_HOME
    cd ./main/src/lispsite/
    emacs -q -l init.el &
}
export -f fzl-emacs-start

