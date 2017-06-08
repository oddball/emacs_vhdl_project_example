Emacs VHDL project example
==========================

Show case incremental compile with Questasim and the excellent emacs vhdl mode hierarchy sidebar.



Configure
---------
```
#do
source sourceme.csh
#or if you are lucky enough to use bash
source sourceme.bash
```

Compile and generate the components package
-------------------------------------------
```
make
```

View hierarchy in the sidebar 
----------------------------
```
emacs -q -l emacs_vhdl_project_config_gui.el rtl/top-e.vhd 
```

![View hierarchy](pic/screen.png)


Touch one file and see the incremental compile
----------------------------------------------
```
touch rtl/block_bb-rtl-a.vhd
make
```

Generate the configurations
---------------------------
```
make conf
```
