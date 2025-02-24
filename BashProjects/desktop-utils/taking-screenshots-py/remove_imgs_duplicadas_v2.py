#!/usr/bin/env python

import os
import cv2

def compare_images(img1, img2):
    # read images
    image1 = cv2.imread(img1)
    image2 = cv2.imread(img2)
    
    # compare images
    diff = cv2.absdiff(image1, image2)
    return not cv2.countNonZero(diff)

folder_path = input("Enter the path of the folder containing images: ")

# get list of all image files in the directory
files = [f for f in os.listdir(folder_path) if f.endswith(".jpg") or f.endswith(".png")]

# iterate through the list of files
for i, file1 in enumerate(files):
    for file2 in files[i+1:]:
        if compare_images(os.path.join(folder_path, file1), os.path.join(folder_path, file2)):
            os.remove(os.path.join(folder_path, file2))

print("Duplicate images removed.")
