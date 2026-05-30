GHC ?= ghc

.PHONY: all run clean

all: visual_proof_demo

visual_proof_demo: Main.hs
	$(GHC) -O2 Main.hs -o visual_proof_demo

run: visual_proof_demo
	mkdir -p ../outputs/tables
	./visual_proof_demo

clean:
	rm -f visual_proof_demo Main.hi Main.o
