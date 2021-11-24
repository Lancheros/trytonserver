#!/bin/sh

#---------------------------------------------------------
#    Script Install Tryton Server
# --------------------------------------------------------

# Autor: Cristhian Lancheros, 14/07/2021
# Nota: ejecute este script con un usuario (no root), así que no use sudo para ejecutarlo
# Main functions/variables declaration

# Colors constants
NONE="$(tput sgr0)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"

message () {
    # $1 : Message
    # $2 : Color
    # return : Message colorized
    local NOW="[$(date +%H:%M:%S)] "

    echo "${2}${NOW}${1}${NONE}"
}

echo '----------------------------------Inicio----------------------------------'


# Initializing server
sudo cp strytond.service /etc/systemd/system/strytond.service
sudo chmod 755 /etc/systemd/system/strytond.service

sudo cp strytond_service /usr/local/bin/strytond_service
sudo chmod 755 /usr/local/bin/strytond_service

sudo systemctl enable strytond.service
message "[INFO] Done." ${YELLOW}

message "[INFO] Starting trytond server... " ${BLUE}
sudo systemctl start strytond.service
message "[INFO] Ok." ${YELLOW}

sudo systemctl status strytond.service


message "[INFO] Done." ${YELLOW}
