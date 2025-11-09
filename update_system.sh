#!/bin/bash

UPDATE_CMD="apt update"
UPGRADE_CMD="apt upgrade -y"
AUTOREMOVE_CMD="apt autoremove -y"

LOG_FILE="update_log.txt"
ERROR_FILE="update_error.log"

> "$LOG_FILE"
> "$ERROR_FILE"

log() {
  echo "[$(date '+%F %T')] $1" >> "$LOG_FILE"
}

log_error() {
  echo "[$(date '+%F %T')] $1" >> "$ERROR_FILE"
}

log "Début de la mise à jour du système..."

log "Exécution : $UPDATE_CMD"
$UPDATE_CMD >> "$LOG_FILE" 2> >(while IFS= read -r line; do [[ -n "$line" ]] && log_error "$line"; done)

log "Exécution : $UPGRADE_CMD"
$UPGRADE_CMD >> "$LOG_FILE" 2> >(while IFS= read -r line; do log_error "$line"; done)

log "Exécution : $AUTOREMOVE_CMD"
$AUTOREMOVE_CMD >> "$LOG_FILE" 2> >(while IFS= read -r line; do log_error "$line"; done)

NB_UPGRADED=$(grep "upgraded," "$LOG_FILE" | tail -1 | awk '{print $1}')
NB_NEW=$(grep "newly installed," "$LOG_FILE" | tail -1 | awk '{print $3}')
NB_AUTOREMOVED=$(grep "to remove and" "$LOG_FILE" | tail -1 | awk '{print $5}')

NB_UPGRADED=${NB_UPGRADED:-0}
NB_NEW=${NB_NEW:-0}
NB_AUTOREMOVED=${NB_AUTOREMOVED:-0}


echo -e "\nRésumé des actions :"
echo " Paquets mis à jour  : $NB_UPGRADED"
echo " Paquets installés    : $NB_NEW"
echo " Paquets supprimés    : $NB_AUTOREMOVED"

if [ -s "$ERROR_FILE" ]; then
  log "Voir $ERROR_FILE pour les détails sur les erreurs, s'il en a."
else
  log "Mise à jour terminée sans erreur."
fi

