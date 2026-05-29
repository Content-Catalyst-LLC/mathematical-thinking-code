GHC ?= ghc

.PHONY: all run clean

all: conjecture_discovery_demo

conjecture_discovery_demo: Main.hs
	$(GHC) -O2 Main.hs -o conjecture_discovery_demo

run: conjecture_discovery_demo
	mkdir -p ../outputs/tables
	./conjecture_discovery_demo

clean:
	rm -f conjecture_discovery_demo Main.hi Main.o
