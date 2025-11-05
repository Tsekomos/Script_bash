#!/bin/bash
DATE=$(date +%Y%m%d)
BACKUP_DIR="/backup/logs"
ARCHIVE_NAME="logs_$DATE.tar"
ARCHIVE_PATH="$BACKUP_DIR/$ARCHIVE_NAME"
COMPRESSED_ARCHIVE="$ARCHIVE_PATH.gz"
LOG_DIR="/var/log"

echo "Espace disque disponible :"
df -h /

mkdir -p "$BACKUP_DIR"

LOG_FILES=()
echo "Fichiers à sauvegarder :"
for file in "$LOG_DIR"/*; do
    if [ -f "$file" ]; then
        LOG_FILES+=("$file")
        echo " - $(basename "$file")"
    fi
done

tar -cvf "$ARCHIVE_PATH" "${LOG_FILES[@]}"

gzip "$ARCHIVE_PATH"

find "$BACKUP_DIR" -type f -name "logs_*.tar.gz" -mtime +7 -exec rm {} \

echo "Rapport de sauvegarde :"
ARCHIVE_SIZE=$(du -h "$COMPRESSED_ARCHIVE" | cut -f1)
ORIGINAL_SIZE=$(du -c "${LOG_FILES[@]}" | grep total | awk '{print $1}')
COMPRESSED_SIZE=$(du "$COMPRESSED_ARCHIVE" | awk '{print $1}')
COMPRESSION_RATE=$(echo "scale=2; 100 - ($COMPRESSED_SIZE * 100 / $ORIGINAL_SIZE)" | bc)

echo " - Archive : $(basename "$COMPRESSED_ARCHIVE")"
echo " - Taille : $ARCHIVE_SIZE"
echo " - Taux de compression : $COMPRESSION_RATE%"
echo " - Fichiers sauvegardés : ${#LOG_FILES[@]}"

exit 0

