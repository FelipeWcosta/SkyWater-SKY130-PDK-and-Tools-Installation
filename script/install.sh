#!/usr/bin/env bash
# ---------------------------------------------------------------------------------------------
# Script     : Installation of SkyWater PDK 130nm and VSLI tools like xschem, magic, ngspice...
# Description: Installation script
# Version    : 0.1
# Author     : Felipe W. Costa <costaf138@gmail.com>
# Date       : 16/05/2024
# License    : GNU/GPL v3.0
# ---------------------------------------------------------------------------------------------
# Use        : ~/SkyWater-SKY130-PDK-and-Tools-Installation/script/install.sh
# ---------------------------------------------------------------------------------------------

## Update the Ubuntu OS

echo "Update of the OS"

sudo apt-get -y update

sudo apt-get -y upgrade

echo "OS was updated"

## Install tools (xschem, magic, ngspice, netgen, sky130 pdk)

### Install xschem
sudo apt-get -y xschem
which xschem && echo "xschem installation ended sucessfully!" || echo "xschem installation failed!"
which xschem && exit 0 || exit 1


### Install magic
sudo apt-get -y magic
which magic && echo "magic installation ended sucessfully!" || echo "magic installation failed!"
which magic && exit 0 || exit 1

## install ngspice
sudo apt-get -y install ngspice
which ngspice && echo "ngspice intallation ended sucessfully!" || echo "ngspice installation failed!"
which ngspice && exit 0 || exit 1

