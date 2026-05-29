GHC ?= ghc

.PHONY: all run clean

all: number_pattern_origins_demo

number_pattern_origins_demo: Main.hs
	$(GHC) -O2 Main.hs -o number_pattern_origins_demo

run: number_pattern_origins_demo
	mkdir -p ../outputs/tables
	./number_pattern_origins_demo

clean:
	rm -f number_pattern_origins_demo Main.hi Main.o
