#!/bin/bash

while read link; do youtube-dl $link; done < youtube-links.txt &
