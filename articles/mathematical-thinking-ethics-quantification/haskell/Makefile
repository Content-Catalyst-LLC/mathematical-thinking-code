GHC ?= ghc

.PHONY: all run clean

all: quantification_ethics_demo

quantification_ethics_demo: Main.hs
	$(GHC) -O2 Main.hs -o quantification_ethics_demo

run: quantification_ethics_demo
	mkdir -p ../outputs/tables
	./quantification_ethics_demo

clean:
	rm -f quantification_ethics_demo Main.hi Main.o
