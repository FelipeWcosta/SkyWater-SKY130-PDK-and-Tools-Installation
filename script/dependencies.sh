#!/usr/bin/env bash
# --------------------------------------------------------------------------
# Script     : Solving some dependencies that could occur in the VLSI set up
# Description: Fixing dependencies
# Version    : 0.1
# Author     : Felipe W. Costa <costaf138@gmail.com>
# Date       : 17/05/2024
# License    : GNU/GPL v3.0
# --------------------------------------------------------------------------
# Use        : ~/SkyWater-SKY130-PDK-and-Tools-Installation/script
# --------------------------------------------------------------------------

echo "Dependencies from xschem..."
sudo apt-get -y install libx11-6 libx11-dev libxrender1 libxrender-dev libxcb1 libx11-xcb-dev libcairo2 libcairo2-dev tcl8.6 tcl8.6-dev tk8.6 tk8.6-dev flex bison libxpm4 libxpm-dev gawk mawk tcl-tclreadline xterm vim-gtk

[[ $? -ne 0 ]] && echo "WARNING: The dependencies was not fixed" && exit 1

echo "xschem dependencies was fixed!"

echo "Dependencies from magic..."
sudo apt-get -y install m4 tcsh csh libx11-dev tcl-dev tk-dev libcairo2-dev mesa-common-dev libglu1-mesa-dev libncurses-dev

[[ $? -ne 0 ]] && echo "WARNING: The dependencies was not fixed" && exit 1

echo "magic dependencies was fixed!"

echo "Dependencies from ngspice..."
sudo apt-get -y install adms autoconf libtool libxaw7-dev build-essential libc6-dev
sudo apt update
sudo apt upgrade
sudo apt-get -y install manpages-dev man-db manpages-posix-dev libreadline6-dev
sudo apt-get update -y

[[ $? -ne 0 ]] && echo "WARNING: The dependencies was not fixed" && exit 1

echo "ngspice dependencies was fixed!"[[ $? -ne 0 ]] && echo "WARNING: The dependencies was not fixed" && exit 1

echo "magic dependencies was fixed!"

