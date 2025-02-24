#!/bin/bash

# array of packages to be installed on 
pkgs_to_install=(    
    "vim"
    "git"
    "curl"
    "wget" 
    "tree"
    "nmap"
    "net-tools"
    "dnsutils"
    "traceroute"
    "tcpdump"
    "openssh-server"
    "openssh-client"
    "openvpn"
    )

# install packages
for pkg in ${pkgs_to_install[@]}; do
    sudo apt-get install -y $pkg
done
