GHC ?= ghc

.PHONY: all run clean

all: historical_understanding_demo

historical_understanding_demo: Main.hs
	$(GHC) -O2 Main.hs -o historical_understanding_demo

run: historical_understanding_demo
	mkdir -p ../outputs/tables
	./historical_understanding_demo

clean:
	rm -f historical_understanding_demo Main.hi Main.o
