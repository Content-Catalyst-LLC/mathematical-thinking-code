GHC ?= ghc

.PHONY: all run clean

all: proof_assistant_demo

proof_assistant_demo: Main.hs
	$(GHC) -O2 Main.hs -o proof_assistant_demo

run: proof_assistant_demo
	mkdir -p ../outputs/tables
	./proof_assistant_demo

clean:
	rm -f proof_assistant_demo Main.hi Main.o
