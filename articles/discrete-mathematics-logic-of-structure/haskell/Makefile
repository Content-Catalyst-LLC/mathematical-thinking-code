GHC ?= ghc

.PHONY: all run clean

all: discrete_structure_demo

discrete_structure_demo: Main.hs
	$(GHC) -O2 Main.hs -o discrete_structure_demo

run: discrete_structure_demo
	mkdir -p ../outputs/tables
	./discrete_structure_demo

clean:
	rm -f discrete_structure_demo Main.hi Main.o
