#!/bin/bash

outputFileName=$1

function info(){
    echo "[showing sound devices]: cat /proc/asound/cards"
    cat /proc/asound/cards
    echo .
    echo "[showing sound devices]: arecord -l"
    arecord -l
    echo .
}

#TODO provide  list of cards to user enter with
function record_audio(){
    echo "[Recording..."
    ffmpeg -f alsa -i hw:1 $outputFileName
}


#info
record_audio $outputFileName

