#!/usr/bin/env bash
# ---------------------------------------------------------------------------------------------
# Script     : Installation of SkyWater PDK 130nm and VLSI tools like xschem, magic, ngspice...
# Description: Installation script
# Version    : 0.1
# Author     : Felipe W. Costa <costaf138@gmail.com>
# Date       : 16/05/2024
# License    : MIT License
# ---------------------------------------------------------------------------------------------
# Use        : ~/SkyWater-SKY130-PDK-and-Tools-Installation/script/install.sh
# ---------------------------------------------------------------------------------------------

## Update the Ubuntu Distro

echo "Updating of Ubuntu Distro..."
sudo apt-get -y update
sudo apt-get -y upgrade
echo "Ubuntu Distro was updated!"

echo "Solving some dependencies..."
sudo apt-get -y install make xterm vim-gtk3 adms autoconf libgtk-3-dev
[[ $? -ne 0 ]] && echo "WARNING: Failed to install the dependencies!" && exit 1
echo "Dependencies fixed!"

## Install tools (xschem, magic, ngspice, netgen, sky130 pdk)

### Install xschem
sudo apt-get -y install xschem
which xschem && echo "xschem installation ended successfully!" || echo "xschem installation failed!"


### Install magic
sudo apt-get -y install magic
which magic && echo "magic installation ended successfully!" || echo "magic installation failed!"

### install ngspice
sudo apt-get -y install ngspice
which ngspice && echo "ngspice installation ended successfully!" || echo "ngspice installation failed!"

### install netgen
sudo apt-get -y install netgen-lvs
which netgen-lvs && echo "netgen installation ended successfully!" || echo "netgen installation failed!"

### install gnuplot
sudo apt-get -y install gnuplot
which gnuplot && echo "gnuplot installation ended successfully!" || echo "gnuplot installation failed!"

echo "Creating VLSI tools directory..."

cd /
sudo mkdir vlsi
cd vlsi
sudo mkdir tools
sudo mkdir pdk
cd tools

### Install gaw
sudo wget https://github.com/edneymatheus/gaw3-20220315/raw/main/gaw3-20220315.tar.gz -O gaw3-20220315.tar.gz
[[ ! -f "gaw3-20220315.tar.gz" ]] && echo "WARNING: Failed to download gaw!" && exit 1
sudo tar zxvpf gaw3-20220315.tar.gz
cd gaw3-20220315
sudo ./configure
sudo make
sudo make install
which gaw && echo "gaw installation ended successfully!" || echo "gaw installation failed!"

## Setting up the sky130 pdk

export TOOLS_DIR=/vlsi
export PDK_ROOT=/vlsi/pdk

echo "Exporting environment variables..."
echo "export TOOLS_DIR=/vlsi" >> ~/.bashrc
echo "export PDK_ROOT=/vlsi/pdk" >> ~/.bashrc
source ~/.bashrc

if [ -n "$TOOLS_DIR" ]; then
	echo "The environment variable TOOLS_DIR was set correctly!"
else
	echo "The environment variable TOOLS_DIR was not set correctly! "
	exit 1
fi

if [ -n "$PDK_ROOT" ]; then
	echo "The environment variable PDK_ROOT was set correctly!"
else
	echo "The environment variable PDK_ROOT was not set correctly! "
	exit 1
fi


echo "Downloading libraries..."
cd $PDK_ROOT
if [ ! -d "skywater-pdk" ]; then
    sudo git clone https://github.com/google/skywater-pdk
    cd skywater-pdk
    sudo git submodule init libraries/sky130_fd_pr/latest
    sudo git submodule init libraries/sky130_fd_sc_hd/latest
    sudo git submodule update
    cd ..
else
    echo "skywater-pdk directory already exists, skipping clone..."
fi

echo "Cloning Open_PDKs tool and setting up for tool flow compatibility..."
if [ ! -d "open_pdks" ]; then
    sudo git clone https://github.com/RTimothyEdwards/open_pdks.git
    cd open_pdks
    sudo git checkout 32cdb2097fd9a629c91e8ea33e1f6de08ab25946
    sudo ./configure --with-sky130-source=$PDK_ROOT/skywater-pdk/libraries --with-sky130-local-path=$PDK_ROOT
    cd sky130
    sudo make
    sudo make install-local
    cd ..
else
    echo "Open_PDKs directory already exists, skipping clone..."
fi

[ -d "$PDK_ROOT/skywater-pdk" ] && echo "Skywater PDK cloned successfully!" || echo "Skywater PDK cloning failed!"
[ -d "$PDK_ROOT/open_pdks" ] && echo "Open_PDKs cloned and set up successfully!" || echo "Open_PDKs setup failed!"

cd ~
mkdir workarea
cd workarea
git clone https://github.com/StefanSchippers/xschem_sky130.git
cd $TOOLS_DIR/pdk/skywater-pdk/libraries
sudo cp -r sky130_fd_pr sky130_fd_pr_ngspice
cd sky130_fd_pr_ngspice/latest
sudo patch -p2 < ~/workarea/xschem_sky130/sky130_fd_pr.patch
cd ~/workarea
cp $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc .magicrc

cat >> .spiceinit << 'END'
set ngbehavior=hs
END

cd xschem_sky130
cat >> .spiceinit << 'END'
set ngbehavior=hs
END

echo "Add the following lines to the file called xschemrc to complete the set up..."
echo "set SKYWATER_MODELS $TOOLS_DIR/pdk/skywater-pdk/libraries/sky130_fd_pr_ngspice/latest/models"
echo "set SKYWATER_STDCELLS $TOOLS_DIR/pdk/skywater-pdk/libraries/sky130_fd_sc_hd/latest/cells"
