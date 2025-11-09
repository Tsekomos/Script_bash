#!/bin/bash
while true; do
	echo "MENU PRINCIPAL : "
	echo "1) Mettre à jour le système"
	echo "2) Sauvegarder les fichiers archivé"
	echo "3) Lancer le diagnoctic réseau"
	echo "4) Lancer le programme complet"
	echo "5) Quitter"

	read -p "Choisissez une option : " CHOIX

case "$CHOIX" in 
	1)source update_system.sh ;;
	2)source backup_logs.sh ;;
	3)source network_diag.sh ;;
	4)source update_system.sh && source backup_logs.sh && source network_diag.sh ;;
	5)echo "Au revoir !"; break ;;
esac
done
