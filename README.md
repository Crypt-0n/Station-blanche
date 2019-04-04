# Station blanche

## Construction de l'image

* Construction de l'IOS d'installation depuis une Debian 9 Stretch

* Une connexion internet est indispensable pour la construction de l'image

* Paquet requis : 

`simple-cdd xorriso`

* Lancement de la construction : 

`./build.sh`

* Résultat : 

`station-blanche.iso`


## Création d'une clé USB d'installation à partir de l'iso :

* Sous Linux (/dev/sdX est le périphérique correspondant à la clé USB) : 

`dd bs=4M if=station-blanche.iso of=/dev/sdX status=progress oflag=sync`

* Pour Windows : Utiliser Rufus (https://rufus.akeo.ie/)

## Installation

L'installation est automatique à condition que la machine soit connectée à internet via le réseau filaire.

## Utilisation de la station blanche

* Au boot sur la clé USB d'installation, celle ci sera entièrement automatique jusqu'à l'extinction de la machine. L'installation doit se faire sur une machine connectée à Internet.

* Station blanche sous Debian 9 Stretch
    * utilitaire `antivirscan` réalisant le scan d'une clé usb connecté à la machine
    * utilisation de l'antivirus Clamav, mise à jour des définitions de virus toutes les heures

* Deux comptes : 
    * root / $T@t!0nBl@nch3
    * analyse / analyse
    
* Logs des analyses : `/var/log/antivirscan`
* Fichiers en quarantaine : `/var/lib/antivirscan/quarantine`

![Virus](https://raw.githubusercontent.com/Crypt-0n/Station-blanche/master/doc/virus.png "Virus")
  
![OK](https://raw.githubusercontent.com/Crypt-0n/Station-blanche/master/doc/ok.png "OK")


*Fork de https://github.com/jpwilsch/station-blanche* 

*Inspiré du travail de Laurent Grison*
  


