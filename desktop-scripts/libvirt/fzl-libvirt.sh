#!/bin/bash

#https://docs.fedoraproject.org/en-US/quick-docs/virtualization-getting-started/
#https://developer.fedoraproject.org/tools/virtualization/installing-libvirt-and-virt-install-on-fedora-linux.html
#https://gist.github.com/RLovelett/4a2fcaff2384826358f81ad16add49e3
#https://blog.ricardof.dev/criando-maquina-virtual-libvirt/

source ../utils/fzl-echo.sh 



function fzl-libvirt-start-service(){
    sudo systemctl start libvirtd
}
export fzl-libvirt-start-service


function fzl-libvirt-status-service(){
    sudo systemctl status libvirtd
}
export fzl-libvirt-status-service


function fzl-libvirt-lsmod-kvm(){
    sudo lsmod | grep kvm
    }
export -f fzl-libvirt-lsmod-kvm


function fzl-libvirt-qcow2-img-to-default-dir(){
    qcow2Img=$1
    sudo rsync -va --progress $qcow2Img /var/lib/libvirt/images/win11.qcow2
    }
export -f fzl-libvirt-qcow2-img-to-default-dir


export fzl-qcow2-image-win11-path="/run/media/wgn/ext4/libvirt-images/win11"
function fzl-virt-install-qcow2-preexistent-image(){
    virt-install --name <VM_Name> --ram <RAM_in_MB> --vcpus <Number_of_CPUs> --disk path=/path/to/your/windows.qcow2,format=qcow2 --import --os-variant <os_variant>
}


function fzl-virsh-net-list() {
    # List all defined networks
    sudo virsh net-list --all
}
export -f fzl-virsh-net-list


function fzl-virsh-net-info() {
    # Check if network name is provided
    if [ -z "$1" ]; then
        echo "Usage: fzl-virsh-net-info <network-name>"
        return 1
    fi

    # Get network information
    sudo virsh net-info "$1"
}
export -f fzl-virsh-net-info


function fzl-qcow2-img-convert-to-vmdk(){
    vmdkImgPath=$1
    qcowImgPath=$2
    qemu-img convert -f vmdk -O qcow2 $vmdkImgPath $qcowImgPath
}



