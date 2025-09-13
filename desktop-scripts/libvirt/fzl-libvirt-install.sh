#!/bin/bash

#install libvirt on ferdora
#dnf group info virtualization
#sudo dnf install @virtualization

firewall-cmd --zone=trusted --change-interface=br0 --permanent
firewall-cmd --add-port=5900/tcp --permanent
firewall-cmd --reload
firewall-cmd --zone=FedoraServer --list-ports

usermod --append --groups libvirt `whoami`
