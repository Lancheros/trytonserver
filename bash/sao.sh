#!/bin/sh

#---------------------------------------------------------
#    Script Install Tryton Server
# --------------------------------------------------------

# Autor: Cristhian Lancheros, 14/07/2021

sudo apt install -y nodejs

sudo apt install npm

npm install --production --legacy-peer-deps

npm install

sudo npm install -g grunt-cli

grunt dev