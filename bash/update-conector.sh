#!/bin/sh
# Install Presik modules
echo "[INFO] Update module conector... "

db="
cdst
frigoecol
genuinos
lopez
pilaricarnes
tecniguadaña
"

for i in ${db}
    do
        trytond-admin -v -c trytond.conf -d $i -u conector
    done
echo "[INFO] Update completed. "
