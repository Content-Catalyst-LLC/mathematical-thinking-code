GHC ?= ghc

.PHONY: all run clean

all: sets_relations_functions_demo

sets_relations_functions_demo: Main.hs
	$(GHC) -O2 Main.hs -o sets_relations_functions_demo

run: sets_relations_functions_demo
	mkdir -p ../outputs/tables
	./sets_relations_functions_demo

clean:
	rm -f sets_relations_functions_demo Main.hi Main.o
