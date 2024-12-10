#!/bin/bash

function fzl-bash-config--prompt-shortened(){
    export PS1='\u@\h: \W\$ '
}
export -f fzl-bash-config--prompt-shortened

function fzl-bash-config--prompt-red2yellow(){
    export PS1='\[\033[01;31m\]\u@\h\[\033[01;33m\]:\w\$\[\033[00m\] '
}
export -f fzl-bash-config--prompt-red2yellow

function fzl-bash-config--git-colors(){
    # Change untracked files (default red) to yellow
    git config --global color.status.untracked "yellow bold"

    # Change changed files (default red) to yellow
    git config --global color.status.changed "yellow bold"

    # Optionally, change added files (default green) to another color
    git config --global color.status.added "green bold"
}
export -f fzl-bash-config--git-colors

