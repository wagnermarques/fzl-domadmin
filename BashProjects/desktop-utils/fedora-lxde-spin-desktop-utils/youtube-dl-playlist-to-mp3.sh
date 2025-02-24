#!/bin/bash

link_da_playlist=$1
#youtube-dl -cit --yes-playlist $link_da_playlist 

youtube-dl -f mp4 -o '%(title)s.%(ext)s' --yes-playlist $link_da_playlist

#&& for i in $(ls *.mp4); do ffmpeg -i "$i" -vn -ab 256k -ar 44100 -y "${i%.*}.mp3" \
#				     && rm "$i"; done

#youtube-dl -f mp4 -cit -o 'videos/%(title)s.%(ext)s' --yes-playlist $link_da_playlist  && for i in $(ls videos/*.mp4); do ffmpeg -i "$i" -vn -ab 256k -ar 44100 -y "${i%.*}.mp3" && rm "$i"; done
