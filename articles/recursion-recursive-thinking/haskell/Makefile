GHC ?= ghc

.PHONY: all run clean

all: recursion_recursive_thinking_demo

recursion_recursive_thinking_demo: Main.hs
	$(GHC) -O2 Main.hs -o recursion_recursive_thinking_demo

run: recursion_recursive_thinking_demo
	mkdir -p ../outputs/tables
	./recursion_recursive_thinking_demo

clean:
	rm -f recursion_recursive_thinking_demo Main.hi Main.o
