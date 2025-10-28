#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input.xls> <output.csv>"
    exit 1
fi

# Get the input and output file names from the arguments
input_xls="$1"
output_csv="$2"

# Check if the input file exists
if [ ! -f "$input_xls" ]; then
    echo "Error: Input file '$input_xls' not found."
    exit 1
fi

# Convert the XLS file to CSV using pandoc
pandoc -f xlsx -t csv "$input_xls" -o "$output_csv"

# Check if the conversion was successful
if [ $? -eq 0 ]; then
    echo "Conversion successful: '$input_xls' -> '$output_csv'"
else
    echo "Error: Conversion failed."
    exit 1
fi
