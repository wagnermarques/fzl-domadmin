#/bin/bash
fileExtensions=$1
url=$2

wget --recursive --no-parent --no-clobber --show-progress --accept $fileExtensions  $url

#wget -r --no-parent --accept mp3,MP3 -nd --span-hosts $url
