# station-blanche

## Construction de l'image

* Construction sur Debian 9 Stretch

* Paquet requis : 

`simple-cdd xorriso`

* Lancement de la construction : 

`./build.sh`

* Résultat : 

`station-blanche.iso`


## Création d'une clé USB d'installation à partir de l'iso :

* Sous Linux (/dev/sdb est le périphérique correspondant à la clé USB) : 

`dd bs=4M if=station-blanche.iso of=/dev/sdX status=progress oflag=sync`

* Pour Windows : Utiliser Rufus (https://rufus.akeo.ie/)

## Utilisation de la station blanche

* Au boot sur la clé USB d'installation, cele ci sera entièrement automatique jusqu'à l'exctinction de la machine. L'installation doit se faire sur une machine connectée à Internet.

* Station blanche sous Debian 9 Stretch
    * utilitaire `antivirscan` réalisant le scan d'une clé usb connecté à la machine
    * utilisation de l'antivirus Clamav, mise à jour des définitions de virus toutes les heures

* Deux comptes : 
    * root / Bl@nch3
    * analyse / analyse
    
* Logs des analyses : /var/log/antivirscan
* Fichiers en quarantaine : /var/lib/antivirscan/quarantine

![Virus](https://raw.githubusercontent.com/jpwilsch/station-blanche/master/doc/virus.png "Virus")
  
![OK](https://raw.githubusercontent.com/jpwilsch/station-blanche/master/doc/ok.png "OK")

  
*Inspiré du travail de Laurent Grison*
  


