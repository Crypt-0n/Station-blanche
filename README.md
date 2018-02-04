# station-blanche

* Utilisation sur Debian 9 Stretch

* Paquet requis : 

`simple-cdd xorriso`

* Construction de l'image : 

`./build.sh`

* Création d'une clé USB d'installation à partir de l'iso :
  * Pour Linux : `dd bs=4M if=station-blanche.iso of=/dev/sdX status=progress oflag=sync`
  * Pour Windows : Utiliser Rufus (https://rufus.akeo.ie/)

* Station blanche sous Debian 9 Stretch, utilisation de l'antivirus Clamav, mise à jour des définitions de virus toutes les heures
  * Deux comptes : 
    * root / Bl@nch3
    * analyse / analyse
  * Logs des analyse : /var/log/antivirscan
  * Fichiers en quarantaine : /var/lib/antivirscan/quarantine
  
* Inspiré du travail de Laurent Grison
  


