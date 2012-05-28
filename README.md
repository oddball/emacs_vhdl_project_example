Emacs VHDL project example
==========================
#do
source sourceme.csh
#or if you are lucky enough to use bash
source sourceme.bash

# to compile and generate the components package
make

#to see the hierachy in the sidebar 
emacs -q -l emacs_vhdl_project_config_gui.el rtl/top-e.vhd 

#touch one file and see the incremental compile
touch rtl/block_bb-rtl-a.vhd
make

#generate the configurations
make conf
