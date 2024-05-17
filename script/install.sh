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

echo "Update of the OS."
sudo apt-get -y update
sudo apt-get -y upgrade
echo "OS was updated!"

echo "Solving some dependencies."
sudo apt-get -y install make xterm
[[ $? -ne 0 ]] && echo "WARNING: Failed install the dependencies!" && exit 1
echo "Dependencies fixed!"

## Install tools (xschem, magic, ngspice, netgen, sky130 pdk)

### Install xschem
sudo apt-get -y xschem
which xschem && echo "xschem installation ended sucessfully!" || echo "xschem installation failed!"
which xschem && exit 0 || exit 1


### Install magic
sudo apt-get -y magic
which magic && echo "magic installation ended sucessfully!" || echo "magic installation failed!"
which magic && exit 0 || exit 1

### install ngspice
sudo apt-get -y install ngspice
which ngspice && echo "ngspice installation ended sucessfully!" || echo "ngspice installation failed!"
which ngspice && exit 0 || exit 1

### install netgen
sudo apt-get -y install netgen
which netgen && echo "netgen installation ended sucessfully!" || echo "netgen installation failed!"
which netgen && exit 0 || exit 1

echo "Creating VSLI tools directory"

cd /
mkdir vlsi
cd vlsi
mkdir tools
cd tools
### wget http://opencircuitdesign.com/netgen/archive/netgen-1.5.155.tgz
### tar zxvpf netgen-1.5.155.tgz
### cd netgen-1.5.155
### ./configure
### make
### make install
### which netgen && echo "netgen intallation ended sucessfully!" || echo "netgen installation failed!"
### which netgen && exit 0 || exit 1

### Install gaw
wget https://github.com/edneymatheus/gaw3-20220315/raw/main/gaw3-20220315.tar.gz -O gaw3-20220315.tar.gz
[[ ! -f "gaw3-20220315.tar.gz" ]] && echo "WARNING: Failed to download gaw!" && exit 1
tar zxvpf gaw3-20220315.tar.gz
cd gaw3-20220315
./configure
make
make install
which gaw && echo "gaw installation ended sucessfully!" || echo "gaw installation failed!"
which gaw && exit 0 || exit 1




