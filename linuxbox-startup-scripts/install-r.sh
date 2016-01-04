#!/bin/bash
#adapted from...
#http://cbio.ensmp.fr/~thocking/primer.html
set -o errexit

mkdir -p ~/R
cd ~/R

#if [ -f R-devel.tar.gz ];then 
#    rm R-devel.tar.gz
#fi
#wget https://stat.ethz.ch/R/daily/R-devel_2015-12-22.tar.gz
#if [ -d R-devel_2015-12-22.tar.gz ];then
#    rm -r R-devel_2015-12-22.tar.gz
#fi
tar xf R-devel_2015-12-22.tar.gz
cd R-devel
./configure --prefix=$HOME --with-cairo
make
make install
