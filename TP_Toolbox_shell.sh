#! /bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Impossible de manager des utilisateurs sans root, relancer avec sudo!"
  exit
fi

while true
do
    echo "    -------------------------
    Menu de gestion des utilisateurs
    1. Créer un utilisateur
    2. Supprimer un utilisateur
    3. Quittez
    -------------------------
    Choissisez une option :"
    read choix
    if [ "$choix" = "1" ]
    then
        echo "Entrez un nom d'utilisateur : "
        read username
        if [ "$(cat /etc/passwd | grep $username)" != "" ]
        then
            echo "Cet utilisateur existe déjà!"
        else
            useradd -m $username
            passwd $username
            echo "Utilisateur créé"
        fi
    fi
    if [ "$choix" = "2" ]
    then
        echo "Entrez un nom d'utilisateur à supprimer : "
        read username
        if [ "$(cat /etc/passwd | grep $username)" = "" ]
        then
            echo "Cet utilisateur n'existe pas!"
        else
            userdel -r $username
            echo "Utilisateur supprimé"
        fi
    fi
    if [ "$choix" = "3" ]
    then
        echo "Au revoir!"
        break
    fi
done
