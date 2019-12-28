#!/bin/bash

#https://linuxconfig.org/example-of-simple-bash-script-client

ftp_site="ftp.datasus.gov.br"
username="anonymous"
passwd="ipgg-wfmarques@saude.sp.gov.br"

path="cnes"

ftp <<ADDTEXT
    open $ftp_site
    user $username $passwd
    ls
ADDTEXT

#ftp -in << HereDocumentDelimiter


#HereDocumentDelimiter

#echo$1 uploaded to $path ! 

# Break, otherwise endless loop

