#!/bin/bash
# echo "[params_utils.sh] running..."
# This script contains utility functions for managing parameters in a Bash script.
# It provides functions to set, get, and check parameters, as well as to print all parameters.
# Usage:
#   source params_utils.sh
#   set_param "key" "value"
#   get_param "key"
#   check_param "key"
#   print_params
# Global associative array to store parameters

declare -A params
# Function to set a parameter
set_param() {
    local key="$1"
    local value="$2"
    params["$key"]="$value"
}

# Function to get a parameter
get_param() {
    local key="$1"
    echo "${params[$key]}"
}

# Function to check if a parameter exists
check_param() {
    local key="$1"
    if [[ -n "${params[$key]}" ]]; then
        echo "true"
    else
        echo "false"
    fi
}

# Function to print all parameters
print_params() {
    echo "Parameters:"
    for key in "${!params[@]}"; do
        echo "$key: ${params[$key]}"
    done
}

