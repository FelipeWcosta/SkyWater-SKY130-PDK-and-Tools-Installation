#!/usr/bin/env bash
# -------------------------------------------------------------------------------
# Script     : Solving some dependencies that could occur in the VLSI set up
# Description: Fixing dependencies
# Version    : 0.3
# Author     : Felipe W. Costa <costaf138@gmail.com>
# Date       : 19/05/2024
# License    : MIT License
# --------------------------------------------------------------------------------
# Use        : ~/vlsi-tools/script/dependencies.sh
# --------------------------------------------------------------------------------
echo "Updating GNU/Linux..."
sudo apt-get -y update && sudo apt-get -y upgrade
echo "GNU/Linux was updated!"

echo "Dependencies from xschem..."
sudo apt-get -y install libx11-6 libx11-dev libxrender1 libxrender-dev libxcb1 libx11-xcb-dev libcairo2 libcairo2-dev tcl8.6 tcl8.6-dev tk8.6 tk8.6-dev flex bison libxpm4 libxpm-dev gawk mawk tcl-tclreadline xterm vim-gtk3 make

[[ $? -ne 0 ]] && echo "WARNING: The dependencies was not fixed" && exit 1

echo "xschem dependencies was fixed!"

echo "Dependencies from magic..."
sudo apt-get -y install m4 tcsh csh libx11-dev tcl-dev tk-dev libcairo2-dev mesa-common-dev libglu1-mesa-dev libncurses-dev

[[ $? -ne 0 ]] && echo "WARNING: The dependencies was not fixed" && exit 1

echo "magic dependencies was fixed!"

echo "Dependencies from ngspice..."
sudo apt-get -y install autoconf libtool libxaw7-dev build-essential libc6-dev
sudo apt-get -y install libreadline-dev
sudo apt update
sudo apt upgrade
sudo apt-get -y install manpages-dev man-db manpages-posix-dev libreadline6-dev
sudo apt-get update -y


[[ $? -ne 0 ]] && echo "WARNING: The dependencies was not fixed" && exit 1

echo "ngspice dependencies was fixed!"

echo "Dependencies from adms"
sudo apt-get -y install automake
sudo apt-get -y install gperf
sudo apt-get -y install libxm12 libxm12-dev
sudo apt-get -y install libgd-perl

[[ $? -ne 0  ]] && echo "WARNING: The dependencies was not fixed" && exit 1

echo "adms dependencies fixed!"
