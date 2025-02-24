#!/bin/bash
#https://serverfault.com/questions/154650/find-printers-with-nmap

#nmap -p 515,631,9100 -oG - 192.168.0.0/24 | gawk '/open/{print $2}' | xargs --delimiter='\n' nmap -sU -p 161 -oG - | gawk '/open/{print $2}' | xargs --replace=$ipaddress snmpget -v 1 -O v -c public $ipaddress system.sysDescr.0 | sed 's/STRING:\s//'

nmap -p 515,631,9100  192.168.0.0/24

#-oG grep able results

