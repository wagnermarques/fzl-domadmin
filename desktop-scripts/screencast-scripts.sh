echo " ### screencast-scripts.sh"

#install screenkey
function fzl-screenkey-install-dnf(
    sudo dnf install python3-pip gobject-introspection gtk3 python3-devel
    sudo dnf install screenkey
)
export -f fzl-screenkey-install-dnf


#starts screenkey
function fzl-screenkey-start(){
    echo "runs fzl-screenkey-install-dnf to install if needed..."
    screenkey
}
export -f fzl-screenkey-start


#start screencast with ffmpeg
function fzl-screencast-start-ffmpeg(){
    SCREEN_WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 1)
    SCREEN_HEIGHT=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 2)
    output_file="$1"
    ffmpeg -video_size ${SCREEN_WIDTH}x${SCREEN_HEIGHT} -framerate 25 -f x11grab -i :0.0 $output_file
}
export -f fzl-screencast-start-ffmpeg

function fzl-ansible-config--setup-ansible.cfg(){
    export ANSIBLE_CONFIG=$PROGSATIVOS_DIR/setup-progsativos-scripts/ansible.cfg    
}
export -f fzl-ansible-config--setup-ansible.cfg


