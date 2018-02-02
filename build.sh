#!/bin/bash

echo "## Construction du paquet antivirscan"
cd deb
rm antivirscan.deb 2> /dev/null
dpkg-deb --build antivirscan

echo "## Construction de l'image station-blanche"
cd ../iso
rm -rf tmp 2> /dev/null
build-simple-cdd --conf station-blanche.conf

cd ..
mv iso/images/debian*.iso station-blanche.iso
