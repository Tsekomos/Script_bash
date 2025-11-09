#!/bin/bash
USER_LOG="users_log.txt"
touch $USER_LOG
log() {
    echo "[$(date +'%F %T')] $1" | tee -a "$USER_LOG"
}

add_user() {
    local username="$1"
    if id "$username" &>/dev/null; then
        log "L'utilisateur '$username' existe déjà."
    else
        local password
        password=$(openssl rand -base64 12)
        useradd "$username"
        echo "$username:$password" | chpasswd
        log "Utilisateur '$username' ajouté avec mot de passe : $password"
    fi
}

del_user() {
    local username="$1"
    if id "$username" &>/dev/null; then
        userdel -r "$username"
        log "Utilisateur '$username' supprimé."
    else
        log "L'utilisateur '$username' n'existe pas."
    fi
}

list_users() {
    log "Liste des utilisateurs :"
    cat /etc/passwd
}


ARGS_PARSING=$(getopt -o a:d:l --long add:,del:,list -n "$0" -- "$@")
if [ $? -ne 0 ]; then
    log "Erreur de parsing des arguments."
    exit 1
fi

eval set -- "$ARGS_PARSING"


while true; do
    case "$1" in
        -a|--add)
            add_user "$2"
            shift 2
            ;;
        -d|--del)
            del_user "$2"
            shift 2
            ;;
        -l|--list)
            list_users
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            log "Cette option n'est pas valide : $1"
            exit 1
            ;;
    esac
done
