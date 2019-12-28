#!/usr/bin/env python

import sys, ftplib

ftpSite=sys.argv[1]

if len(sys.argv) == 2: #no user and pass switches
    ftpUser="anonymous"
    ftpPass="email@dom"
else:
    ftpUser=sys.argv[2]
    ftpPass=sys.argv[3]


ftp = ftplib.FTP(ftpSite)
ftp.login(ftpUser,ftpPass)

data = []

ftp.dir(data.append)

ftp.quit()

for line in data:
    print(line)
