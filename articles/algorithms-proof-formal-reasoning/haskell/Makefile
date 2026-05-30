GHC ?= ghc

.PHONY: all run clean

all: algorithms_proof_formal_reasoning_demo

algorithms_proof_formal_reasoning_demo: Main.hs
	$(GHC) -O2 Main.hs -o algorithms_proof_formal_reasoning_demo

run: algorithms_proof_formal_reasoning_demo
	mkdir -p ../outputs/tables
	./algorithms_proof_formal_reasoning_demo

clean:
	rm -f algorithms_proof_formal_reasoning_demo Main.hi Main.o
