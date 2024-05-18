# SkyWater SKY130 PDK and VLSI Tools Installation
This repository contains a step guide to set up SkyWater SKY130 PDK and some tools on Linux distro Ubuntu.

* It is recommended first of all run the `dependencies.sh` script which will install the libraries that are requested by xschem, magic and ngspice on Ubuntu Distro.
* To install the VLSI open source tools you will need to run the `install.sh` script, all the tools that will be installed is listed below:
	* xschem;
	* magic;
	* ngspice;
	* gaw;
	* netgen;
	* gnuplot;
	* sky130 pdk.
* **WARNING:** At the end of the execution of the scripts do not forget to add the following two lines into a file called `xschemrc` that could be find in this directory `~/workarea/xschem_sky130`:
	* `set SKYWATER_MODELS $TOOLS_DIR/pdk/skywater-pdk/libraries/sky130_fd_pr_ngspice/latest/models`;
	* `set SKYWATER_STDCELLS $TOOLS_DIR/pdk/skywater-pdk/libraries/sky130_fd_sc_hd/latest/cells`.
* If `xschem` do not recognize the envroinment variables you must replace them by the path of the directory.
* You can navigate to workarea directory (`~/workarea/xschem_sky130`) and run `xschem` command to explore some examples of the technology.
* This installation method was tested on Ubuntu 24.04 LTS, it must work in versions like 22.04 LTS and WSL as well.
