GHC ?= ghc

.PHONY: all run clean

all: algebraic_thinking_demo

algebraic_thinking_demo: Main.hs
	$(GHC) -O2 Main.hs -o algebraic_thinking_demo

run: algebraic_thinking_demo
	mkdir -p ../outputs/tables
	./algebraic_thinking_demo

clean:
	rm -f algebraic_thinking_demo Main.hi Main.o
