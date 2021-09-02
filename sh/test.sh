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
echo 'Ingrese el nombre del usuario: '
read SUDO_USER

version='6.0'
max_version='6.1'

integer_version='6'
venv='tryton'${integer_version}
nameuser=${SUDO_USER}
HOME_USER=/home/${SUDO_USER}
file_bashrc=$HOME_USER'/.bashrc'

PYT_CMD=$HOME_USER/.virtualenvs/${venv}/bin/python3

# apt get update

# Install PIP packages
PIP_CMD=$HOME_USER/.virtualenvs/${venv}/bin/pip3

source_="\nalias workon='source ~/.virtualenvs/$venv/bin/activate'"
export_="\nexport WORKON_HOME=$HOME_USER/.virtualenvs"

# Install apt-get packages
message "[INFO] Installing main apt-get packages..." ${BLUE}

appackages="
	build-essential
    python3
    python3-virtualenv
	python3-pip
    python3-venv
    virtualenv
"

for i in ${appackages}
    do
        sudo apt -y install $i
    done
message "[INFO] Done." ${YELLOW}


# Create Virtualenv
message "[INFO] Creating virtualenv... $venv " ${BLUE}

echo $source_ >> $file_bashrc
echo $export_ >> $file_bashrc

virtualenv -p $(which python3) $HOME_USER/.virtualenvs/${venv}

message "[INFO] Done." ${YELLOW}

