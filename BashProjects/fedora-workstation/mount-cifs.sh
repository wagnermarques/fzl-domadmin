#!/bin/bash

BASEDIR=$(dirname "$0")

source $BASEDIR/credentials.sh

arrSharedFolders=(
    "//192.168.0.40/DOCS_NSI"
    "//192.168.0.40/DOCS_GPI"
    "//192.168.0.80/Relatar_Erros"
);



mountSharedFolder(){

    #creating phisical local folder to mount sharedfolder
    sharedFolderReversed=$(rev <<< $1);
    IFS='/' #  (/) is set as delimiter
    
    read -ra ADDR <<< "$sharedFolderReversed" # origemRevertida is read into an array as tokens separated by IFS
    ip=$(rev <<< ${ADDR[0]})
    folder=$(rev <<< ${ADDR[1]})

    mkdir -p /home/$USER/mnt/$folder$ip
    IFS=' ' # reset to default value after usage

    #mouning shared folder in phisical folders created
    echo "mount -t cifs $1 /home/$domUser/mnt/$folder$ip -o username=$domUser,dom=$dom,file_mode=0777,dir_mode=0777,vers=2.0;"
    mount -t cifs $1 /home/$domUser/mnt/$folder$ip -o username=$domUser,dom=$dom,file_mode=0777,dir_mode=0777,vers=2.0;
}



for sharedFolderName in ${arrSharedFolders[@]};
do
    mountSharedFolder $sharedFolderName
done
