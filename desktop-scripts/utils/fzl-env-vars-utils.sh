#!/bin/bash

# list environment variables that start with FZL_
function fzl-env-vars--list-fzl-variables() {
    env | grep '^FZL_' || true
}
export -f fzl-env-vars--list-fzl-variables
