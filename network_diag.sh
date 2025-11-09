#!/bin/bash
PING=$(ping -c 4 8.8.8.8)
SCAN=$(nmap 8.8.8.8)
INT_IP=$(ip a)
echo -e "vérification de la connectivité Internet : \n$PING "
 echo -e "\n"
echo -e "Scan des ports ouvert : \n$SCAN " 
 echo -e "\n "
echo -e "Interface réseau : \n$INT_IP"


