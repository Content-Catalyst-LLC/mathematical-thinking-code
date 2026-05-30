GHC ?= ghc

.PHONY: all run clean

all: evolution_of_algebraic_notation_demo

evolution_of_algebraic_notation_demo: Main.hs
	$(GHC) -O2 Main.hs -o evolution_of_algebraic_notation_demo

run: evolution_of_algebraic_notation_demo
	mkdir -p ../outputs/tables
	./evolution_of_algebraic_notation_demo

clean:
	rm -f evolution_of_algebraic_notation_demo Main.hi Main.o
