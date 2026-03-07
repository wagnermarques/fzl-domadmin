#!/bin/bash

function fzl-emacs-start(){

    # find the absolute path to the directory where the script itself is located,
    local script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/bin/fzl-emacs-start"
    
    if [ -x "$script_path" ]; then
        "$script_path" "$@"
    else
        echo "Error: Standalone script not found at $script_path"
        return 1
    fi
}
export -f fzl-emacs-start

