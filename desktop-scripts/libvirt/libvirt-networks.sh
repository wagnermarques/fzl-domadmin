#!/bin/bash
function fzl-libvirt-network-list-system-mode-networks(){
    sudo virsh net-list --all
}


function fzl-libvirt-network--create-system-network(){
    NETWORK_NAME="vm-network"
    # 1. Create network XML
    sudo tee /tmp/vm-network-system.xml << 'EOF'
<network>
  <name>vm-sys-network</name>
  <forward mode='nat'/>
  <bridge name='virbrsys' stp='on' delay='0'/>
  <ip address='192.168.100.1' netmask='255.255.255.0'>
    <dns>
      <forwarder addr='8.8.8.8'/>
      <forwarder addr='8.8.4.4'/>
    </dns>
    <dhcp>
      <range start='192.168.100.2' end='192.168.100.254'/>
    </dhcp>
  </ip>
</network>
EOF

    sudo virsh net-define /tmp/vm-network-system.xml
}

