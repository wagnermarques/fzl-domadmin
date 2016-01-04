#!/bin/bash

#in a domain, maybe you have some linuxbox workstations
#this script is a template configuration for theese workstations
#just run in in a startup



#R and RStudio feature
#TODO to setup a linuxbox-startup.properties for global properties
#TODO to test if R is already installed
#TODO create a install-r.properties to setup params installation
#feature: R and Rstudio

#parameters...
#donwloadFromThisUrl=
#source install-r.sh




#install RStudio (TODO...)
#params
#installationDir

#source install-r-studio.sh




#INSTALL ESS
essInstallationDir=~/essInstallationDir
mkdir -p $essInstallationDir
cd $essInstallationDir
#wget http://ess.r-project.org/downloads/ess/ess-15.09-2.tgz
tar xf ess-15.09-2.tgz
cd ess-15.09-2.tgz


