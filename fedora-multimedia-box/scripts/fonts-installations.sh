#!/bin/bash
cd ../fonts-downloads

#for lnk in $(cat ./fonts-links-para-downloads.txt);do wget $lnk ;done

#find ./ -type f -name "*.zip" -print0 | xargs -0 -I zipfilename unzip zipfilename

#mkdir -p /usr/share/fonts/freefonts

#find ./ -type f -name "*.ttf" -print0 | xargs -0 -I ttffile mv ttffile /usr/share/fonts/freefonts

fc-cache -v

echo limpeza...
#limpar downloads en extracted files
