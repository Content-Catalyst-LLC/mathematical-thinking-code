GHC ?= ghc

.PHONY: all run clean

all: scientific_modeling_demo

scientific_modeling_demo: Main.hs
	$(GHC) -O2 Main.hs -o scientific_modeling_demo

run: scientific_modeling_demo
	mkdir -p ../outputs/tables
	./scientific_modeling_demo

clean:
	rm -f scientific_modeling_demo Main.hi Main.o
