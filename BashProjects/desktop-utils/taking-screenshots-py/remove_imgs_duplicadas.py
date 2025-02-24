#!/usr/bin/env python

import os
import cv2

def compare_images(file1, file2):
    # Read the images
    img1 = cv2.imread(file1)
    img2 = cv2.imread(file2)

    # Check if the images are the same
    return cv2.norm(img1, img2, cv2.NORM_L2) < 1e-10

def remove_duplicates(directory):
    # Get all the files in the directory
    files = os.listdir(directory)

    # Create a list to store duplicates
    duplicates = []

    # Compare all the files
    for i in range(len(files)):
        for j in range(i+1, len(files)):
            file1 = os.path.join(directory, files[i])
            file2 = os.path.join(directory, files[j])

            # If the files are the same, add them to the duplicates list
            if compare_images(file1, file2):
                duplicates.append(file2)

    # Remove the duplicates from the directory
    for file in duplicates:
        os.remove(file)

# Ask for the directory where the images are located
directory = input("Enter the directory where the images are located: ")

# Remove the duplicates
remove_duplicates(directory)
