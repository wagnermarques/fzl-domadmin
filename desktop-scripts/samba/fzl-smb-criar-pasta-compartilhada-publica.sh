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

function fzl-samba-listar-pastas-compartilhadas(){
echo "=== Listando pastas compartilhadas do Samba local ==="
echo

# Verifica se o Samba está instalado
if ! command -v smbclient &> /dev/null; then
    echo "Erro: smbclient não está instalado. Instale com:"
    echo "sudo dnf install samba-client"
    return 1
fi

# Verifica se os serviços estão rodando
if ! systemctl is-active --quiet smb; then
    echo "Aviso: Serviço SMB não está ativo"
    echo "Para iniciar: sudo systemctl start smb"
    echo
fi

if ! systemctl is-active --quiet nmb; then
    echo "Aviso: Serviço NMB não está ativo"
    echo "Para iniciar: sudo systemctl start nmb"
    echo
fi

# Lista compartilhamentos usando testparm
echo "--- Configurações do smb.conf ---"
if command -v testparm &> /dev/null; then
    sudo testparm -s 2>/dev/null | grep -A 10 '^\[.*\]' | grep -v '^\[global\]' -A 10
else
    echo "testparm não disponível, lendo smb.conf diretamente:"
    grep -A 10 '^\[.*\]' /etc/samba/smb.conf 2>/dev/null | grep -v '^\[global\]' -A 10
fi

echo
echo "--- Compartilhamentos via smbclient ---"
smbclient -L localhost -N 2>/dev/null || smbclient -L localhost -U guest%""

echo
echo "--- Status dos serviços ---"
echo "SMB: $(systemctl is-active smb)"
echo "NMB: $(systemctl is-active nmb)"
}

function fzl-smbclient-listar-pastas-compartilhadas-remotas(){
local HOST="$1"
local USERNAME="$2"

if [ $# -eq 0 ]; then
    echo "Uso: fzl-smbclient-listar-pastas-compartilhadas-remotas <HOST> [USERNAME]"
    echo
    echo "Exemplos:"
    echo "  fzl-smbclient-listar-pastas-compartilhadas-remotas 192.168.1.100"
    echo "  fzl-smbclient-listar-pastas-compartilhadas-remotas servidor.local usuario"
    echo "  fzl-smbclient-listar-pastas-compartilhadas-remotas //192.168.1.100"
    return 1
fi

# Verifica se o smbclient está instalado
if ! command -v smbclient &> /dev/null; then
    echo "Erro: smbclient não está instalado. Instale com:"
    echo "sudo dnf install samba-client"
    return 1
fi

# Remove barras duplas se existirem no início do HOST
HOST=$(echo "$HOST" | sed 's|^//||')

echo "=== Listando compartilhamentos remotos em $HOST ==="
echo

if [ -n "$USERNAME" ]; then
    echo "Conectando como usuário: $USERNAME"
    echo "Digite a senha quando solicitado:"
    smbclient -L "//$HOST" -U "$USERNAME"
else
    echo "Tentando conexão anônima/guest..."
    # Tenta primeiro como guest
    smbclient -L "//$HOST" -N 2>/dev/null || {
        echo "Conexão guest falhou, tentando com usuário guest vazio:"
        smbclient -L "//$HOST" -U guest%""
    }
fi

# Informações adicionais
echo
echo "--- Informações de conectividade ---"
if ping -c 1 "$HOST" &>/dev/null; then
    echo "✓ Host $HOST está acessível via ping"
else
    echo "✗ Host $HOST não responde ao ping"
fi

# Verifica portas SMB
if command -v nmap &> /dev/null; then
    echo "Verificando portas SMB:"
    nmap -p 139,445 "$HOST" 2>/dev/null | grep -E "(139|445)"
elif command -v nc &> /dev/null; then
    echo "Verificando portas SMB com netcat:"
    timeout 3 nc -z "$HOST" 139 && echo "Porta 139/tcp (NetBIOS) está aberta"
    timeout 3 nc -z "$HOST" 445 && echo "Porta 445/tcp (SMB) está aberta"
fi
}

# Exporta as funções para uso em outros shells
export -f fzl-samba-criar-pasta-compartilhada-publica
export -f fzl-samba-listar-pastas-compartilhadas
export -f fzl-smbclient-listar-pastas-compartilhadas-remotas

# Mensagem informativa
echo "Funções Samba carregadas:"
echo "  - fzl-samba-criar-pasta-compartilhada-publica [caminho]"
echo "  - fzl-samba-listar-pastas-compartilhadas"
echo "  - fzl-smbclient-listar-pastas-compartilhadas-remotas <host> [usuario]"
