FILES:= $(wildcard rtl/*.vhd)
ENTITYFILES := $(shell grep -i -l "^entity " rtl/*.vhd)

ifneq ($(wildcard vmakefile),) 
    include vmakefile
endif


compile: rtl/projectname_component.vhd
	test -d work || vlib work

	@#Sadly Modelsim does not sort out the order of pkgs 
	@#May have to specify it explicitly
	vcom -93 +acc -just p rtl/*.vhd

	vcom -93 +acc -just e rtl/*.vhd
	vcom -93 +acc -just a rtl/*.vhd

	test ! -e vmakefile || rm -f vmakefile
	@#Create a makefile for incremental compile
	vmake work > vmakefile
	@#vcom -force_refresh
	\find work -exec touch '{}' \;

sim: whole_library
	vsim top -c

gui: whole_library
	vsim -debugDB top

clean: rmcache
	rm -rf work 
	rm -rf transcript vmakefile vsim.* 

.PHONY: whole_library rmcache

indent: rmcache
	$(foreach f, $(FILES),$(shell emacs -batch \
		-l emacs_vhdl_project_config.el $(f) \
		-f vhdl-beautify-buffer -f save-buffer))
	$(foreach f, $(FILES),$(shell emacs -batch \
		-l emacs_vhdl_project_config.el $(f) \
		-f vhdl-update-sensitivity-list-buffer -f save-buffer))


component: rtl/projectname_component.vhd

rtl/projectname_component.vhd: $(ENTITYFILES) rmcache
	rm -f rtl/projectname_components.vhd
	emacs -batch -l emacs_vhdl_project_config.el -l vhdl-mode -project projectname \
		rtl/top-e.vhd -f vhdl-compose-components-package

clean_conf: rmcache
	rm -f rtl/*_cfg.vhd

conf: clean_conf
	$(foreach f, $(FILES),$(shell emacs -q -batch -l emacs_vhdl_project_config.el $(f) \
	-eval '(re-search-forward "architecture" nil)' \
	-eval '(end-of-line)' -eval '(vhdl-compose-configuration)'))

rmcache:
	rm -f .emacs-vhdl-cache*
	rm -f rtl/.emacs-vhdl-cache*

