#!/bin/bash

function fzl-compare-dir-show-files-diference(){
    # First directory
    dir1=$1

    # Second directory
    dir2=$2

    # Check if directories are provided
    if [ -z "$dir1" ] || [ -z "$dir2" ]; then
        echo "Usage: $0 <directory1> <directory2>"
        echo "This script lists files that exist in the first directory but not in the second directory."
        echo "Arguments:"
        echo "  <directory1>  Path to the first directory"
        echo "  <directory2>  Path to the second directory"
        exit 1
    fi


    echo " #### Files in dir1 but not in dir2:"
    
    for file in "$dir1"/*; do
        basefile=$(basename "$file")
        if [ ! -f "$dir2/$basefile" ]; then
            echo "$basefile"
        fi
    done

    echo " #### Files in dir1 but not in dir2:"
    for file in "$dir2"/*; do
        basefile=$(basename "$file")
        if [ ! -f "$dir1/$basefile" ]; then
            echo "$basefile"
        fi            
    done
    
}

