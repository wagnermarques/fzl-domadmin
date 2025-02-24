#!/usr/bin/env python

import datetime
import subprocess
import os
import time

def take_screenshots(directory):
    while True:
        # Get the current timestamp
        timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
        # Take a screenshot and save it to the specified directory with the timestamp as the filename
        subprocess.call(["import", "-window", "root", directory+"/screenshot_{}.png".format(timestamp)])
        time.sleep(1)

directory = input("Enter the directory where you want to save the screenshots: ")

# Create the directory if it doesn't exist
if not os.path.exists(directory):
    os.makedirs(directory)

take_screenshots(directory)
