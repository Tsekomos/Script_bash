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

if ! command -v apt &> /dev/null; then
  log_error "Erreur : apt n'est pas disponible sur ce système."
  exit 1
fi

log "Début de la mise à jour du système..."

log "Exécution : $UPDATE_CMD"
$UPDATE_CMD >> "$LOG_FILE" 2>> "$ERROR_FILE"

log "Exécution : $UPGRADE_CMD"
$UPGRADE_CMD >> "$LOG_FILE" 2>> "$ERROR_FILE"

log "Exécution : $AUTOREMOVE_CMD"
$AUTOREMOVE_CMD >> "$LOG_FILE" 2>> "$ERROR_FILE"

NB_UPGRADED=$(grep "upgraded," "$LOG_FILE" | tail -1 | awk '{print $1}')
NB_NEW=$(grep "newly installed," "$LOG_FILE" | tail -1 | awk '{print $3}')
NB_AUTOREMOVED=$(grep "to remove and" "$LOG_FILE" | tail -1 | awk '{print $5}')

log "Résumé des actions :"
log "  Paquets mis à jour  : $NB_UPGRADED"
log "  Paquets installés    : $NB_NEW"
log "  Paquets supprimés    : $NB_AUTOREMOVED"

if [ -s "$ERROR_FILE" ]; then
  log "Des erreurs ont été détectées. Voir $ERROR_FILE"
else
  log "Mise à jour terminée sans erreur."
fi

exit 0
