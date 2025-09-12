#!/bin/bash

function fzl-samba-criar-pasta-compartilhada-publica(){
# Define a pasta compartilhada e o nome do compartilhamento
SHARED_FOLDER_PATH="/srv/pasta_compartilhada"
SHARE_NAME="pasta_compartilhada"

# Se um argumento for fornecido, use-o como caminho da pasta
if [ $# -eq 1 ]; then
    SHARED_FOLDER_PATH="$1"
    SHARE_NAME=$(basename "$1")
fi

echo "Preparando a pasta compartilhada em $SHARED_FOLDER_PATH..."

# Cria a pasta e define permissões abertas para todos
sudo mkdir -p "$SHARED_FOLDER_PATH"
sudo chmod -R 777 "$SHARED_FOLDER_PATH"

# Configura o SELinux para permitir o compartilhamento Samba
sudo semanage fcontext -a -t samba_share_t "$SHARED_FOLDER_PATH(/.*)?" 2>/dev/null || \
sudo semanage fcontext -m -t samba_share_t "$SHARED_FOLDER_PATH(/.*)?"
sudo restorecon -R "$SHARED_FOLDER_PATH"

# Faz um backup do arquivo de configuração do Samba
sudo cp -f /etc/samba/smb.conf /etc/samba/smb.conf.bak

echo "Adicionando a configuração do compartilhamento ao smb.conf..."

# Adiciona a nova seção de compartilhamento ao final do arquivo
cat << EOF | sudo tee -a /etc/samba/smb.conf

[${SHARE_NAME}]
comment = Compartilhamento sem senha
path = ${SHARED_FOLDER_PATH}
browseable = yes
guest ok = yes
read only = no
writable = yes
public = yes
EOF

# Configura o firewall para permitir o tráfego do Samba
echo "Configurando o firewall..."
sudo firewall-cmd --permanent --add-service=samba
sudo firewall-cmd --reload

# Habilita os serviços do Samba para iniciar automaticamente e os reinicia para aplicar as mudanças
echo "Reiniciando os serviços do Samba..."
sudo systemctl enable smb nmb
sudo systemctl restart smb nmb

echo "Script concluído! A pasta compartilhada '${SHARE_NAME}' foi configurada com sucesso."
echo "Você pode acessá-la de uma máquina Windows usando \\\\IP_DO_SEU_FEDORA\\${SHARE_NAME}"
}

export -f fzl-samba-criar-pasta-compartilhada-publica
