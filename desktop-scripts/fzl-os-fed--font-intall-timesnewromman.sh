#!/bin/bash

#https://fonts.google.com
#https://www.fontsquirrel.com
#https://fonts.adobe.com

sudo dnf install dnf-plugins-core
sudo dnf config-manager --enable rpmfusion-free rpmfusion-nonfree

#install the font package
sudo dnf install lpf-mscore-fonts

#download ttf file of the font from https://www.myfonts.com/ using curl
curl -o timesnewroman.ttf https://www.myfonts.com/fonts/mti/times-new-roman/times-new-roman/times-new-roman.ttf

#install the font
sudo lpf -i timesnewroman.ttf

sudo cp timesnewroman.ttf /usr/share/fonts/
sudo fc-cache -fv
