#!/usr/bin/env bash
# ---------------------------------------------------------------------------------------------
# Script     : Installation of SkyWater PDK 130nm and VLSI tools like xschem, magic, ngspice...
# Description: Installation script
# Version    : 0.2
# Author     : Felipe W. Costa <costaf138@gmail.com>
# Date       : 18/05/2024
# License    : MIT License
# ---------------------------------------------------------------------------------------------
# Use        : ~/SkyWater-SKY130-PDK-and-Tools-Installation/script/install.sh
# ---------------------------------------------------------------------------------------------

## Update the Ubuntu Distro

echo "Updating of Ubuntu Distro..."
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt -y update
sudo apt -y upgrade
echo "Ubuntu Distro was updated!"

echo "Solving some dependencies..."
sudo apt-get -y install make xterm vim-gtk3 adms autoconf libgtk-3-dev
[[ $? -ne 0 ]] && echo "WARNING: Failed to install the dependencies!" && exit 1
echo "Dependencies fixed!"

echo "Creating VLSI tools directory..."

cd ~
if [ ! -d "vlsi" ]; then
	mkdir vlsi
else
	echo "vlsi directory already exists. Skipping..."
fi
cd ~/vlsi
if [ ! -d "tools" ]; then
	mkdir tools
else
	echo "/vlsi/tools directory already exists. Skipping..."
fi
if [ ! -d "pdk" ]; then
	mkdir pdk
else
	echo "/vlsi/pdk directory already exists. Skipping..."
fi

## Install tools (xschem, magic, ngspice, netgen, sky130 pdk)


### Install xschem
cd ~/vlsi/tools
git clone https://github.com/StefanSchippers/xschem
cd xschem
sudo ./configure
sudo make
sudo make install
which xschem && echo "xschem installation ended successfully!" || echo "xschem installation failed!"


### Install magic
cd ~/vlsi/tools
wget http://opencircuitdesign.com/magic/archive/magic-8.3.78.tgz
tar zxvpf magic-8.3.78.tgz
cd magic-8.3.78
sudo ./configure
sudo make
sudo make install
which magic && echo "magic installation ended successfully!" || echo "magic installation failed!"

### Install ngspice
cd ~/vlsi/tools
wget -O ngspice-33.tar.gz https://sourceforge.net/projects/ngspice/files/ng-spice-rework/old-releases/33/ngspice-33.tar.gz/download
tar zxvpf ngspice-33.tar.gz
cd ngspice-33
./autogen.sh --adms
mkdir release
cd release
sudo ../configure --with-x --enable-xspice --disable-debug --enable-cider --with-readline=yes --enable-adms CFLAGS=-std=c99
sudo make -j$(nproc) CFLAGS=-std=c99
sudo make install
which ngspice && echo "ngspice installation ended successfully!" || echo "ngspice installation failed!"

### Install netgen
cd ~/vlsi/tools
wget http://opencircuitdesign.com/netgen/archive/netgen-1.5.155.tgz
tar zxvpf netgen-1.5.155.tgz
cd netgen-1.5.155
sudo ./configure
sudo make
sudo make install
which netgen && echo "netgen installation ended successfully!" || echo "netgen installation failed!"

### Install gnuplot
sudo apt-get -y install gnuplot
which gnuplot && echo "gnuplot installation ended successfully!" || echo "gnuplot installation failed!"

### Install gaw
cd ~/vlsi/tools
wget https://github.com/edneymatheus/gaw3-20220315/raw/main/gaw3-20220315.tar.gz -O gaw3-20220315.tar.gz
[[ ! -f "gaw3-20220315.tar.gz" ]] && echo "WARNING: Failed to download gaw!" && exit 1
tar zxvpf gaw3-20220315.tar.gz
cd gaw3-20220315
sudo ./configure
sudo make
sudo make install
which gaw && echo "gaw installation ended successfully!" || echo "gaw installation failed!"

## Setting up the sky130 pdk

export TOOLS_DIR=~/vlsi
export PDK_ROOT=~/vlsi/pdk

echo "Exporting environment variables..."
echo "export TOOLS_DIR=~/vlsi" >> ~/.bashrc
echo "export PDK_ROOT=~/vlsi/pdk" >> ~/.bashrc
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
    git clone https://github.com/google/skywater-pdk
    cd skywater-pdk
    git submodule init libraries/sky130_fd_pr/latest
    git submodule init libraries/sky130_fd_sc_hd/latest
    git submodule update
    cd ..
else
    echo "skywater-pdk directory already exists, skipping clone..."
fi

cd $PDK_ROOT
echo "Cloning Open_PDKs tool and setting up for tool flow compatibility..."
if [ ! -d "open_pdks" ]; then
    git clone https://github.com/RTimothyEdwards/open_pdks.git
    cd open_pdks
    git checkout 32cdb2097fd9a629c91e8ea33e1f6de08ab25946
    ./configure --with-sky130-source=$PDK_ROOT/skywater-pdk/libraries --with-sky130-local-path=$PDK_ROOT
    cd sky130
    make
    make install-local
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
cp -r sky130_fd_pr sky130_fd_pr_ngspice
cd sky130_fd_pr_ngspice/latest
patch -p2 < ~/workarea/xschem_sky130/sky130_fd_pr.patch
cd ~/workarea
cp $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc ~/workarea/xschem_sky130/.magicrc

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
