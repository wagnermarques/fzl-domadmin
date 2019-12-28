#!/bin/bash
vInputPath=$1
vOutputPath=$2
ffmpeg -i "$vInputPath" -filter:a "volume=0.5" "$vOutputPath"
