GHC ?= ghc

.PHONY: all run clean

all: foundations_structure_demo

foundations_structure_demo: Main.hs
	$(GHC) -O2 Main.hs -o foundations_structure_demo

run: foundations_structure_demo
	mkdir -p ../outputs/tables
	./foundations_structure_demo

clean:
	rm -f foundations_structure_demo Main.hi Main.o
