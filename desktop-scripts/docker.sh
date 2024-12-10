#docker util functions
#_containers_not_to_prune=("6d3adc68ff04" "41ec0a8af78e")
_containers_not_to_prune=()
_volume_not_to_prune=()
_images_not_to_prune=()

function _fzl-docker-prune-all-containers(){
    echo " ### _fzl-docker-prune-containers(){..."
    for c in $(docker ps -a | awk '{print $1}'); do
        prune=true
        for item in "${_containers_not_to_prune[@]}"; do
            if [ "$c" == "$item" ]; then
                echo "container $c not to prune"
                prune=false
                break
            fi
        done

        if [ "$prune" = false ]; then
            continue
        fi
        docker stop $c
        docker rm $c
    done    
}

function _fzl-docker-prune-all-images(){
    echo " ### function _fzl-docker-prune-images(){...";
    for i in $(docker images | awk '{print $3}'); do
        echo "pruning image $i"
        docker rmi -f $i
    done
}

function _fzl-docker-prune-all-volumes(){
    echo " ### function _fzl-docker-prune-volumes(){...";
    for v in $(docker volume ls | awk '{print $2}'); do
        for item in "${_volume_not_to_prune[@]}"; do
            if [ "$v" == "$item" ]; then
                echo "volume $v not to prune"
                continue
            fi
        done
        echo "pruning volume $v"
        docker volume rm $v
    done
}

function fzl-docker-prune-all-containers(){
    for c in $(docker ps -a | awk '{print $1}'); do docker rm $c; done
}
export -f fzl-docker-prune-all-containers


function fzl-docker-prune-all-images-(){
    for i in $(docker images | awk '{print $3}'); do docker rmi $i; done
}
export -f fzl-docker-prune-all-images


function fzl-docker-prune-all-volumes(){
    for v in $(docker volume ls -q); do docker volume rm $v; done
}
export -f fzl-docker-prune-all-volumes


function fzl-docker-prune-all-networks(){
    for n in $(docker network ls -q); do docker network rm $n; done
}
export -f fzl-docker-prune-all-networks




###
function fzl-docker-prune-all(){
    if [ $1 == "stops_running_containers" ]; then
        for c in $(docker ps -q); do docker stop $c; done
    fi
    fzl-docker-prune-all-containers
    fzl-docker-prune-all-images
    fzl-docker-prune-all-volumes
    fzl-docker-prune-all-networks
}
export -f fzl-docker-prune-all


function fzl-docker-prune-all(){
    _fzl-docker-prune-all-containers    
    _fzl-docker-prune-all-images
    _fzl-docker-prune-all-volumes
}
export -f fzl-docker-prune-all


function fzl-docker-change-root-dir(){
    NEW_PARTITION="$1"
    ORIGINAL_DIR="/var/lib/docker"

    #check if the function was called with sudo 
    if [ "$EUID" -ne 0 ]; then
        echo "Please run this script as root"
        return 1
    fi

    if [ -z "$NEW_PARTITION" ]; then
        echo "Usage: fzl-docker-change-root-dir <new-partition>"
        return 2
    fi

    echo "Stopping Docker service..."
    systemctl stop docker

    echo "Mounting the new partition to $ORIGINAL_DIR..."
    mount "$NEW_PARTITION" "$ORIGINAL_DIR"

    #echo "Updating /etc/fstab to mount the partition on boot..."
    #UUID=$(blkid -s UUID -o value "$NEW_PARTITION")
    #echo "UUID=$UUID $ORIGINAL_DIR ext4 defaults 0 2" >> /etc/fstab

    echo "Starting Docker service..."
    systemctl start docker

    echo "Docker root directory is now on the partition $NEW_PARTITION"
}
export -f fzl-docker-change-root-dir
