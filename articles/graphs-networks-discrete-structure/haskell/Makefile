GHC ?= ghc

.PHONY: all run clean

all: graphs_networks_demo

graphs_networks_demo: Main.hs
	$(GHC) -O2 Main.hs -o graphs_networks_demo

run: graphs_networks_demo
	mkdir -p ../outputs/tables
	./graphs_networks_demo

clean:
	rm -f graphs_networks_demo Main.hi Main.o
