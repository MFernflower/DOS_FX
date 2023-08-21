    FASM_PATH ?= /usr/local/bin/fasm
    
	# All
	all: clean build 
	 
	# Clean
	clean:
		rm -f *.com
	 
	# tools needed to build the code on linux
	setupdevenv:
		sudo apt-get install fasm dosbox
	 
	# Build
	build:
		$(FASM_PATH) *.asm
		
	# Package
	package:
		tar -cvf fasm_project.tar *.asm *.com
