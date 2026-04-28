#!/bin/bash

if [ -n "${_FZL_PATH_UTILS_LOADED:-}" ]; then
    return 0
fi
export _FZL_PATH_UTILS_LOADED=1

echo "[path_utils.sh] running..."

function fzl-add-to-path(){
    export PATH=$1:$PATH
}
export -f fzl-add-to-path


