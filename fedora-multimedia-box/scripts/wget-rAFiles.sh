#/bin/bash
fileExtension=$1
url=$2
wget -r -A.$fileExtension  $url
