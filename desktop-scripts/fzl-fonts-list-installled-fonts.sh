#!/bin/bash

# A simple script to list installed fonts using fc-list.

echo "  How would you like to list the fonts?"
echo "  1) Show a clean list of unique font family names"
echo "  2) Show a full, detailed list of every font file"

read -p "Enter your choice (1 or 2) [1]: " choice

# Default to choice 1 if the user just presses Enter
choice=${choice:-1}

echo "" # Add a space for cleaner output

if [ "$choice" == "1" ]; then
    echo "--- Unique Font Families Installed ---"
    # The ':family' format specifier prints only the font family name.
    # 'sort -u' sorts the list and removes duplicates.
    fc-list :family | sort -u
elif [ "$choice" == "2" ]; then
    echo "--- Full List of All Installed Fonts (Path: Family: Style) ---"
    # Running fc-list without arguments gives the full path and details.
    fc-list
else
    echo "Invalid choice. Please run the script again and enter 1 or 2."
    exit 1
fi
