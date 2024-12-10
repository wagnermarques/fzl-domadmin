#!/bin/bash

function fzl-convert-txt-2-pdf(){
# Check if input file is provided
if [ -z "$1" ]; then
  echo "Usage: $0 inputfile.txt"
  exit 1
fi

# Get the input and output file names
input_file="$1"
output_file="${input_file%.txt}.pdf"

# Convert txt to pdf using pandoc
pandoc "$input_file" -o "$output_file"

# Check if the conversion was successful
if [ $? -eq 0 ]; then
  echo "Conversion successful! Output file: $output_file"
else
  echo "Conversion failed."
fi
}

export -f fzl-convert-txt-2-pdf