#!/bin/bash

echo "[path_utils.sh] running..."

function fzl-add-to-path(){
    export PATH=$1:$PATH
}
export -f fzl-add-to-path
