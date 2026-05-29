GHC ?= ghc

.PHONY: all run clean

all: non_algorithmic_reasoning_demo

non_algorithmic_reasoning_demo: Main.hs
	$(GHC) -O2 Main.hs -o non_algorithmic_reasoning_demo

run: non_algorithmic_reasoning_demo
	mkdir -p ../outputs/tables
	./non_algorithmic_reasoning_demo

clean:
	rm -f non_algorithmic_reasoning_demo Main.hi Main.o
