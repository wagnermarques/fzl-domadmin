#!/bin/bash

export BROWSER=firefox


sudo dnf install xdg-desktop-portal xdg-desktop-portal-lxqt

#npm
mkdir -p ~/DATA-DIRS/npm-global
npm config set prefix '~/DATA-DIRS/npm-global'
echo 'export PATH=~/DATA-DIRS/npm-global/bin:$PATH' >> ~/.bashrc # or ~/.zshrc
npm install -g @google/gemini-cli@latest




sudo dnf install @development-tools
sudo dnf install gcc-c++


