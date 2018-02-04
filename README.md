# station-blanche

* Utilisation sur Debian 9 Stretch

* Paquet requis : 

`simple-cdd xorriso`

* Construction de l'image : 

`./build.sh`

* Création d'une clé USB d'installation à partir de l'iso :
  * Pour Linux : `dd bs=4M if=station-blanche.iso of=/dev/sdX status=progress oflag=sync`
  * Pour Windows : Utiliser Rufus (https://rufus.akeo.ie/)




