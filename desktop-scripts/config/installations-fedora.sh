#!/bin/bash

export BROWSER=firefox


sudo dnf install xdg-desktop-portal xdg-desktop-portal-lxqt

#npm
mkdir -p ~/DATA-DIRS/npm-global
npm config set prefix '~/DATA-DIRS/npm-global'
echo 'export PATH=~/DATA-DIRS/npm-global/bin:$PATH' >> ~/.bashrc # or ~/.zshrc
npm install -g @google/gemini-cli@latest



# KVM
# shared folder for KVM VMs
HOST_KVM_SHARED_FOLDER=$HOME/mnt/kvm_share
sudo mkdir -p $HOST_KVM_SHARED_FOLDER
sudo chown -R qemu:qemu $HOST_KVM_SHARED_FOLDER
sudo chmod -R 775 $HOST_KVM_SHARED_FOLDER



sudo dnf install @development-tools
sudo dnf install gcc-c++


