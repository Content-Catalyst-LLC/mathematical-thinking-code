GHC ?= ghc

.PHONY: all run clean

all: symbolic_representation_demo

symbolic_representation_demo: Main.hs
	$(GHC) -O2 Main.hs -o symbolic_representation_demo

run: symbolic_representation_demo
	mkdir -p ../outputs/tables
	./symbolic_representation_demo

clean:
	rm -f symbolic_representation_demo Main.hi Main.o
