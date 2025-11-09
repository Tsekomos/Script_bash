# MANUEL D'UTILISATION – Projet Automatisation de script Bash

## Présentation

Ce projet regroupe plusieurs scripts Bash destinés à automatiser des tâches courantes sur une machine Linux, notamment :

- La mise à jour du système
- La sauvegarde des fichiers de logs
- Le diagnostic réseau

---

## Fichiers nécessaires

- `update_system.sh`  
- `backup_logs.sh`  
- `network_diag.sh`  
- `admin_auto.sh`  
- `config.cfg`  

---

## Utilité de chaque script

### `update_system.sh`

- Met à jour le système avec les commandes `apt update`, `apt upgrade -y`, et `apt autoremove -y`
- Stocke les journaux d'exécution dans :
  - `update_log.txt` pour les actions réussies
  - `update_error.log` pour les erreurs
- Affiche un résumé des paquets mis à jour, installés et supprimés

### `backup_logs.sh`

- Archive et compresse les fichiers de logs définis dans `config.cfg`
- Supprime les anciennes archives de plus de 7 jours
- Affiche un rapport de sauvegarde :
  - Taille de l’archive
  - Taux de compression
  - Nombre de fichiers sauvegardés

### `network_diag.sh`

- Vérifie la connectivité Internet avec `ping`
- Scanne les ports ouverts avec `nmap`
- Affiche les interfaces réseau avec `ip a`

### `admin_auto.sh`

- Menu interactif permettant de lancer :
  - La mise à jour du système
  - La sauvegarde des logs
  - Le diagnostic réseau
  - Tous les modules à la fois
- Utilise `source` pour exécuter les scripts dans le même shell


### `config.cfg`

- Fichier de configuration contenant les chemins et noms d’archives utilisés par `backup_logs.sh`

---

## Installation et exécution

1. Cloner le projet Script_bash
2. Rendre éxécutable les scripts avec la commande `chmod +x nom_du_script.sh`
3. Installer les packages nécessaires pour le bon fonctionnement des scripts (nmap)
4. Vérifier le fichier de configuration voir si les chemins des fichiers sont correctes(uniquement pour le script update_logs.sh)

## Autres
users_manager.sh : Permet d'ajouter des utilisateurs à l'aide de la commande ou de les supprimer grâce à la fonction `getopts` et chaque utilisateur créé obtiens un mot de passe généré aléatoirement.
